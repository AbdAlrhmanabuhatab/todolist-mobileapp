/// Application color palette.
///
/// Defines all colors used throughout the app as static constants.
/// Uses a sealed class to prevent instantiation and inheritance.
library;

import 'package:flutter/material.dart';

/// Centralized color constants for the TODO app.
///
/// All colors are defined as [Color] constants to ensure consistency
/// across the entire application and enable easy theme updates.
sealed class AppColors {
  // ── Primary ──────────────────────────────────────────────────────────

  /// Main brand color – teal.
  static const Color primary = Color(0xFF62D2C3);

  /// Darker variant of the primary color for pressed / active states.
  static const Color primaryDark = Color(0xFF4DBCAE);

  // ── Surfaces & Backgrounds ──────────────────────────────────────────

  /// Surface color used for cards, dialogs, and sheets.
  static const Color surface = Color(0xFFFFFFFF);

  /// Scaffold / page background color.
  static const Color background = Color(0xFFF5F5F5);

  // ── On‑colors (text / icons on top of surfaces) ─────────────────────

  /// Color for text and icons displayed on primary‑colored surfaces.
  static const Color onPrimary = Colors.white;

  /// Color for high‑emphasis text and icons on surface / background.
  static const Color onSurface = Color(0xFF1E1E1E);

  /// Color for medium‑emphasis / secondary text.
  static const Color textSecondary = Color(0xFF757575);

  // ── Semantic ─────────────────────────────────────────────────────────

  /// Error / destructive action color.
  static const Color error = Color(0xFFE53935);

  /// Success / confirmation color.
  static const Color success = Color(0xFF43A047);

  // ── Decorative ───────────────────────────────────────────────────────

  /// Divider and border color.
  static const Color divider = Color(0xFFE0E0E0);
}
