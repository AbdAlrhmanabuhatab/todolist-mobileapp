/// Data model representing a single task in the to-do list.
///
/// This is an immutable value object. Use [copyWith] to create modified copies.
/// Supports JSON serialization via [toJson] and [TaskModel.fromJson].
library;

/// Represents the urgency level of a task.
///
/// Each priority level has an associated [displayName] for UI rendering.
enum TaskPriority {
  /// Low urgency — can be deferred.
  low('Low'),

  /// Medium urgency — should be completed soon.
  medium('Medium'),

  /// High urgency — requires immediate attention.
  high('High');

  const TaskPriority(this.displayName);

  /// Human-readable label for this priority level.
  final String displayName;

  /// Resolves a [TaskPriority] from its [name] string.
  ///
  /// Falls back to [TaskPriority.medium] if the value is unrecognised.
  static TaskPriority fromString(String value) {
    return TaskPriority.values.firstWhere(
      (e) => e.name == value,
      orElse: () => TaskPriority.medium,
    );
  }
}

/// An immutable data class that models a to-do task.
///
/// Example usage:
/// ```dart
/// final task = TaskModel(
///   id: 'abc-123',
///   title: 'Buy groceries',
///   priority: TaskPriority.high,
///   dueDate: DateTime(2025, 1, 15),
/// );
/// ```
class TaskModel {
  /// Creates a new [TaskModel].
  ///
  /// [id] and [title] are required. Defaults to [TaskPriority.medium],
  /// not completed, and [createdAt] set to the current time.
  const TaskModel({
    required this.id,
    required this.title,
    this.isCompleted = false,
    required this.createdAt,
    this.dueDate,
    this.priority = TaskPriority.medium,
  });

  /// Constructs a [TaskModel] from a JSON map.
  ///
  /// Expects the keys produced by [toJson]. Throws if required keys
  /// (`id`, `title`, `createdAt`) are missing.
  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      id: json['id'] as String,
      title: json['title'] as String,
      isCompleted: json['isCompleted'] as bool? ?? false,
      createdAt: DateTime.parse(json['createdAt'] as String),
      dueDate: json['dueDate'] != null
          ? DateTime.parse(json['dueDate'] as String)
          : null,
      priority: TaskPriority.fromString(json['priority'] as String? ?? 'medium'),
    );
  }

  /// Unique identifier for this task.
  final String id;

  /// Short description of the task.
  final String title;

  /// Whether this task has been marked as done.
  final bool isCompleted;

  /// The timestamp when this task was first created.
  final DateTime createdAt;

  /// Optional deadline for this task.
  final DateTime? dueDate;

  /// The urgency level of this task.
  final TaskPriority priority;

  /// Returns a new [TaskModel] with the specified fields replaced.
  ///
  /// Any parameter that is not provided retains its current value.
  TaskModel copyWith({
    String? id,
    String? title,
    bool? isCompleted,
    DateTime? createdAt,
    DateTime? dueDate,
    TaskPriority? priority,
  }) {
    return TaskModel(
      id: id ?? this.id,
      title: title ?? this.title,
      isCompleted: isCompleted ?? this.isCompleted,
      createdAt: createdAt ?? this.createdAt,
      dueDate: dueDate ?? this.dueDate,
      priority: priority ?? this.priority,
    );
  }

  /// Serialises this task to a JSON-compatible map.
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'isCompleted': isCompleted,
      'createdAt': createdAt.toIso8601String(),
      'dueDate': dueDate?.toIso8601String(),
      'priority': priority.name,
    };
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is TaskModel &&
        other.id == id &&
        other.title == title &&
        other.isCompleted == isCompleted &&
        other.createdAt == createdAt &&
        other.dueDate == dueDate &&
        other.priority == priority;
  }

  @override
  int get hashCode {
    return Object.hash(id, title, isCompleted, createdAt, dueDate, priority);
  }

  @override
  String toString() {
    return 'TaskModel(id: $id, title: $title, isCompleted: $isCompleted, '
        'priority: ${priority.displayName}, createdAt: $createdAt, '
        'dueDate: $dueDate)';
  }
}
