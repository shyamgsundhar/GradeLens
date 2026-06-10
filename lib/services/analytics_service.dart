class AnalyticsService {
  const AnalyticsService._();

  static bool _enabled = false;

  static void configure({required bool enabled}) {
    _enabled = enabled;
  }

  static void trackPageView(String routeName) {
    if (!_enabled) {
      return;
    }
    // Future Google Analytics or privacy-friendly analytics hook.
  }

  static void trackEvent(
    String name, {
    Map<String, Object?> parameters = const {},
  }) {
    if (!_enabled) {
      return;
    }
    // Future event tracking hook.
  }
}
