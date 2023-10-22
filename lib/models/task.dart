class Task {
  String? id;
  String text;
  bool completed;
  int order;

  Task({this.id, required this.text, required this.completed, required this.order});

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'],
      text: json['title'],
      completed: json['completed'],
      order: json['order'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': text,
      'completed': completed,
      'order': order,
    };
  }
}