import 'package:flutter_test/flutter_test.dart';
import 'package:todolist/features/tasks/data/models/task_model.dart';
import 'package:todolist/features/tasks/data/repositories/in_memory_task_repository.dart';

void main() {
  group('InMemoryTaskRepository', () {
    late InMemoryTaskRepository repository;

    setUp(() {
      repository = InMemoryTaskRepository();
    });

    test('initial tasks should not be empty and be unmodifiable', () {
      final tasks = repository.getAllTasks();
      expect(tasks, isNotEmpty);
      expect(() => tasks.add(TaskModel(id: 'err', title: 'err', createdAt: DateTime.now())),
          throwsUnsupportedError);
    });

    test('addTask should add a new task successfully', () {
      final newTask = TaskModel(
        id: 'new-id',
        title: 'New Unique Task',
        createdAt: DateTime.now(),
      );

      repository.addTask(newTask);
      final tasks = repository.getAllTasks();

      expect(tasks.any((t) => t.id == 'new-id'), isTrue);
    });

    test('addTask with duplicate id should throw ArgumentError', () {
      final task = repository.getAllTasks().first;
      expect(() => repository.addTask(task), throwsArgumentError);
    });

    test('toggleTaskCompletion should invert the task completion state', () {
      final task = repository.getAllTasks().first;
      final originalState = task.isCompleted;

      repository.toggleTaskCompletion(task.id);
      final updatedTask = repository.getAllTasks().firstWhere((t) => t.id == task.id);

      expect(updatedTask.isCompleted, !originalState);
    });

    test('deleteTask should remove the task from the list', () {
      final task = repository.getAllTasks().first;
      final initialCount = repository.getAllTasks().length;

      repository.deleteTask(task.id);
      final currentTasks = repository.getAllTasks();

      expect(currentTasks.length, initialCount - 1);
      expect(currentTasks.any((t) => t.id == task.id), isFalse);
    });

    test('operations on non-existent id should throw ArgumentError', () {
      expect(() => repository.deleteTask('invalid-id'), throwsArgumentError);
      expect(() => repository.toggleTaskCompletion('invalid-id'), throwsArgumentError);
    });
  });
}
