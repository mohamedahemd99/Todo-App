import '../../domain/entities/todo.dart';

class TodoModel extends Todo {
  TodoModel(
      {required super.id,
      required super.image,
      required super.title,
      required super.desc,
      required super.priority,
      required super.status,
      required super.user});

  factory TodoModel.fromJson(Map<String, dynamic> json) => TodoModel(
        id: json['_id'] as String,
        desc: json['desc'] ?? "",
        image: json['image'] ?? "",
        title: json['title'] ?? "",
        priority: json['priority'] ?? "",
        status: json['status'] ?? "",
        user: json['user'] ?? "",
      );

  // Method to convert TodoModel to JSON
  Map<String, dynamic> toJson() => {
        'desc': desc,
        'image': image,
        'title': title,
        'priority': priority,
        'status': status,
        'user': user,
      };
}
