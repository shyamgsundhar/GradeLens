import 'package:flutter/material.dart';
import 'package:gradelens/ads/adsense_banner.dart';
import 'package:gradelens/core/constants/app_constants.dart';
import 'package:gradelens/core/routes/app_router.dart';
import 'package:gradelens/core/routes/navigation_service.dart';
import 'package:gradelens/providers/app_state.dart';
import 'package:gradelens/widgets/app_footer.dart';
import 'package:provider/provider.dart';

class AppShell extends StatelessWidget {
  const AppShell({required this.child, this.title, super.key});

  final Widget child;
  final String? title;

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AppState>();
    final isDark = state.themeMode == ThemeMode.dark;

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            const AppLogo(size: 34),
            const SizedBox(width: 12),
            Text(title ?? AppConstants.appName),
          ],
        ),
        actions: [
          IconButton(
            tooltip: isDark ? 'Use light theme' : 'Use dark theme',
            onPressed: () => state.setThemeMode(
              isDark ? ThemeMode.light : ThemeMode.dark,
            ),
            icon: Icon(isDark ? Icons.light_mode : Icons.dark_mode),
          ),
          IconButton(
            tooltip: 'Settings',
            onPressed: () => NavigationService.pushNamed(AppRoutes.settings),
            icon: const Icon(Icons.settings_outlined),
          ),
        ],
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                Expanded(child: child),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  child: AdsenseBanner(height: 96),
                ),
                const AppFooter(),
              ],
            ),
            if (state.isBusy)
              const Positioned(
                left: 0,
                right: 0,
                top: 0,
                child: LinearProgressIndicator(minHeight: 3),
              ),
            if (state.errorMessage != null)
              Positioned(
                left: 16,
                right: 16,
                bottom: 16,
                child: Material(
                  elevation: 8,
                  borderRadius: BorderRadius.circular(8),
                  color: Theme.of(context).colorScheme.errorContainer,
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Row(
                      children: [
                        Icon(
                          Icons.error_outline,
                          color: Theme.of(context).colorScheme.onErrorContainer,
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            state.errorMessage!,
                            style: TextStyle(
                              color:
                                  Theme.of(context).colorScheme.onErrorContainer,
                            ),
                          ),
                        ),
                        IconButton(
                          tooltip: 'Dismiss error',
                          onPressed: state.clearError,
                          icon: const Icon(Icons.close),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class AppLogo extends StatelessWidget {
  const AppLogo({this.size = 48, super.key});

  final double size;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Container(
      width: size,
      height: size,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: scheme.primary,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        'GL',
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: scheme.onPrimary,
              fontWeight: FontWeight.w800,
            ),
      ),
    );
  }
}
