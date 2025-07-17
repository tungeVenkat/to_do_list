class TaskModel {
  final String id;
  final String title;
  final String description;
  final String priority;
  final DateTime dueDate;

  TaskModel({
    required this.id,
    required this.title,
    required this.description,
    required this.priority,
    required this.dueDate,
  });

  Map<String, dynamic> toMap() => {
        'id': id,
        'title': title,
        'description': description,
        'priority': priority,
        'dueDate': dueDate.toIso8601String(),
      };

  factory TaskModel.fromMap(Map<String, dynamic> map) => TaskModel(
        id: map['id'],
        title: map['title'],
        description: map['description'],
        priority: map['priority'],
        dueDate: DateTime.parse(map['dueDate']),
      );
}
