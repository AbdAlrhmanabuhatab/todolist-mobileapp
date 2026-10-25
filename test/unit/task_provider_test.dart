import 'package:flutter_test/flutter_test.dart';
import 'package:todolist/features/tasks/data/models/task_model.dart';
import 'package:todolist/features/tasks/data/repositories/in_memory_task_repository.dart';
import 'package:todolist/features/tasks/presentation/providers/task_provider.dart';

void main() {
  group('TaskProvider', () {
    late InMemoryTaskRepository repository;
    late TaskProvider provider;

    setUp(() {
      repository = InMemoryTaskRepository();
      provider = TaskProvider(repository: repository);
    });

    test('initializes with repository tasks and calculates stats properly', () {
      expect(provider.tasks, isNotEmpty);
      expect(provider.completedCount + provider.pendingCount, equals(provider.tasks.length));
      expect(provider.completionPercentage, inInclusiveRange(0.0, 1.0));
    });

    test('addTask notifies listeners and increases task count', () {
      var notified = false;
      provider.addListener(() => notified = true);

      final initialCount = provider.tasks.length;
      provider.addTask(TaskModel(
        id: 'provider-test-task',
        title: 'Provider Test',
        createdAt: DateTime.now(),
      ));

      expect(notified, isTrue);
      expect(provider.tasks.length, initialCount + 1);
    });

    test('toggleTask updates task status and completion count', () {
      final task = provider.tasks.first;
      final wasCompleted = task.isCompleted;
      final initialCompletedCount = provider.completedCount;

      provider.toggleTask(task.id);

      final updatedTask = provider.tasks.firstWhere((t) => t.id == task.id);
      expect(updatedTask.isCompleted, !wasCompleted);
      expect(
        provider.completedCount,
        wasCompleted ? initialCompletedCount - 1 : initialCompletedCount + 1,
      );
    });

    test('deleteTask removes task and notifies listeners', () {
      var notified = false;
      provider.addListener(() => notified = true);

      final task = provider.tasks.first;
      final initialCount = provider.tasks.length;

      provider.deleteTask(task.id);

      expect(notified, isTrue);
      expect(provider.tasks.length, initialCount - 1);
      expect(provider.tasks.any((t) => t.id == task.id), isFalse);
    });
  });
}
