import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gradelens/ads/ad_constants.dart';
import 'package:gradelens/ads/ad_web.dart';

class AdsenseBanner extends StatelessWidget {
  const AdsenseBanner({
    this.height = 120,
    this.slot = AdConstants.mainSlot,
    this.margin = const EdgeInsets.symmetric(vertical: 24),
    super.key,
  });

  final double height;
  final String slot;
  final EdgeInsetsGeometry margin;

  @override
  Widget build(BuildContext context) {
    if (!kIsWeb) {
      return const SizedBox.shrink();
    }

    final scheme = Theme.of(context).colorScheme;
    return Semantics(
      label: 'Advertisement',
      container: true,
      child: Container(
        width: double.infinity,
        height: height,
        margin: margin,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: scheme.surfaceContainerHighest.withValues(alpha: 0.28),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: scheme.outlineVariant),
        ),
        clipBehavior: Clip.antiAlias,
        child: WebAdView(
          slot: slot,
          height: height,
          label: 'Advertisement',
        ),
      ),
    );
  }
}
