import 'package:dartz/dartz.dart';
import 'package:todo_app/modules/todo/domain/entities/todo.dart';

import '../../../../core/error/exception.dart';
import '../repo/base_todo_repo.dart';

class GetTodoListUseCase {
  final BaseTodoRepository baseTodoRepository;

  GetTodoListUseCase(this.baseTodoRepository);

  Future<Either<ServerException, List<Todo>>> call(int page) async {
    return baseTodoRepository.getTodoList(page);
  }
}
