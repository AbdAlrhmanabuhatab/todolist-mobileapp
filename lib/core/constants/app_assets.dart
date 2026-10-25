/// Asset path constants.
///
/// Keeps every asset reference in one place so typos are caught at
/// compile time and asset paths are easy to maintain and update.
library;

/// Static asset paths for images and illustrations.
///
/// All paths match the declared assets in `pubspec.yaml`.
sealed class AppAssets {
  static const String _basePath = 'images';

  /// Decorative background shape used across screen headers.
  static const String shape = '$_basePath/shape.png';

  /// Onboarding illustration displayed on the splash screen.
  static const String onboarding = '$_basePath/image1.png';

  /// Authentication illustration displayed on the login screen.
  static const String loginIllustration = '$_basePath/image2.png';

  /// Default user avatar image.
  static const String defaultAvatar = '$_basePath/abed.jpg';

  /// Clock / productivity illustration on the dashboard.
  static const String clock = '$_basePath/clock.png';
}
