import 'package:flutter/material.dart';
import 'package:gradelens/core/routes/app_router.dart';
import 'package:gradelens/core/routes/navigation_service.dart';
import 'package:gradelens/core/utils/formatters.dart';
import 'package:gradelens/providers/app_state.dart';
import 'package:gradelens/widgets/action_card.dart';
import 'package:gradelens/widgets/app_shell.dart';
import 'package:gradelens/widgets/responsive_page.dart';
import 'package:gradelens/widgets/stat_card.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AppState>();
    final cgpa = state.cgpa;

    return AppShell(
      child: ResponsivePage(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _HeroSection(cgpaText: Formatters.score(cgpa.cgpa)),
            const SizedBox(height: 28),
            _QuickStats(
              cgpa: Formatters.score(cgpa.cgpa),
              credits: '${cgpa.totalCredits}',
              semesters: '${cgpa.semesterCount}',
            ),
            const SizedBox(height: 32),
            const _CalculatorCards(),
            const SizedBox(height: 34),
            const _FeatureSection(),
            const SizedBox(height: 34),
            const _ResourceSection(),
            const SizedBox(height: 34),
            const _FaqPreview(),
            const SizedBox(height: 34),
            const _TestimonialsSection(),
          ],
        ),
      ),
    );
  }
}

class _HeroSection extends StatelessWidget {
  const _HeroSection({required this.cgpaText});

  final String cgpaText;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: scheme.primaryContainer.withValues(alpha: 0.34),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: scheme.outlineVariant),
      ),
      child: Padding(
        padding: const EdgeInsets.all(28),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final narrow = constraints.maxWidth < 760;
            final copy = Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Semantics(
                  header: true,
                  child: Text(
                    'Calculate GPA & CGPA Instantly with GradeLens',
                    style: Theme.of(context).textTheme.displaySmall?.copyWith(
                          fontWeight: FontWeight.w900,
                        ),
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  'A fast, accurate, and student-friendly GPA calculator designed for academic success.',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 22),
                Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  children: [
                    FilledButton.icon(
                      onPressed: () => NavigationService.pushNamed(AppRoutes.gpa),
                      icon: const Icon(Icons.calculate_outlined),
                      label: const Text('Start Calculating'),
                    ),
                    OutlinedButton.icon(
                      onPressed: () => NavigationService.pushNamed(
                        AppRoutes.howGpaIsCalculated,
                      ),
                      icon: const Icon(Icons.menu_book_outlined),
                      label: const Text('Learn GPA'),
                    ),
                  ],
                ),
              ],
            );

            final snapshot = Card(
              color: scheme.surface,
              child: Padding(
                padding: const EdgeInsets.all(22),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.school_outlined, color: scheme.primary, size: 36),
                    const SizedBox(height: 18),
                    Text(
                      'Current CGPA',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      cgpaText,
                      style: Theme.of(context).textTheme.displayMedium?.copyWith(
                            fontWeight: FontWeight.w900,
                            color: scheme.primary,
                          ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Saved locally for quick academic planning.',
                      style: TextStyle(color: scheme.onSurfaceVariant),
                    ),
                  ],
                ),
              ),
            );

            if (narrow) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [copy, const SizedBox(height: 18), snapshot],
              );
            }

            return Row(
              children: [
                Expanded(flex: 3, child: copy),
                const SizedBox(width: 24),
                Expanded(child: snapshot),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _QuickStats extends StatelessWidget {
  const _QuickStats({
    required this.cgpa,
    required this.credits,
    required this.semesters,
  });

  final String cgpa;
  final String credits;
  final String semesters;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final columns = constraints.maxWidth < 780 ? 1 : 3;
        return GridView.count(
          crossAxisCount: columns,
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          childAspectRatio: columns == 1 ? 3.6 : 2.2,
          children: [
            StatCard(
              label: 'Current CGPA',
              value: cgpa,
              icon: Icons.analytics_outlined,
            ),
            StatCard(
              label: 'Total Credits',
              value: credits,
              icon: Icons.school_outlined,
            ),
            StatCard(
              label: 'Semesters',
              value: semesters,
              icon: Icons.history_edu_outlined,
            ),
          ],
        );
      },
    );
  }
}

class _CalculatorCards extends StatelessWidget {
  const _CalculatorCards();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isNarrow = constraints.maxWidth < 760;
        final cards = [
          ActionCard(
            title: 'GPA Calculator',
            subtitle:
                'Select a university, add subjects, calculate GPA, and save a semester.',
            icon: Icons.calculate_outlined,
            onTap: () => NavigationService.pushNamed(AppRoutes.gpa),
          ),
          ActionCard(
            title: 'CGPA Calculator',
            subtitle:
                'Review saved semesters and see weighted CGPA across credits.',
            icon: Icons.stacked_line_chart_outlined,
            onTap: () => NavigationService.pushNamed(AppRoutes.cgpa),
          ),
        ];
        return isNarrow
            ? Column(
                children: cards
                    .map(
                      (card) => Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: card,
                      ),
                    )
                    .toList(),
              )
            : Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: cards
                    .map(
                      (card) => Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(right: 12),
                          child: card,
                        ),
                      ),
                    )
                    .toList(),
              );
      },
    );
  }
}

