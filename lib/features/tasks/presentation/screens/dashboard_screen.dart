/// Dashboard screen — the main task management view.
///
/// Displays a teal header with the user's avatar and greeting, a clock
/// illustration, and a task list card with add / toggle / swipe-to-delete
/// functionality. Uses [TaskProvider] and [AuthProvider] for state.
/// Fully responsive across all devices and orientations.
library;

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import 'package:todolist/core/constants/app_assets.dart';
import 'package:todolist/core/constants/app_strings.dart';
import 'package:todolist/features/auth/presentation/providers/auth_provider.dart';
import 'package:todolist/features/tasks/data/models/task_model.dart';
import 'package:todolist/features/tasks/presentation/providers/task_provider.dart';
import 'package:todolist/features/tasks/presentation/widgets/dashboard_header.dart';
import 'package:todolist/features/tasks/presentation/widgets/task_list_card.dart';

/// The primary screen of the app showing the user's tasks.
class DashboardScreen extends StatelessWidget {
  /// Creates a [DashboardScreen].
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final authProvider = context.watch<AuthProvider>();
    final taskProvider = context.watch<TaskProvider>();

    final userName = authProvider.currentUser?.name ?? 'User';
    final tasks = taskProvider.tasks;

    return Scaffold(
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Column(
          children: [
            // ── Teal header with avatar and greeting ──
            DashboardHeader(
              userName: userName,
              avatarPath: AppAssets.defaultAvatar,
              completedCount: taskProvider.completedCount,
              totalCount: tasks.length,
            ),

            // ── Centered, width-constrained content area ──
            Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 500),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.w,
                    vertical: 24.h,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Clock illustration
                      Center(
                        child: Image.asset(
                          AppAssets.clock,
                          width: 120.w,
                          height: 120.h,
                          fit: BoxFit.contain,
                        ),
                      ),

                      SizedBox(height: 24.h),

                      // Section title
                      Text(
                        AppStrings.tasksList,
                        style: textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      SizedBox(height: 12.h),

                      // ── Task list card ──
                      TaskListCard(
                        title: AppStrings.dailyTasks,
                        tasks: tasks,
                        emptyMessage: AppStrings.noTasks,
                        onAddPressed: () => _showAddTaskDialog(context),
                        onTaskToggled: (index, _) {
                          taskProvider.toggleTask(tasks[index].id);
                        },
                        onTaskDismissed: (index) {
                          taskProvider.deleteTask(tasks[index].id);
                        },
                      ),

                      SizedBox(height: 32.h),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ─── Add Task Dialog ─────────────────────────────────────────────────

  /// Shows a dialog that lets the user create a new task.
  void _showAddTaskDialog(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (dialogContext) => const _AddTaskDialog(),
    );
  }
}

/// Dialog for creating a new task with proper controller lifecycle management.
class _AddTaskDialog extends StatefulWidget {
  const _AddTaskDialog();

  @override
  State<_AddTaskDialog> createState() => _AddTaskDialogState();
}

class _AddTaskDialogState extends State<_AddTaskDialog> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _submit() {
    final title = _controller.text.trim();
    if (title.isEmpty) return;

    final taskProvider = context.read<TaskProvider>();
    final newTask = TaskModel(
      id: 'task-${DateTime.now().millisecondsSinceEpoch}',
      title: title,
      createdAt: DateTime.now(),
    );

    taskProvider.addTask(newTask);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(AppStrings.addTask),
      content: TextField(
        controller: _controller,
        autofocus: true,
        decoration: const InputDecoration(
          hintText: 'Enter task title...',
        ),
        textInputAction: TextInputAction.done,
        onSubmitted: (_) => _submit(),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text(AppStrings.cancel),
        ),
        FilledButton(
          onPressed: _submit,
          child: const Text(AppStrings.save),
        ),
      ],
    );
  }
}
