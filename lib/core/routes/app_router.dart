import 'package:flutter/material.dart';
import 'package:gradelens/features/cgpa/screens/cgpa_screen.dart';
import 'package:gradelens/features/content/screens/guide_pages.dart';
import 'package:gradelens/features/faq/screens/faq_screen.dart';
import 'package:gradelens/features/gpa/screens/gpa_screen.dart';
import 'package:gradelens/features/home/screens/home_screen.dart';
import 'package:gradelens/features/legal/screens/legal_pages.dart';
import 'package:gradelens/features/not_found/screens/not_found_screen.dart';
import 'package:gradelens/features/settings/screens/settings_screen.dart';
import 'package:gradelens/services/analytics_service.dart';
import 'package:gradelens/features/splash/screens/splash_screen.dart';

class AppRoutes {
  const AppRoutes._();

  static const splash = '/';
  static const home = '/home';
  static const gpa = '/gpa';
  static const cgpa = '/cgpa';
  static const settings = '/settings';
  static const about = '/about';
  static const privacyPolicy = '/privacy-policy';
  static const contact = '/contact';
  static const terms = '/terms';
  static const faq = '/faq';
  static const howGpaIsCalculated = '/guides/how-gpa-is-calculated';
  static const howCgpaIsCalculated = '/guides/how-cgpa-is-calculated';
  static const gpaVsCgpa = '/guides/gpa-vs-cgpa';
  static const semesterPlanning = '/guides/semester-planning';
  static const notFound = '/404';

  static const all = <String>{
    splash,
    home,
    gpa,
    cgpa,
    settings,
    about,
    privacyPolicy,
    contact,
    terms,
    faq,
    howGpaIsCalculated,
    howCgpaIsCalculated,
    gpaVsCgpa,
    semesterPlanning,
  };
}

class AppRouter {
  const AppRouter._();

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    final routeName = settings.name ?? AppRoutes.splash;
    final Widget page = switch (routeName) {
      AppRoutes.splash => const SplashScreen(),
      AppRoutes.home => const HomeScreen(),
      AppRoutes.gpa => const GpaScreen(),
      AppRoutes.cgpa => const CgpaScreen(),
      AppRoutes.settings => const SettingsScreen(),
      AppRoutes.about => const AboutPage(),
      AppRoutes.privacyPolicy => const PrivacyPolicyPage(),
      AppRoutes.contact => const ContactPage(),
      AppRoutes.terms => const TermsPage(),
      AppRoutes.faq => const FaqScreen(),
      AppRoutes.howGpaIsCalculated => const HowGpaIsCalculatedPage(),
      AppRoutes.howCgpaIsCalculated => const HowCgpaIsCalculatedPage(),
      AppRoutes.gpaVsCgpa => const GpaVsCgpaPage(),
      AppRoutes.semesterPlanning => const SemesterPlanningPage(),
      _ => NotFoundScreen(routeName: routeName),
    };

    AnalyticsService.trackPageView(routeName);
    return _buildRoute(page, settings);
  }

  static Route<dynamic> onUnknownRoute(RouteSettings settings) {
    return _buildRoute(
      NotFoundScreen(routeName: settings.name ?? 'unknown'),
      settings,
    );
  }

  static Route<dynamic> _buildRoute(Widget page, RouteSettings settings) {
    return PageRouteBuilder<dynamic>(
      settings: settings,
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        final curvedAnimation = CurvedAnimation(
          parent: animation,
          curve: Curves.easeOutCubic,
        );
        return FadeTransition(
          opacity: curvedAnimation,
          child: child,
        );
      },
    );
  }
}
