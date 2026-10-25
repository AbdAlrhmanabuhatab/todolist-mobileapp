/// Application dimension constants.
///
/// Provides a single source of truth for spacing, border radii,
/// icon sizes, and other dimensional values to keep the UI consistent.
library;

/// Consistent spacing, radius, and sizing values.
///
/// Using a fixed scale (4‑point grid) ensures visual rhythm across
/// all screens and widgets.
sealed class AppDimensions {
  // ── Spacing (padding / margin) ──────────────────────────────────────

  /// 4 dp – minimal spacing.
  static const double spacingXS = 4.0;

  /// 8 dp – tight spacing.
  static const double spacingSM = 8.0;

  /// 12 dp – compact spacing.
  static const double spacingMD = 12.0;

  /// 16 dp – standard spacing.
  static const double spacingLG = 16.0;

  /// 24 dp – generous spacing.
  static const double spacingXL = 24.0;

  /// 32 dp – section spacing.
  static const double spacingXXL = 32.0;

  /// 48 dp – large section spacing.
  static const double spacingXXXL = 48.0;

  // ── Border Radius ───────────────────────────────────────────────────

  /// 4 dp – subtle rounding.
  static const double radiusXS = 4.0;

  /// 8 dp – default card / chip rounding.
  static const double radiusSM = 8.0;

  /// 12 dp – button / input field rounding.
  static const double radiusMD = 12.0;

  /// 16 dp – dialog / sheet rounding.
  static const double radiusLG = 16.0;

  /// 24 dp – pill / fully‑rounded small element.
  static const double radiusXL = 24.0;

  /// 32 dp – extra‑rounded containers.
  static const double radiusXXL = 32.0;

  // ── Icon Sizes ──────────────────────────────────────────────────────

  /// 16 dp – small inline icon.
  static const double iconSM = 16.0;

  /// 24 dp – default icon size.
  static const double iconMD = 24.0;

  /// 32 dp – medium icon.
  static const double iconLG = 32.0;

  /// 48 dp – large icon / avatar placeholder.
  static const double iconXL = 48.0;

  // ── Button ──────────────────────────────────────────────────────────

  /// Standard button height.
  static const double buttonHeight = 52.0;

  /// Standard button minimum width.
  static const double buttonMinWidth = 120.0;

  // ── Input Fields ────────────────────────────────────────────────────

  /// Standard text field height.
  static const double inputHeight = 52.0;

  // ── Elevation ───────────────────────────────────────────────────────

  /// Low elevation for cards.
  static const double elevationLow = 1.0;

  /// Medium elevation for raised elements.
  static const double elevationMedium = 4.0;

  /// High elevation for modals / dialogs.
  static const double elevationHigh = 8.0;

  // ── Miscellaneous ───────────────────────────────────────────────────

  /// Checkbox / radio size.
  static const double checkboxSize = 24.0;

  /// Standard app bar height.
  static const double appBarHeight = 56.0;

  /// Divider thickness.
  static const double dividerThickness = 1.0;
}
