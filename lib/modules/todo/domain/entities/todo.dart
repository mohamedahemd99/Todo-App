import 'package:equatable/equatable.dart';

class Todo extends Equatable {
  final String id;
  String image;
  final String title;
  final String desc;
  final String priority;
  final String status;
  final String user;

  Todo({
    required this.id,
    required this.image,
    required this.title,
    required this.desc,
    required this.priority,
    required this.status,
    required this.user,
  });

  @override
  List<Object?> get props => [
        id,
        image,
        title,
        desc,
        priority,
        status,
        user,
      ];
}
