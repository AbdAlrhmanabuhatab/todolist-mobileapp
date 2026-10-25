/// A navigation prompt linking between authentication screens.
///
/// Displays a wrapped row with a descriptive [message] followed by a tappable
/// [actionText] styled in the app's primary (teal) colour. Commonly
/// used at the bottom of login and signup screens.
///
/// Uses [Wrap] to ensure text wraps gracefully without overflow even
/// under high accessibility font scaling.
library;

import 'package:flutter/material.dart';

/// A responsive widget containing a message and a tappable action link.
class AuthNavigationLink extends StatelessWidget {
  /// Creates an [AuthNavigationLink].
  ///
  /// [message] is the non-interactive label (e.g., "Already have an account?").
  /// [actionText] is the tappable text (e.g., "Sign In").
  /// [onTap] is invoked when the user taps the action text.
  const AuthNavigationLink({
    super.key,
    required this.message,
    required this.actionText,
    required this.onTap,
  });

  /// Descriptive text shown before the action link.
  final String message;

  /// The clickable text that triggers navigation.
  final String actionText;

  /// Callback invoked when [actionText] is tapped.
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Wrap(
      alignment: WrapAlignment.center,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        Text(
          message,
          style: theme.textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: colorScheme.onSurface,
          ),
        ),
        InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(4),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
            child: Text(
              actionText,
              style: theme.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: colorScheme.primary,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
