import 'package:flutter/foundation.dart';
import 'package:gradelens/ads/ad_web.dart';

class AdsenseService {
  const AdsenseService._();

  static bool get isSupported => kIsWeb;

  static void initialize() {
    if (!kIsWeb) {
      return;
    }
    WebAdRuntime.initialize();
  }
}
