import 'package:flutter/widgets.dart';

class WebAdView extends StatelessWidget {
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
  Widget build(BuildContext context) => const SizedBox.shrink();
}

class WebAdRuntime {
  const WebAdRuntime._();

  static void initialize() {}
}
