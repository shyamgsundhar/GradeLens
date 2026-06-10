import 'package:flutter/material.dart';
import 'package:gradelens/ads/adsense_banner.dart';
import 'package:gradelens/core/routes/navigation_service.dart';
import 'package:gradelens/core/utils/ui_feedback.dart';
import 'package:gradelens/core/utils/formatters.dart';
import 'package:gradelens/models/semester_model.dart';
import 'package:gradelens/models/subject_model.dart';
import 'package:gradelens/models/university_grade_scheme.dart';
import 'package:gradelens/providers/app_state.dart';
import 'package:gradelens/services/calculation_service.dart';
import 'package:gradelens/services/grade_scheme_service.dart';
import 'package:gradelens/services/pdf_export_service.dart';
import 'package:gradelens/widgets/app_shell.dart';
import 'package:gradelens/widgets/responsive_page.dart';
import 'package:gradelens/widgets/stat_card.dart';
import 'package:gradelens/widgets/text_input_dialog.dart';
import 'package:provider/provider.dart';

class GpaScreen extends StatefulWidget {
  const GpaScreen({super.key});

  @override
  State<GpaScreen> createState() => _GpaScreenState();
}

class _GpaScreenState extends State<GpaScreen> {
  final _calculationService = const CalculationService();
  final _pdfExportService = const PdfExportService();
  final _formKey = GlobalKey<FormState>();
  final List<_SubjectEntry> _entries = [
    _SubjectEntry(),
    _SubjectEntry(),
    _SubjectEntry(),
  ];

  UniversityGradeScheme _scheme = GradeSchemeService.schemes.first;
  GpaResult? _result;
  List<SubjectModel> _resultSubjects = [];
  bool _isSaving = false;
  bool _isDownloading = false;

  @override
  void dispose() {
    for (final entry in _entries) {
      entry.dispose();
    }
    super.dispose();
  }

  void _addSubject() {
    setState(() {
      _entries.add(_SubjectEntry());
      _result = null;
    });
  }

  void _removeSubject(int index) {
    if (_entries.length == 1) {
      return;
    }
    setState(() {
      _entries.removeAt(index).dispose();
      _result = null;
    });
  }

  void _calculate() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final subjects = _entries.map((entry) {
      final grade = entry.grade!;
      return SubjectModel(
        subjectName: entry.nameController.text.trim(),
        grade: grade,
        credits: int.parse(entry.creditsController.text),
        gradePoint: _scheme.gradeMapping[grade]!,
      );
    }).toList();

