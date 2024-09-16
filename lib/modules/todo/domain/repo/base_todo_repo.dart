import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../../../core/error/exception.dart';
import '../entities/todo.dart';

abstract class BaseTodoRepository {
  Future<Either<ServerException, List<Todo>>> getTodoList(int page);

  Future<Either<ServerException, Todo>> getTodoDetails(String id);

  Future<Either<ServerException, Todo>> editTodo(
      {required String image,
      required String title,
      required String id,
      required String desc,
      required String priority,
      required String status,
      required String user});

  Future<Either<ServerException, Todo>> addTodo(
      {required String image,
      required String title,
      required String desc,
      required String priority,
      required String dueDate});

  Future<Either<ServerException, bool>> deleteTodo(String id);

  Future<Either<ServerException, String>> uploadImage(File image);
}
