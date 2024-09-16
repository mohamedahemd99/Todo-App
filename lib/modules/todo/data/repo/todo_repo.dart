import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:todo_app/core/error/exception.dart';
import 'package:todo_app/modules/todo/domain/entities/todo.dart';

import '../../../../core/error/error_message_model.dart';
import '../../../todo/data/remote_data_sources/todo_remote_date_source.dart';
import '../../../todo/domain/repo/base_todo_repo.dart';

class TodoRepository implements BaseTodoRepository {
  final BaseTodoRemoteDataSource baseTodoRemoteDataSource;

  const TodoRepository(this.baseTodoRemoteDataSource);

  @override
  Future<Either<ServerException, Todo>> addTodo(
      {required String image,
      required String title,
      required String desc,
      required String priority,
      required String dueDate}) async {
    try {
      final result = await baseTodoRemoteDataSource.addTodo(
          desc: desc,
          dueDate: dueDate,
          image: image,
          priority: priority,
          title: title);
      return Right(result);
    } on ServerException catch (failure) {
      // Here, we catch the ServerException and return a Failure
      return Left(
          ServerException(errorMessageModel: failure.errorMessageModel));
    } catch (e) {
      // Catch any other unexpected exceptions
      return const Left(ServerException(
          errorMessageModel:
              ErrorMessageModel(message: "An unexpected error occurred.")));
    }
  }

  @override
  Future<Either<ServerException, bool>> deleteTodo(String id) async {
    try {
      final result = await baseTodoRemoteDataSource.deleteTodo(id);
      return Right(result);
    } on ServerException catch (failure) {
      // Here, we catch the ServerException and return a Failure
      return Left(
          ServerException(errorMessageModel: failure.errorMessageModel));
    } catch (e) {
      // Catch any other unexpected exceptions
      return const Left(ServerException(
          errorMessageModel:
              ErrorMessageModel(message: "An unexpected error occurred.")));
    }
  }

  @override
  Future<Either<ServerException, Todo>> editTodo(
      {required String image,
      required String title,
      required String id,
      required String desc,
      required String priority,
      required String status,
      required String user}) async {
    try {
      final result = await baseTodoRemoteDataSource.editTodo(
          title: title,
          priority: priority,
          image: image,
          desc: desc,
          id: id,
          status: status,
          user: user);
      return Right(result);
    } on ServerException catch (failure) {
      // Here, we catch the ServerException and return a Failure
      return Left(
          ServerException(errorMessageModel: failure.errorMessageModel));
    } catch (e) {
      // Catch any other unexpected exceptions
      return const Left(ServerException(
          errorMessageModel:
              ErrorMessageModel(message: "An unexpected error occurred.")));
    }
  }

  @override
  Future<Either<ServerException, Todo>> getTodoDetails(String id) async {
    try {
      final result = await baseTodoRemoteDataSource.getTodoDetails(id);
      return Right(result);
    } on ServerException catch (failure) {
      // Here, we catch the ServerException and return a Failure
      return Left(
          ServerException(errorMessageModel: failure.errorMessageModel));
    } catch (e) {
      // Catch any other unexpected exceptions
      return const Left(ServerException(
          errorMessageModel:
              ErrorMessageModel(message: "An unexpected error occurred.")));
    }
  }

  @override
  Future<Either<ServerException, List<Todo>>> getTodoList(int page) async {
    try {
      final result = await baseTodoRemoteDataSource.getTodoList(page);
      return Right(result);
    } on ServerException catch (failure) {
      // Here, we catch the ServerException and return a Failure
      return Left(
          ServerException(errorMessageModel: failure.errorMessageModel));
    } catch (e) {
      print(e);
      // Catch any other unexpected exceptions
      return const Left(ServerException(
          errorMessageModel:
              ErrorMessageModel(message: "An unexpected error occurred.  ")));
    }
  }

  @override
  Future<Either<ServerException, String>> uploadImage(File image) async {
    try {
      final result = await baseTodoRemoteDataSource.uploadImage(image);
      return Right(result);
    } on ServerException catch (failure) {
      // Here, we catch the ServerException and return a Failure
      return Left(
          ServerException(errorMessageModel: failure.errorMessageModel));
    } catch (e) {
      // Catch any other unexpected exceptions
      return const Left(ServerException(
          errorMessageModel:
              ErrorMessageModel(message: "An unexpected error occurred.")));
    }
  }
}
