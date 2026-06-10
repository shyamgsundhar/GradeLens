import 'package:flutter/material.dart';
import 'package:gradelens/core/routes/navigation_service.dart';

class UiFeedback {
  const UiFeedback._();

  static void success(String message) => _show(message);

  static void error(String message) => _show(
        message,
        backgroundColor: Colors.red.shade700,
      );

  static void _show(String message, {Color? backgroundColor}) {
    final messenger = NavigationService.scaffoldMessengerKey.currentState;
    messenger
      ?..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: backgroundColor,
          behavior: SnackBarBehavior.floating,
        ),
      );
  }
}
