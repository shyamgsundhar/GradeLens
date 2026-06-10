import 'package:flutter/material.dart';
import 'package:gradelens/core/routes/app_router.dart';
import 'package:gradelens/core/routes/navigation_service.dart';

class AppFooter extends StatelessWidget {
  const AppFooter({super.key});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final links = <({String label, String route})>[
      (label: 'About', route: AppRoutes.about),
      (label: 'Contact', route: AppRoutes.contact),
      (label: 'Privacy Policy', route: AppRoutes.privacyPolicy),
      (label: 'Terms', route: AppRoutes.terms),
      (label: 'FAQ', route: AppRoutes.faq),
    ];

    return DecoratedBox(
      decoration: BoxDecoration(
        color: scheme.surfaceContainerHighest.withValues(alpha: 0.4),
        border: Border(top: BorderSide(color: scheme.outlineVariant)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1180),
            child: Wrap(
              spacing: 18,
              runSpacing: 10,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                Text(
                  '© GradeLens',
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w800,
                      ),
                ),
                Text(
                  'Educational GPA & CGPA Platform',
                  style: TextStyle(color: scheme.onSurfaceVariant),
                ),
                ...links.map(
                  (link) => TextButton(
                    onPressed: () => NavigationService.pushNamed(link.route),
                    child: Text(link.label),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
