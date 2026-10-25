/// Centralised application routing.
///
/// Uses [onGenerateRoute] with named routes so that every navigation
/// call goes through a single switch statement, making routes easy
/// to audit, guard, and animate.
library;

import 'package:flutter/material.dart';

import 'package:todolist/features/auth/presentation/screens/login_screen.dart';
import 'package:todolist/features/auth/presentation/screens/signup_screen.dart';
import 'package:todolist/features/onboarding/presentation/screens/splash_screen.dart';
import 'package:todolist/features/tasks/presentation/screens/dashboard_screen.dart';

import 'route_names.dart';

/// Generates [Route]s for the TODO app based on [RouteSettings.name].
///
/// Pass [AppRouter.onGenerateRoute] to [MaterialApp.onGenerateRoute]
/// and set [RouteNames.splash] as the [MaterialApp.initialRoute].
///
/// ### Usage
/// ```dart
/// MaterialApp(
///   initialRoute: RouteNames.splash,
///   onGenerateRoute: AppRouter.onGenerateRoute,
/// );
/// ```
sealed class AppRouter {
  /// Returns the appropriate [MaterialPageRoute] for the given
  /// [RouteSettings].
  ///
  /// Falls back to a simple "Not Found" page for unknown routes.
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.splash:
        return _buildRoute(
          settings: settings,
          builder: (_) => const SplashScreen(),
        );

      case RouteNames.login:
        return _buildRoute(
          settings: settings,
          builder: (_) => const LoginScreen(),
        );

      case RouteNames.signup:
        return _buildRoute(
          settings: settings,
          builder: (_) => const SignUpScreen(),
        );

      case RouteNames.dashboard:
        return _buildRoute(
          settings: settings,
          builder: (_) => const DashboardScreen(),
        );

      default:
        return _buildRoute(
          settings: settings,
          builder: (_) => const _NotFoundPage(),
        );
    }
  }

  /// Convenience wrapper that builds a [MaterialPageRoute] with the
  /// given [settings] and [builder].
  static MaterialPageRoute<T> _buildRoute<T>({
    required RouteSettings settings,
    required WidgetBuilder builder,
  }) {
    return MaterialPageRoute<T>(
      settings: settings,
      builder: builder,
    );
  }
}

/// Fallback page shown when a route name is not recognised.
class _NotFoundPage extends StatelessWidget {
  const _NotFoundPage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Not Found')),
      body: const Center(
        child: Text(
          '404 – Page not found',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
