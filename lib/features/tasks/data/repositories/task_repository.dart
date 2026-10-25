/// Abstract interface for task persistence operations.
///
/// Defines the contract that all task repository implementations must
/// fulfil. This allows the presentation layer to depend on an abstraction
/// rather than a concrete storage mechanism (Dependency Inversion Principle).
library;

import 'package:todolist/features/tasks/data/models/task_model.dart';

/// Repository contract for CRUD operations on [TaskModel] entities.
///
/// Implementations may back this with in-memory storage, local databases,
/// or remote APIs without requiring changes to dependent code.
abstract interface class TaskRepository {
  /// Returns all tasks currently held by the repository.
  ///
  /// The returned list should not be modified directly; use the
  /// mutation methods instead.
  List<TaskModel> getAllTasks();

  /// Persists a new [task] in the repository.
  ///
  /// Throws [ArgumentError] if a task with the same [TaskModel.id]
  /// already exists.
  void addTask(TaskModel task);

  /// Replaces the stored task whose [TaskModel.id] matches [task.id].
  ///
  /// Throws [ArgumentError] if no matching task is found.
  void updateTask(TaskModel task);

  /// Removes the task identified by [id].
  ///
  /// Throws [ArgumentError] if no task with the given [id] exists.
  void deleteTask(String id);

  /// Toggles the [TaskModel.isCompleted] flag for the task identified
  /// by [id].
  ///
  /// Throws [ArgumentError] if no task with the given [id] exists.
  void toggleTaskCompletion(String id);
}