    setState(() {
      _resultSubjects = subjects;
      _result = _calculationService.calculateGpa(subjects);
    });
  }

  Future<void> _saveSemester() async {
    final result = _result;
    if (result == null) {
      return;
    }

    final name = await showDialog<String>(
      context: context,
      builder: (context) => TextInputDialog(
        title: 'Save Semester',
        labelText: 'Semester name',
        initialValue: 'Semester ${context.read<AppState>().semesters.length + 1}',
        confirmText: 'Save',
      ),
    );

    if (name == null || name.isEmpty || !mounted) {
      return;
    }

    final semester = _buildSemester(name, result);
    setState(() => _isSaving = true);
    try {
      await context.read<AppState>().saveSemester(semester);
      UiFeedback.success('Semester saved locally.');
    } catch (_) {
      UiFeedback.error('Could not save semester. Please try again.');
    } finally {
      if (mounted) {
        setState(() => _isSaving = false);
      }
    }
  }

  Future<void> _downloadPdf() async {
    final result = _result;
    if (result == null) {
      return;
    }

    setState(() => _isDownloading = true);
    try {
      final semester = _buildSemester('GPA Report', result);
      final appState = context.read<AppState>();
      final cgpa = _calculationService.calculateCgpa([
        ...appState.semesters,
        semester,
      ]);
      await _pdfExportService.downloadSemesterReport(
        semester: semester,
        cgpa: cgpa,
      );
      UiFeedback.success('PDF report is ready.');
    } catch (_) {
      UiFeedback.error('Could not create the PDF report.');
    } finally {
      if (mounted) {
        setState(() => _isDownloading = false);
      }
    }
  }

  SemesterModel _buildSemester(String name, GpaResult result) {
    return SemesterModel(
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      semesterName: name,
      universityName: _scheme.universityName,
      gpa: result.gpa,
      credits: result.totalCredits,
      createdAt: DateTime.now(),
      subjects: List.unmodifiable(_resultSubjects),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppShell(
      title: 'GPA Calculator',
      child: ResponsivePage(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _UniversitySelector(
                scheme: _scheme,
                onChanged: (scheme) => setState(() {
                  _scheme = scheme;
                  for (final entry in _entries) {
                    entry.grade = null;
                  }
                  _result = null;
                }),
              ),
              const SizedBox(height: 18),
              _SubjectTable(
                entries: _entries,
                scheme: _scheme,
                onAdd: _addSubject,
                onRemove: _removeSubject,
                onChanged: () => setState(() => _result = null),
              ),
              const SizedBox(height: 18),
              Wrap(
                spacing: 12,
                runSpacing: 12,
                children: [
                  FilledButton.icon(
                    onPressed: _calculate,
                    icon: const Icon(Icons.calculate_outlined),
                    label: const Text('Calculate GPA'),
                  ),
                  OutlinedButton.icon(
                    onPressed: NavigationService.back,
                    icon: const Icon(Icons.arrow_back),
                    label: const Text('Back'),
                  ),
                ],
              ),
              if (_result != null) ...[
                const SizedBox(height: 24),
                _ResultPanel(
                  result: _result!,
                  universityName: _scheme.universityName,
                  onSave: _saveSemester,
                  onDownload: _downloadPdf,
                  onRecalculate: _calculate,
                  isSaving: _isSaving,
                  isDownloading: _isDownloading,
                ),
                const AdsenseBanner(height: 120),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _UniversitySelector extends StatelessWidget {
  const _UniversitySelector({required this.scheme, required this.onChanged});

  final UniversityGradeScheme scheme;
  final ValueChanged<UniversityGradeScheme> onChanged;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'University',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w800,
                  ),
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<UniversityGradeScheme>(
              value: scheme,
              decoration: const InputDecoration(labelText: 'Grading system'),
              items: GradeSchemeService.schemes
                  .map(
                    (scheme) => DropdownMenuItem(
                      value: scheme,
                      child: Text(scheme.universityName),
                    ),
                  )
                  .toList(),
              onChanged: (scheme) {
                if (scheme != null) {
                  onChanged(scheme);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _SubjectTable extends StatelessWidget {
  const _SubjectTable({
    required this.entries,
    required this.scheme,
    required this.onAdd,
    required this.onRemove,
    required this.onChanged,
  });

  final List<_SubjectEntry> entries;
  final UniversityGradeScheme scheme;
  final VoidCallback onAdd;
  final ValueChanged<int> onRemove;
  final VoidCallback onChanged;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Subjects',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w800,
                        ),
                  ),
                ),
                IconButton.filledTonal(
                  tooltip: 'Add subject',
                  onPressed: onAdd,
                  icon: const Icon(Icons.add),
                ),
              ],
            ),
            const SizedBox(height: 12),
            ...List.generate(entries.length, (index) {
              final entry = entries[index];
              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    final narrow = constraints.maxWidth < 720;
                    final nameField = TextFormField(
                      controller: entry.nameController,
                      decoration: InputDecoration(
                        labelText: 'Subject ${index + 1}',
                      ),
                      onChanged: (_) => onChanged(),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Required';
                        }
                        return null;
                      },
                    );
                    final gradeField = DropdownButtonFormField<String>(
                      value: entry.grade,
                      decoration: const InputDecoration(labelText: 'Grade'),
                      items: scheme.gradeMapping.keys
                          .map(
                            (grade) => DropdownMenuItem(
                              value: grade,
                              child: Text(grade),
                            ),
                          )
                          .toList(),
                      onChanged: (grade) {
                        entry.grade = grade;
                        onChanged();
                      },
                      validator: (value) => value == null ? 'Required' : null,
                    );
                    final creditsField = TextFormField(
                      controller: entry.creditsController,
                      decoration: const InputDecoration(labelText: 'Credits'),
                      keyboardType: TextInputType.number,
                      onChanged: (_) => onChanged(),
                      validator: (value) {
                        final credits = int.tryParse(value ?? '');
                        if (credits == null || credits <= 0) {
                          return 'Use a positive number';
                        }
                        return null;
                      },
                    );
                    final removeButton = IconButton(
                      tooltip: 'Remove subject',
                      onPressed: () => onRemove(index),
                      icon: const Icon(Icons.delete_outline),
                    );

                    if (narrow) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          nameField,
                          const SizedBox(height: 10),
                          gradeField,
                          const SizedBox(height: 10),
                          creditsField,
                          Align(
                            alignment: Alignment.centerRight,
                            child: removeButton,
                          ),
                        ],
                      );
                    }
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 3,
                          child: Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: nameField,
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: gradeField,
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: creditsField,
                          ),
                        ),
                        removeButton,
                      ],
                    );
                  },
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}

