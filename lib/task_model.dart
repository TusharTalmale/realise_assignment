enum TaskStatus { overdue, completed, due }

class Task {
  final String id;
  final String type;
  final String title;
  final String assignee;
  final String? priority;
  TaskStatus status;
  DateTime? startedDate;
  DateTime deadline;

  Task({
    required this.id,
    required this.type,
    required this.title,
    required this.assignee,
    this.priority,
    required this.status,
    this.startedDate,
    required this.deadline,
  });
}
