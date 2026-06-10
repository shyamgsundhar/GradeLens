import 'package:flutter/material.dart';
import 'package:gradelens/ads/adsense_banner.dart';
import 'package:gradelens/core/routes/app_router.dart';
import 'package:gradelens/core/routes/navigation_service.dart';
import 'package:gradelens/widgets/app_shell.dart';
import 'package:gradelens/widgets/responsive_page.dart';

class ArticleSection {
  const ArticleSection({
    required this.title,
    required this.paragraphs,
    this.bullets = const [],
  });

  final String title;
  final List<String> paragraphs;
  final List<String> bullets;
}

class ArticlePage extends StatelessWidget {
  const ArticlePage({
    required this.title,
    required this.description,
    required this.sections,
    this.faqs = const [],
    super.key,
  });

  final String title;
  final String description;
  final List<ArticleSection> sections;
  final List<({String question, String answer})> faqs;

  @override
  Widget build(BuildContext context) {
    return AppShell(
      title: title,
      child: ResponsivePage(
        maxWidth: 920,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Semantics(
              header: true,
              child: Text(
                title,
                style: Theme.of(context).textTheme.displaySmall?.copyWith(
                      fontWeight: FontWeight.w900,
                    ),
              ),
            ),
            const SizedBox(height: 12),
            Text(
              description,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 28),
            for (var i = 0; i < sections.length; i++) ...[
              _ArticleSectionView(section: sections[i]),
              if (i == 1) const AdsenseBanner(height: 120),
            ],
            if (faqs.isNotEmpty) ...[
              const SizedBox(height: 10),
              Semantics(
                header: true,
                child: Text(
                  'FAQ',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.w800,
                      ),
                ),
              ),
              const SizedBox(height: 12),
              ...faqs.map(
                (faq) => ExpansionTile(
                  tilePadding: EdgeInsets.zero,
                  title: Text(faq.question),
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: Text(faq.answer),
                      ),
                    ),
                  ],
                ),
              ),
            ],
            const SizedBox(height: 24),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                OutlinedButton.icon(
                  onPressed: () => NavigationService.pushNamed(AppRoutes.gpa),
                  icon: const Icon(Icons.calculate_outlined),
                  label: const Text('GPA Calculator'),
                ),
                OutlinedButton.icon(
                  onPressed: () => NavigationService.pushNamed(AppRoutes.cgpa),
                  icon: const Icon(Icons.stacked_line_chart_outlined),
                  label: const Text('CGPA Tracker'),
                ),
                TextButton(
                  onPressed: () => NavigationService.pushNamed(AppRoutes.faq),
                  child: const Text('Read student FAQ'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _ArticleSectionView extends StatelessWidget {
  const _ArticleSectionView({required this.section});

  final ArticleSection section;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 26),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Semantics(
            header: true,
            child: Text(
              section.title,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w800,
                  ),
            ),
          ),
          const SizedBox(height: 10),
          ...section.paragraphs.map(
            (paragraph) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Text(
                paragraph,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      height: 1.55,
                    ),
              ),
            ),
          ),
          ...section.bullets.map(
            (bullet) => Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 9),
                    child: Icon(Icons.circle, size: 7),
                  ),
                  const SizedBox(width: 10),
                  Expanded(child: Text(bullet)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
