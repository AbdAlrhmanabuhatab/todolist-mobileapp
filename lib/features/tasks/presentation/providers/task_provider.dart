/// State management provider for task-related operations.
///
/// Acts as the bridge between the UI layer and the [TaskRepository],
/// exposing reactive state via [ChangeNotifier]. Inject a concrete
/// [TaskRepository] through the constructor to keep this class
/// testable and decoupled from storage details.
library;

import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:todolist/features/tasks/data/models/task_model.dart';
import 'package:todolist/features/tasks/data/repositories/task_repository.dart';

/// Provides reactive task state to the widget tree.
///
/// Usage with `provider`:
/// ```dart
/// ChangeNotifierProvider(
///   create: (_) => TaskProvider(repository: InMemoryTaskRepository()),
///   child: const MyApp(),
/// )
/// ```
class TaskProvider extends ChangeNotifier {
  /// Creates a [TaskProvider] backed by the given [repository].
  ///
  /// Immediately loads existing tasks from the repository.
  TaskProvider({required TaskRepository repository})
      : _repository = repository {
    _tasks = _repository.getAllTasks();
  }

  final TaskRepository _repository;
  List<TaskModel> _tasks = [];

  // ─── Public Getters ─────────────────────────────────────────────────

  /// An unmodifiable view of all tasks, ordered by creation date.
  UnmodifiableListView<TaskModel> get tasks =>
      UnmodifiableListView<TaskModel>(_tasks);

  /// Tasks that have been marked as completed.
  List<TaskModel> get completedTasks =>
      _tasks.where((t) => t.isCompleted).toList(growable: false);

  /// Tasks that are still pending.
  List<TaskModel> get pendingTasks =>
      _tasks.where((t) => !t.isCompleted).toList(growable: false);

  /// The total number of completed tasks.
  int get completedCount => _tasks.where((t) => t.isCompleted).length;

  /// The total number of pending (incomplete) tasks.
  int get pendingCount => _tasks.where((t) => !t.isCompleted).length;

  /// The fraction of tasks completed, from `0.0` to `1.0`.
  ///
  /// Returns `0.0` when there are no tasks.
  double get completionPercentage {
    if (_tasks.isEmpty) return 0.0;
    return completedCount / _tasks.length;
  }

  // ─── Mutations ──────────────────────────────────────────────────────

  /// Adds a new [task] to the repository and refreshes the local cache.
  void addTask(TaskModel task) {
    _repository.addTask(task);
    _refreshTasks();
  }

  /// Toggles the completion state of the task identified by [id].
  void toggleTask(String id) {
    _repository.toggleTaskCompletion(id);
    _refreshTasks();
  }

  /// Removes the task identified by [id].
  void deleteTask(String id) {
    _repository.deleteTask(id);
    _refreshTasks();
  }

  /// Replaces the stored task whose id matches [task.id].
  void updateTask(TaskModel task) {
    _repository.updateTask(task);
    _refreshTasks();
  }

  // ─── Internal ───────────────────────────────────────────────────────

  /// Reloads the task list from the repository and notifies listeners.
  void _refreshTasks() {
    _tasks = _repository.getAllTasks();
    notifyListeners();
  }
}
