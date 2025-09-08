class Task {
  final String id;
  String title;
  String? description;
  final DateTime createdAt;
  DateTime? expiredIn;
  bool completed;

  Task({
    required this.id,
    required this.title,
    this.description,
    required this.createdAt,
    this.expiredIn,
    this.completed = false,
  });

  void toggleCompleted() {
    completed = !completed;
  }
}
