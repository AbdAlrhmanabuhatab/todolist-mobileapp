/// The teal header section displayed at the top of the dashboard screen.
///
/// Shows the decorative shape overlay, the user's avatar, a welcome
/// message, and an optional progress summary (completed / total tasks).
/// Automatically adapts to device status bar, notch, and screen height.
library;

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todolist/core/widgets/decorative_header_shape.dart';

/// A full-width teal banner with avatar, greeting, and task progress.
class DashboardHeader extends StatelessWidget {
  /// Creates a [DashboardHeader].
  const DashboardHeader({
    super.key,
    required this.userName,
    required this.avatarPath,
    this.completedCount,
    this.totalCount,
  });

  /// The display name used in the greeting.
  final String userName;

  /// Asset path for the user's avatar (e.g., `'images/abed.jpg'`).
  final String avatarPath;

  /// Number of tasks the user has completed. Shown when non-null.
  final int? completedCount;

  /// Total number of tasks. Shown when non-null.
  final int? totalCount;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final topPadding = MediaQuery.of(context).padding.top;

    return Container(
      color: colorScheme.primary,
      width: double.infinity,
      padding: EdgeInsets.only(
        top: topPadding + 20.h,
        bottom: 24.h,
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Decorative shape at the top-left corner.
          const DecorativeHeaderShape(),

          // Centred avatar + greeting content.
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircleAvatar(
                  radius: 54.r,
                  backgroundImage: AssetImage(avatarPath),
                ),
                SizedBox(height: 12.h),
                Text(
                  'Welcome $userName!',
                  style: TextStyle(
                    color: colorScheme.onPrimary,
                    fontSize: 22.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (completedCount != null && totalCount != null) ...[
                  SizedBox(height: 6.h),
                  Text(
                    '$completedCount / $totalCount tasks completed',
                    style: TextStyle(
                      color: colorScheme.onPrimary.withAlpha(220),
                      fontSize: 14.sp,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
