import 'package:flutter/material.dart';
import 'package:gradelens/core/routes/app_router.dart';

class NavigationService {
  const NavigationService._();

  static final navigatorKey = GlobalKey<NavigatorState>();
  static final scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

  static NavigatorState? get _navigator => navigatorKey.currentState;

  static Future<T?> pushNamed<T extends Object?>(String routeName) {
    return _navigator!.pushNamed<T>(routeName);
  }

  static Future<T?> replaceWith<T extends Object?, TO extends Object?>(
    String routeName, {
    TO? result,
  }) {
    return _navigator!.pushReplacementNamed<T, TO>(
      routeName,
      result: result,
    );
  }

  static void back<T extends Object?>([T? result]) {
    if (_navigator?.canPop() ?? false) {
      _navigator!.pop<T>(result);
    } else {
      replaceWith(AppRoutes.home);
    }
  }
}
