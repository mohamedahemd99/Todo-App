import 'package:dartz/dartz.dart';

import '../../../../core/error/exception.dart';
import '../entities/todo.dart';
import '../repo/base_todo_repo.dart';

class AddTodoUseCase {
  final BaseTodoRepository baseTodoRepository;

  AddTodoUseCase(this.baseTodoRepository);

  Future<Either<ServerException, Todo>> call(
      {required String image,
      required String title,
      required String desc,
      required String priority,
      required String dueDate}) async {
    return baseTodoRepository.addTodo(
        image: image,
        title: title,
        desc: desc,
        priority: priority,
        dueDate: dueDate);
  }
}