class _FeatureSection extends StatelessWidget {
  const _FeatureSection();

  static const _features = [
    (icon: Icons.calculate_outlined, title: 'GPA Calculator'),
    (icon: Icons.stacked_line_chart_outlined, title: 'CGPA Calculator'),
    (icon: Icons.flag_outlined, title: 'Academic Planning'),
    (icon: Icons.offline_bolt_outlined, title: 'Offline Support'),
    (icon: Icons.picture_as_pdf_outlined, title: 'Export Features'),
  ];

  @override
  Widget build(BuildContext context) {
    return _Section(
      title: 'Built for Student Workflows',
      child: LayoutBuilder(
        builder: (context, constraints) {
          final columns = constraints.maxWidth < 620
              ? 1
              : constraints.maxWidth < 920
                  ? 2
                  : 5;
          return GridView.count(
            crossAxisCount: columns,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            childAspectRatio: columns == 1 ? 4.2 : 1.2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: _features
                .map(
                  (feature) => Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(feature.icon),
                          const SizedBox(height: 10),
                          Text(
                            feature.title,
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(fontWeight: FontWeight.w800),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
                .toList(),
          );
        },
      ),
    );
  }
}

class _ResourceSection extends StatelessWidget {
  const _ResourceSection();

  static const _resources = [
    (
      title: 'How GPA Is Calculated',
      route: AppRoutes.howGpaIsCalculated,
      icon: Icons.functions_outlined
    ),
    (
      title: 'How CGPA Is Calculated',
      route: AppRoutes.howCgpaIsCalculated,
      icon: Icons.timeline_outlined
    ),
    (
      title: 'GPA vs CGPA',
      route: AppRoutes.gpaVsCgpa,
      icon: Icons.compare_arrows_outlined
    ),
    (
      title: 'Semester Planning Guide',
      route: AppRoutes.semesterPlanning,
      icon: Icons.event_note_outlined
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return _Section(
      title: 'Educational Resources',
      action: TextButton(
        onPressed: () => NavigationService.pushNamed(AppRoutes.faq),
        child: const Text('Open FAQ'),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final columns = constraints.maxWidth < 720 ? 1 : 2;
          return GridView.count(
            crossAxisCount: columns,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            childAspectRatio: columns == 1 ? 4 : 2.9,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: _resources
                .map(
                  (resource) => Card(
                    child: InkWell(
                      borderRadius: BorderRadius.circular(8),
                      onTap: () => NavigationService.pushNamed(resource.route),
                      child: Padding(
                        padding: const EdgeInsets.all(18),
                        child: Row(
                          children: [
                            Icon(resource.icon, size: 30),
                            const SizedBox(width: 14),
                            Expanded(
                              child: Text(
                                resource.title,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium
                                    ?.copyWith(fontWeight: FontWeight.w800),
                              ),
                            ),
                            const Icon(Icons.arrow_forward),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
                .toList(),
          );
        },
      ),
    );
  }
}

class _FaqPreview extends StatelessWidget {
  const _FaqPreview();

  @override
  Widget build(BuildContext context) {
    return _Section(
      title: 'Popular Questions',
      child: Column(
        children: [
          for (final question in const [
            'How is GPA calculated with credits?',
            'Why is CGPA different from average GPA?',
            'Does GradeLens store my data online?',
          ])
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const Icon(Icons.help_outline),
              title: Text(question),
              trailing: const Icon(Icons.arrow_forward),
              onTap: () => NavigationService.pushNamed(AppRoutes.faq),
            ),
        ],
      ),
    );
  }
}

class _TestimonialsSection extends StatelessWidget {
  const _TestimonialsSection();

  @override
  Widget build(BuildContext context) {
    return _Section(
      title: 'Student Feedback',
      child: LayoutBuilder(
        builder: (context, constraints) {
          final columns = constraints.maxWidth < 760 ? 1 : 3;
          return GridView.count(
            crossAxisCount: columns,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            childAspectRatio: columns == 1 ? 3.8 : 1.65,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: const [
              _TestimonialCard(
                quote: 'A cleaner way to plan semester targets.',
                name: 'Student feedback placeholder',
              ),
              _TestimonialCard(
                quote: 'The credit-weighted view makes results easier to trust.',
                name: 'Campus user placeholder',
              ),
              _TestimonialCard(
                quote: 'Fast enough to use before advising meetings.',
                name: 'Academic planning placeholder',
              ),
            ],
          );
        },
      ),
    );
  }
}

class _TestimonialCard extends StatelessWidget {
  const _TestimonialCard({required this.quote, required this.name});

  final String quote;
  final String name;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(Icons.format_quote),
            const SizedBox(height: 10),
            Expanded(child: Text(quote)),
            Text(
              name,
              style: Theme.of(context).textTheme.labelLarge,
            ),
          ],
        ),
      ),
    );
  }
}

class _Section extends StatelessWidget {
  const _Section({required this.title, required this.child, this.action});

  final String title;
  final Widget child;
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Semantics(
                header: true,
                child: Text(
                  title,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.w800,
                      ),
                ),
              ),
            ),
            if (action != null) action!,
          ],
        ),
        const SizedBox(height: 14),
        child,
      ],
    );
  }
}
