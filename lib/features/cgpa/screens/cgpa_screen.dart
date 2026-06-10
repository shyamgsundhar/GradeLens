import 'package:flutter/material.dart';
import 'package:gradelens/ads/adsense_banner.dart';
import 'package:gradelens/core/utils/ui_feedback.dart';
import 'package:gradelens/core/utils/formatters.dart';
import 'package:gradelens/models/semester_model.dart';
import 'package:gradelens/providers/app_state.dart';
import 'package:gradelens/services/pdf_export_service.dart';
import 'package:gradelens/widgets/app_shell.dart';
import 'package:gradelens/widgets/responsive_page.dart';
import 'package:gradelens/widgets/stat_card.dart';
import 'package:gradelens/widgets/text_input_dialog.dart';
import 'package:provider/provider.dart';

class CgpaScreen extends StatelessWidget {
  const CgpaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AppState>();
    final cgpa = state.cgpa;

    return AppShell(
      title: 'CGPA Tracker',
      child: ResponsivePage(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            LayoutBuilder(
              builder: (context, constraints) {
                final columns = constraints.maxWidth < 760 ? 1 : 3;
                return GridView.count(
                  crossAxisCount: columns,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  childAspectRatio: columns == 1 ? 3.4 : 2.1,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    StatCard(
                      label: 'CGPA',
                      value: Formatters.score(cgpa.cgpa),
                      icon: Icons.stacked_line_chart_outlined,
                    ),
                    StatCard(
                      label: 'Total Credits',
                      value: '${cgpa.totalCredits}',
                      icon: Icons.school_outlined,
                    ),
                    StatCard(
                      label: 'Semester Count',
                      value: '${cgpa.semesterCount}',
                      icon: Icons.calendar_month_outlined,
                    ),
                  ],
                );
              },
            ),
            const AdsenseBanner(height: 120),
            const SizedBox(height: 20),
            if (state.semesters.isEmpty)
              const _EmptyState()
            else
              ...state.semesters.map((semester) => _SemesterCard(semester: semester)),
          ],
        ),
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.history_edu_outlined,
                size: 48,
                color: Theme.of(context).colorScheme.primary,
              ),
              const SizedBox(height: 12),
              Text(
                'No semesters saved yet',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 8),
              const Text('Calculate a GPA and save it to start tracking CGPA.'),
            ],
          ),
        ),
      ),
    );
  }
}

class _SemesterCard extends StatefulWidget {
  const _SemesterCard({required this.semester});

  final SemesterModel semester;

  @override
  State<_SemesterCard> createState() => _SemesterCardState();
}

class _SemesterCardState extends State<_SemesterCard> {
  bool _isDownloading = false;
  bool _isDeleting = false;

  @override
  Widget build(BuildContext context) {
    final state = context.read<AppState>();
    final semester = widget.semester;

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: LayoutBuilder(
            builder: (context, constraints) {
              final narrow = constraints.maxWidth < 720;
              final details = Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    semester.semesterName,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w800,
                        ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${semester.universityName} - ${Formatters.date(semester.createdAt)}',
                  ),
                ],
              );
              final gpaText = Text(
                'GPA ${Formatters.score(semester.gpa)}',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
              );
              final creditsText = Text('${semester.credits} credits');
              final actions = Wrap(
                spacing: 6,
                children: [
                  IconButton(
                    tooltip: 'View semester',
                    onPressed: () => _viewSemester(context, semester),
                    icon: const Icon(Icons.visibility_outlined),
                  ),
                  IconButton(
                    tooltip: 'Edit semester',
                    onPressed: () => _renameSemester(context, semester),
                    icon: const Icon(Icons.edit_outlined),
                  ),
                  IconButton(
                    tooltip: 'Download PDF',
                    onPressed: _isDownloading ? null : () => _downloadPdf(context),
                    icon: _isDownloading
                        ? const SizedBox(
                            width: 18,
                            height: 18,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Icon(Icons.picture_as_pdf_outlined),
                  ),
                  IconButton(
                    tooltip: 'Delete semester',
                    onPressed: _isDeleting
                        ? null
                        : () => _deleteSemester(context, state),
                    icon: _isDeleting
                        ? const SizedBox(
                            width: 18,
                            height: 18,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Icon(Icons.delete_outline),
                  ),
                ],
              );

              if (narrow) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    details,
                    const SizedBox(height: 10),
                    gpaText,
                    const SizedBox(height: 8),
                    creditsText,
                    const SizedBox(height: 8),
                    actions,
                  ],
                );
              }

              return Row(
                children: [
                  Expanded(child: details),
                  const SizedBox(width: 16),
                  gpaText,
                  const SizedBox(width: 16),
                  creditsText,
                  const SizedBox(width: 16),
                  actions,
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Future<void> _viewSemester(
    BuildContext context,
    SemesterModel semester,
  ) async {
    await showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(semester.semesterName),
          content: SizedBox(
            width: 620,
            child: SingleChildScrollView(
              child: DataTable(
                columns: const [
                  DataColumn(label: Text('Subject')),
                  DataColumn(label: Text('Grade')),
                  DataColumn(label: Text('Credits')),
                ],
                rows: semester.subjects
                    .map(
                      (subject) => DataRow(
                        cells: [
                          DataCell(Text(subject.subjectName)),
                          DataCell(Text(subject.grade)),
                          DataCell(Text('${subject.credits}')),
                        ],
                      ),
                    )
                    .toList(),
              ),
            ),
          ),
          actions: [
            FilledButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Done'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _renameSemester(
    BuildContext context,
    SemesterModel semester,
  ) async {
    final name = await showDialog<String>(
      context: context,
      builder: (context) => TextInputDialog(
        title: 'Edit Semester',
        labelText: 'Semester name',
        initialValue: semester.semesterName,
        confirmText: 'Save',
      ),
    );

    if (name == null || name.isEmpty || !context.mounted) {
      return;
    }
    try {
      await context.read<AppState>().saveSemester(
            semester.copyWith(semesterName: name),
          );
      UiFeedback.success('Semester updated.');
    } catch (_) {
      UiFeedback.error('Could not update semester.');
    }
  }

  Future<void> _downloadPdf(BuildContext context) async {
    setState(() => _isDownloading = true);
    try {
      await const PdfExportService().downloadSemesterReport(
        semester: widget.semester,
        cgpa: context.read<AppState>().cgpa,
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

  Future<void> _deleteSemester(BuildContext context, AppState state) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Semester'),
        content: Text('Delete "${widget.semester.semesterName}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Delete'),
          ),
        ],
      ),
    );

    if (confirmed != true || !mounted) {
      return;
    }

    setState(() => _isDeleting = true);
    try {
      await state.deleteSemester(widget.semester.id);
      UiFeedback.success('Semester deleted.');
    } catch (_) {
      UiFeedback.error('Could not delete semester.');
    } finally {
      if (mounted) {
        setState(() => _isDeleting = false);
      }
    }
  }
}
