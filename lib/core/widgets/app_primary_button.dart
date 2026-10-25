/// A reusable primary action button with consistent styling and responsiveness.
///
/// Used throughout the app for main call-to-action buttons such as
/// "Login", "Register", and "Get Started". Supports a loading state
/// that replaces the label with a [CircularProgressIndicator].
///
/// By default, takes the full width of its parent container (`width: double.infinity`),
/// ensuring perfect alignment with text fields and responsive card elements.
library;

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// A responsive primary button styled with the app's teal theme.
class AppPrimaryButton extends StatelessWidget {
  /// Creates an [AppPrimaryButton].
  ///
  /// [label] is the text displayed on the button.
  /// [onPressed] is the callback invoked when tapped (ignored while loading).
  /// [isLoading] shows a spinner instead of the label when `true`.
  /// [width] defaults to `double.infinity` to adapt to parent constraints.
  /// [height] defaults to `56`.
  const AppPrimaryButton({
    super.key,
    required this.label,
    this.onPressed,
    this.isLoading = false,
    this.width = double.infinity,
    this.height = 56,
  });

  /// The text displayed inside the button.
  final String label;

  /// Called when the button is tapped. Ignored when [isLoading] is `true`.
  final VoidCallback? onPressed;

  /// Whether the button should show a loading indicator.
  final bool isLoading;

  /// The explicit width of the button. Defaults to `double.infinity`.
  final double width;

  /// The height of the button. Defaults to `56`.
  final double height;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return SizedBox(
      width: width,
      height: height.h,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: colorScheme.primary,
          foregroundColor: colorScheme.onPrimary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.r),
          ),
          disabledBackgroundColor: colorScheme.primary.withAlpha(180),
        ),
        onPressed: isLoading ? null : onPressed,
        child: isLoading
            ? SizedBox(
                width: 24.w,
                height: 24.h,
                child: CircularProgressIndicator(
                  strokeWidth: 2.5,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    colorScheme.onPrimary,
                  ),
                ),
              )
            : Text(
                label,
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: colorScheme.onSurface,
                ),
              ),
      ),
    );
  }
}
