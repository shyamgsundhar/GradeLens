// ignore_for_file: avoid_web_libraries_in_flutter

import 'dart:async';
import 'dart:html' as html;
import 'dart:ui_web' as ui_web;

import 'package:flutter/widgets.dart';
import 'package:gradelens/ads/ad_constants.dart';

class WebAdView extends StatefulWidget {
  const WebAdView({
    required this.slot,
    required this.height,
    required this.label,
    super.key,
  });

  final String slot;
  final double height;
  final String label;

  @override
  State<WebAdView> createState() => _WebAdViewState();
}

class _WebAdViewState extends State<WebAdView> {
  late final String _viewType =
      'gradelens-adsense-${widget.slot}-${DateTime.now().microsecondsSinceEpoch}';

  @override
  void initState() {
    super.initState();
    WebAdRuntime.initialize();
    ui_web.platformViewRegistry.registerViewFactory(_viewType, (int viewId) {
      final ad = html.Element.tag('ins')
        ..classes.add('adsbygoogle')
        ..setAttribute('data-ad-client', AdConstants.publisherId)
        ..setAttribute('data-ad-slot', widget.slot)
        ..setAttribute('data-ad-format', 'auto')
        ..setAttribute('data-full-width-responsive', 'true')
        ..style.display = 'block'
        ..style.width = '100%'
        ..style.minHeight = '${widget.height.round()}px';

      final container = html.DivElement()
        ..setAttribute('aria-label', widget.label)
        ..style.width = '100%'
        ..style.minHeight = '${widget.height.round()}px'
        ..style.overflow = 'hidden'
        ..append(ad);

      Timer.run(() => WebAdRuntime.pushAd());
      return container;
    });
  }

  @override
  Widget build(BuildContext context) {
    return HtmlElementView(viewType: _viewType);
  }
}

class WebAdRuntime {
  const WebAdRuntime._();

  static bool _initialized = false;

  static void initialize() {
    if (_initialized) {
      return;
    }
    _initialized = true;

    final scripts = html.document.querySelectorAll(
      'script[src*="pagead2.googlesyndication.com/pagead/js/adsbygoogle.js"]',
    );
    if (scripts.isNotEmpty) {
      return;
    }

    final script = html.ScriptElement()
      ..async = true
      ..src =
          'https://pagead2.googlesyndication.com/pagead/js/adsbygoogle.js?client=${AdConstants.publisherId}'
      ..crossOrigin = 'anonymous';
    html.document.head?.append(script);
  }

  static void pushAd() {
    try {
      final script = html.ScriptElement()
        ..text = '(adsbygoogle = window.adsbygoogle || []).push({});';
      html.document.body?.append(script);
    } catch (_) {
      // Ad blockers and delayed AdSense bootstrapping should not affect the app.
    }
  }
}
