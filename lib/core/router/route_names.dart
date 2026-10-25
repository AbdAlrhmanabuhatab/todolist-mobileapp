/// Named route path constants.
///
/// Keeps every route path in a single location so that navigation
/// calls and route generation always stay in sync.
library;

/// Static route path constants for the TODO app.
///
/// Use these with [Navigator.pushNamed] and inside the
/// [AppRouter.onGenerateRoute] switch.
sealed class RouteNames {
  /// Splash / entry screen.
  static const String splash = '/';

  /// Login screen.
  static const String login = '/login';

  /// Sign‑up / registration screen.
  static const String signup = '/signup';

  /// Main dashboard (task list) screen.
  static const String dashboard = '/dashboard';
}
