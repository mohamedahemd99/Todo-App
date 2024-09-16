import 'package:dartz/dartz.dart';

import '../../../../core/error/exception.dart';
import '../entities/todo.dart';
import '../repo/base_todo_repo.dart';

class GetTodoDetailsUseCase {
  final BaseTodoRepository baseTodoRepository;

  GetTodoDetailsUseCase(this.baseTodoRepository);

  Future<Either<ServerException, Todo>> call(String id) async {
    return baseTodoRepository.getTodoDetails(id);
  }
}
