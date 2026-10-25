/// A reusable text input field with consistent rounded styling.
///
/// Wraps [TextFormField] with the app's standard decoration: rounded
/// borders (50.r radius), optional prefix icon, and themed borders.
///
/// Layout padding is managed by the parent container for clean responsiveness.
library;

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// A styled text form field matching the app's design system.
///
/// Provides a rounded outlined input with optional [prefixIcon],
/// [obscureText] for passwords, and a [validator] for form validation.
class AppTextField extends StatelessWidget {
  /// Creates an [AppTextField].
  ///
  /// [controller] manages the text being edited.
  /// [hintText] is the placeholder shown when the field is empty.
  const AppTextField({
    super.key,
    this.controller,
    required this.hintText,
    this.prefixIcon,
    this.obscureText = false,
    this.validator,
    this.keyboardType,
    this.textInputAction,
    this.onFieldSubmitted,
  });

  /// Controls the text being edited.
  final TextEditingController? controller;

  /// Placeholder text displayed when the field is empty.
  final String hintText;

  /// Optional icon shown at the start of the field.
  final IconData? prefixIcon;

  /// Whether to hide the entered text (e.g., for passwords).
  final bool obscureText;

  /// Optional validation function for form integration.
  final FormFieldValidator<String>? validator;

  /// The type of keyboard to use for editing.
  final TextInputType? keyboardType;

  /// The action button on the soft keyboard (e.g., next, done).
  final TextInputAction? textInputAction;

  /// Called when the user submits the field (e.g., presses done).
  final ValueChanged<String>? onFieldSubmitted;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      validator: validator,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      onFieldSubmitted: onFieldSubmitted,
      style: TextStyle(
        fontSize: 15.sp,
        color: theme.colorScheme.onSurface,
      ),
      decoration: InputDecoration(
        prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50.r),
          borderSide: BorderSide(width: 1.w),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50.r),
          borderSide: BorderSide(
            width: 1.w,
            color: theme.colorScheme.outline,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50.r),
          borderSide: BorderSide(
            width: 1.5.w,
            color: theme.colorScheme.primary,
          ),
        ),
      ),
    );
  }
}
