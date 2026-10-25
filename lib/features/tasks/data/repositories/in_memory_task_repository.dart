/// In-memory implementation of [TaskRepository].
///
/// Stores tasks in a [List] for quick prototyping and testing.
/// Initialised with a set of sample tasks to demonstrate functionality.
library;

import 'package:todolist/features/tasks/data/models/task_model.dart';
import 'package:todolist/features/tasks/data/repositories/task_repository.dart';

/// A volatile, list-backed [TaskRepository].
///
/// All data is lost when the application process ends. This implementation
/// is intended for development, testing, and as a reference for more
/// durable backends.
class InMemoryTaskRepository implements TaskRepository {
  /// Creates an [InMemoryTaskRepository] pre-populated with sample tasks.
  InMemoryTaskRepository() : _tasks = _buildSampleTasks();

  final List<TaskModel> _tasks;

  @override
  List<TaskModel> getAllTasks() => List.unmodifiable(_tasks);

  @override
  void addTask(TaskModel task) {
    final exists = _tasks.any((t) => t.id == task.id);
    if (exists) {
      throw ArgumentError('A task with id "${task.id}" already exists.');
    }
    _tasks.add(task);
  }

  @override
  void updateTask(TaskModel task) {
    final index = _indexOfOrThrow(task.id);
    _tasks[index] = task;
  }

  @override
  void deleteTask(String id) {
    final index = _indexOfOrThrow(id);
    _tasks.removeAt(index);
  }

  @override
  void toggleTaskCompletion(String id) {
    final index = _indexOfOrThrow(id);
    final task = _tasks[index];
    _tasks[index] = task.copyWith(isCompleted: !task.isCompleted);
  }

  // ─── Helpers ────────────────────────────────────────────────────────

  /// Returns the index of the task with the given [id], or throws
  /// [ArgumentError] if not found.
  int _indexOfOrThrow(String id) {
    final index = _tasks.indexWhere((t) => t.id == id);
    if (index == -1) {
      throw ArgumentError('No task found with id "$id".');
    }
    return index;
  }

  /// Generates the initial set of sample tasks.
  static List<TaskModel> _buildSampleTasks() {
    final now = DateTime.now();

    return [
      TaskModel(
        id: 'task-001',
        title: 'Design app wireframes',
        isCompleted: true,
        createdAt: now.subtract(const Duration(days: 5)),
        dueDate: now.subtract(const Duration(days: 2)),
        priority: TaskPriority.high,
      ),
      TaskModel(
        id: 'task-002',
        title: 'Set up Flutter project structure',
        isCompleted: true,
        createdAt: now.subtract(const Duration(days: 4)),
        dueDate: now.subtract(const Duration(days: 1)),
        priority: TaskPriority.high,
      ),
      TaskModel(
        id: 'task-003',
        title: 'Implement authentication flow',
        isCompleted: false,
        createdAt: now.subtract(const Duration(days: 3)),
        dueDate: now.add(const Duration(days: 2)),
        priority: TaskPriority.medium,
      ),
      TaskModel(
        id: 'task-004',
        title: 'Write unit tests for task repository',
        isCompleted: false,
        createdAt: now.subtract(const Duration(days: 2)),
        dueDate: now.add(const Duration(days: 5)),
        priority: TaskPriority.medium,
      ),
      TaskModel(
        id: 'task-005',
        title: 'Update README documentation',
        isCompleted: false,
        createdAt: now.subtract(const Duration(days: 1)),
        dueDate: now.add(const Duration(days: 7)),
        priority: TaskPriority.low,
      ),
    ];
  }
}