class _ResultPanel extends StatelessWidget {
  const _ResultPanel({
    required this.result,
    required this.universityName,
    required this.onSave,
    required this.onDownload,
    required this.onRecalculate,
    required this.isSaving,
    required this.isDownloading,
  });

  final GpaResult result;
  final String universityName;
  final VoidCallback onSave;
  final VoidCallback onDownload;
  final VoidCallback onRecalculate;
  final bool isSaving;
  final bool isDownloading;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Result',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w800,
                  ),
            ),
            const SizedBox(height: 14),
            LayoutBuilder(
              builder: (context, constraints) {
                final columns = constraints.maxWidth < 760 ? 1 : 4;
                return GridView.count(
                  crossAxisCount: columns,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  childAspectRatio: columns == 1 ? 3.3 : 1.7,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    StatCard(
                      label: 'GPA',
                      value: Formatters.score(result.gpa),
                      icon: Icons.grade_outlined,
                    ),
                    StatCard(
                      label: 'Credits',
                      value: '${result.totalCredits}',
                      icon: Icons.confirmation_number_outlined,
                    ),
                    StatCard(
                      label: 'Weighted Points',
                      value: Formatters.score(result.weightedPoints),
                      icon: Icons.functions_outlined,
                    ),
                    StatCard(
                      label: 'University',
                      value: universityName,
                      icon: Icons.account_balance_outlined,
                    ),
                  ],
                );
              },
            ),
            const SizedBox(height: 18),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                FilledButton.icon(
                  onPressed: isSaving ? null : onSave,
                  icon: isSaving
                      ? const SizedBox(
                          width: 18,
                          height: 18,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Icon(Icons.save_outlined),
                  label: Text(isSaving ? 'Saving...' : 'Save Semester'),
                ),
                OutlinedButton.icon(
                  onPressed: isDownloading ? null : onDownload,
                  icon: isDownloading
                      ? const SizedBox(
                          width: 18,
                          height: 18,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Icon(Icons.picture_as_pdf_outlined),
                  label: Text(isDownloading ? 'Preparing PDF...' : 'Download PDF'),
                ),
                OutlinedButton.icon(
                  onPressed: onRecalculate,
                  icon: const Icon(Icons.refresh),
                  label: const Text('Recalculate'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _SubjectEntry {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController creditsController = TextEditingController();
  String? grade;

  void dispose() {
    nameController.dispose();
    creditsController.dispose();
  }
}
