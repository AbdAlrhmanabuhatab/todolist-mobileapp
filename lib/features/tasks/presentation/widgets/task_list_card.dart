/// A card component that groups a list of tasks under a titled header.
///
/// Renders a [Card] containing a header row with a [title] and an add
/// button, followed by an adaptive list of [TaskListItem] widgets
/// or an empty-state message when no tasks are present.
///
/// Fully responsive: expands with content without fixed height or nested
/// scroll conflicts.
library;

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todolist/features/tasks/data/models/task_model.dart';
import 'package:todolist/features/tasks/presentation/widgets/task_list_item.dart';

/// A responsive card displaying a titled header, an add button, and a task list.
class TaskListCard extends StatelessWidget {
  /// Creates a [TaskListCard].
  const TaskListCard({
    super.key,
    required this.title,
    required this.tasks,
    this.onAddPressed,
    this.onTaskToggled,
    this.onTaskDismissed,
    this.emptyMessage = 'No tasks yet. Tap + to add one.',
  });

  /// Header label displayed at the top of the card.
  final String title;

  /// The tasks to display inside the card.
  final List<TaskModel> tasks;

  /// Called when the user taps the circular add button.
  final VoidCallback? onAddPressed;

  /// Called when a task checkbox is toggled.
  final void Function(int index, bool? value)? onTaskToggled;

  /// Called when a task is dismissed via swipe.
  final void Function(int index)? onTaskDismissed;

  /// Message shown when the [tasks] list is empty.
  final String emptyMessage;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Card(
      color: Colors.white,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // --- Header row ---
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 17.sp,
                      color: colorScheme.onSurface,
                    ),
                  ),
                ),
                _AddButton(
                  color: colorScheme.primary,
                  onPressed: onAddPressed,
                ),
              ],
            ),
          ),

          const Divider(height: 1, thickness: 0.8),

          // --- Task list or empty state ---
          if (tasks.isEmpty)
            Padding(
              padding: EdgeInsets.symmetric(vertical: 36.h),
              child: Text(
                emptyMessage,
                style: TextStyle(
                  fontSize: 14.sp,
                  color: colorScheme.onSurface.withAlpha(130),
                ),
              ),
            )
          else
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: tasks.length,
              separatorBuilder: (_, __) => Divider(
                height: 1,
                indent: 16.w,
                endIndent: 16.w,
                color: colorScheme.outlineVariant.withAlpha(80),
              ),
              itemBuilder: (context, index) {
                final task = tasks[index];
                return TaskListItem(
                  id: task.id,
                  title: task.title,
                  isCompleted: task.isCompleted,
                  onToggle: (value) => onTaskToggled?.call(index, value),
                  onDismissed: () => onTaskDismissed?.call(index),
                );
              },
            ),
        ],
      ),
    );
  }
}

/// A small circular icon button used as the "add" action in the card header.
class _AddButton extends StatelessWidget {
  const _AddButton({
    required this.color,
    this.onPressed,
  });

  final Color color;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 28.w,
      height: 28.h,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
      child: IconButton(
        padding: EdgeInsets.zero,
        icon: Icon(Icons.add, size: 20.sp, color: Colors.white),
        onPressed: onPressed,
      ),
    );
  }
}
