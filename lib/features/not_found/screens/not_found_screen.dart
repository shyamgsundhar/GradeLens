import 'package:flutter/material.dart';
import 'package:gradelens/core/routes/app_router.dart';
import 'package:gradelens/core/routes/navigation_service.dart';
import 'package:gradelens/widgets/error_state_view.dart';

class NotFoundScreen extends StatelessWidget {
  const NotFoundScreen({required this.routeName, super.key});

  final String routeName;

  @override
  Widget build(BuildContext context) {
    return ErrorStateView(
      title: 'Page not found',
      message: 'The route "$routeName" does not exist in GradeLens.',
      onRetry: () => NavigationService.replaceWith(AppRoutes.home),
    );
  }
}
