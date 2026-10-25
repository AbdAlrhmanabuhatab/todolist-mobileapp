import 'package:flutter_test/flutter_test.dart';
import 'package:todolist/features/tasks/data/models/task_model.dart';

void main() {
  group('TaskModel', () {
    final now = DateTime(2025, 1, 1, 12);

    test('should create a valid TaskModel instance with defaults', () {
      final task = TaskModel(
        id: '1',
        title: 'Test task',
        createdAt: now,
      );

      expect(task.id, '1');
      expect(task.title, 'Test task');
      expect(task.isCompleted, isFalse);
      expect(task.createdAt, now);
      expect(task.dueDate, isNull);
      expect(task.priority, TaskPriority.medium);
    });

    test('copyWith should return a modified copy while keeping unmodified fields', () {
      final task = TaskModel(
        id: '1',
        title: 'Original Title',
        createdAt: now,
        priority: TaskPriority.low,
      );

      final updatedTask = task.copyWith(
        title: 'Updated Title',
        isCompleted: true,
      );

      expect(updatedTask.id, '1');
      expect(updatedTask.title, 'Updated Title');
      expect(updatedTask.isCompleted, isTrue);
      expect(updatedTask.priority, TaskPriority.low);
    });

    test('toJson and fromJson should be symmetrical', () {
      final task = TaskModel(
        id: '2',
        title: 'Serialization Test',
        isCompleted: true,
        createdAt: now,
        dueDate: now.add(const Duration(days: 1)),
        priority: TaskPriority.high,
      );

      final json = task.toJson();
      final reconstructed = TaskModel.fromJson(json);

      expect(reconstructed, equals(task));
    });

    test('equality and hashCode should match for identical data', () {
      final taskA = TaskModel(
        id: '1',
        title: 'Equal Task',
        createdAt: now,
      );
      final taskB = TaskModel(
        id: '1',
        title: 'Equal Task',
        createdAt: now,
      );

      expect(taskA, equals(taskB));
      expect(taskA.hashCode, equals(taskB.hashCode));
    });
  });
}
