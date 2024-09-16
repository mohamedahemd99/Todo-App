import 'package:dartz/dartz.dart';

import '../../../../core/error/exception.dart';
import '../repo/base_todo_repo.dart';

class DeleteTodoUseCase {
  final BaseTodoRepository baseTodoRepository;

  DeleteTodoUseCase(this.baseTodoRepository);

  Future<Either<ServerException, bool>> call(String id) async {
    return baseTodoRepository.deleteTodo(id);
  }
}
