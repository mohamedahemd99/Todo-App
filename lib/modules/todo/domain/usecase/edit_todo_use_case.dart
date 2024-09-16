import 'package:dartz/dartz.dart';
import 'package:todo_app/modules/todo/domain/entities/todo.dart';

import '../../../../core/error/exception.dart';
import '../repo/base_todo_repo.dart';

class EditTodoUseCase {
  final BaseTodoRepository baseTodoRepository;

  EditTodoUseCase(this.baseTodoRepository);

  Future<Either<ServerException, Todo>> call(
      {required String image,
      required String title,
      required String id,
      required String desc,
      required String priority,
      required String status,
      required String user}) async {
    return baseTodoRepository.editTodo(
        title: title,
        priority: priority,
        image: image,
        desc: desc,
        id: id,
        status: status,
        user: user);
  }
}
