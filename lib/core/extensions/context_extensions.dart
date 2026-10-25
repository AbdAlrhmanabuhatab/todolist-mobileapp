/// Convenience extensions on [BuildContext].
///
/// Provides short‑hand accessors to commonly used theme, media‑query,
/// and scaffold‑messenger properties so widget code stays concise.
library;

import 'package:flutter/material.dart';

/// Shortcuts for [BuildContext] to reduce boilerplate in widget code.
extension ContextExtensions on BuildContext {
  // ── Theme ────────────────────────────────────────────────────────────

  /// The current [ThemeData].
  ThemeData get theme => Theme.of(this);

  /// The current [ColorScheme].
  ColorScheme get colorScheme => theme.colorScheme;

  /// The current [TextTheme].
  TextTheme get textTheme => theme.textTheme;

  // ── Media Query ─────────────────────────────────────────────────────

  /// The full [MediaQueryData] for this context.
  MediaQueryData get mediaQuery => MediaQuery.of(this);

  /// Screen width in logical pixels.
  double get screenWidth => mediaQuery.size.width;

  /// Screen height in logical pixels.
  double get screenHeight => mediaQuery.size.height;

  /// Top padding (e.g. status bar height).
  double get topPadding => mediaQuery.padding.top;

  /// Bottom padding (e.g. navigation bar / home indicator).
  double get bottomPadding => mediaQuery.padding.bottom;

  // ── Navigation ──────────────────────────────────────────────────────

  /// Shortcut to [Navigator.of(this)].
  NavigatorState get navigator => Navigator.of(this);

  // ── Feedback ────────────────────────────────────────────────────────

  /// Show a [SnackBar] with the given [message].
  ///
  /// Optionally supply an [isError] flag to tint the snack bar red.
  void showSnackBar(String message, {bool isError = false}) {
    ScaffoldMessenger.of(this)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: isError ? colorScheme.error : null,
        ),
      );
  }
}
