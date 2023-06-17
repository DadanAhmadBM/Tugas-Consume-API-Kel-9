class Todo {
  final int userId;
  final int id;
  final String title;
  final bool completed;

  Todo({
    required this.userId,
    required this.id,
    required this.title,
    required this.completed,
  });

  factory Todo.fromMap(Map<String, dynamic> data) {
    return Todo(
      userId: data["userId"],
      id: data["id"],
      title: data["title"],
      completed: data["completed"],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "userId": userId,
      "title": title,
      "completed": completed,
    };
  }
}
