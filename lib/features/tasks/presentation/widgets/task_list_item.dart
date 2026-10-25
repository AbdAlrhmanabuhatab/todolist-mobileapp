/// A single task row with a checkbox and swipe-to-delete behaviour.
///
/// Displays the task [title] alongside a themed checkbox. Completed
/// tasks show a strikethrough on the title text with a muted colour.
/// Wrapping the row in a [Dismissible] enables swipe-to-delete with a
/// red background indicator.
library;

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// A dismissible list tile representing a single task.
class TaskListItem extends StatelessWidget {
  /// Creates a [TaskListItem].
  ///
  /// [id] is the unique task identifier for the [Dismissible] key.
  /// [title] is the task description.
  /// [isCompleted] drives the checkbox state and text styling.
  /// [onToggle] is called with the new checkbox value.
  /// [onDismissed] is called after a successful swipe-to-delete.
  const TaskListItem({
    super.key,
    required this.id,
    required this.title,
    required this.isCompleted,
    required this.onToggle,
    this.onDismissed,
  });

  /// The unique identifier of this task.
  final String id;

  /// The task description text.
  final String title;

  /// Whether this task is marked as completed.
  final bool isCompleted;

  /// Called when the user taps the checkbox.
  final ValueChanged<bool?> onToggle;

  /// Called after the item is swiped away. If `null`, dismiss is disabled.
  final VoidCallback? onDismissed;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final child = Padding(
      padding: EdgeInsets.symmetric(vertical: 4.h, horizontal: 8.w),
      child: Row(
        children: [
          Checkbox(
            activeColor: colorScheme.primary,
            checkColor: colorScheme.onPrimary,
            value: isCompleted,
            onChanged: onToggle,
          ),
          SizedBox(width: 8.w),
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                fontSize: 15.sp,
                fontWeight: FontWeight.w600,
                color: isCompleted
                    ? colorScheme.onSurface.withAlpha(100)
                    : colorScheme.onSurface,
                decoration:
                    isCompleted ? TextDecoration.lineThrough : TextDecoration.none,
                decorationColor: colorScheme.onSurface.withAlpha(100),
              ),
            ),
          ),
        ],
      ),
    );

    // When no dismiss callback is provided, skip the Dismissible wrapper.
    if (onDismissed == null) return child;

    return Dismissible(
      key: ValueKey<String>(id),
      direction: DismissDirection.endToStart,
      onDismissed: (_) => onDismissed?.call(),
      background: Container(
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 16.w),
        color: colorScheme.error,
        child: Icon(
          Icons.delete_outline,
          color: colorScheme.onError,
          size: 24.sp,
        ),
      ),
      child: child,
    );
  }
}
