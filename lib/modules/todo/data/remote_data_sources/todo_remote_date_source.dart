import 'dart:io';

import 'package:todo_app/core/error/error_message_model.dart';
import 'package:todo_app/core/error/exception.dart';
import 'package:todo_app/core/network/api_path.dart';
import 'package:todo_app/core/network/dio_helper.dart';
import 'package:todo_app/modules/todo/data/models/todo_model.dart';

abstract class BaseTodoRemoteDataSource {
  Future<List<TodoModel>> getTodoList(int page);

  Future<TodoModel> getTodoDetails(String id);

  Future<TodoModel> editTodo(
      {required String image,
      required String id,
      required String title,
      required String desc,
      required String priority,
      required String status,
      required String user});

  Future<TodoModel> addTodo(
      {required String image,
      required String title,
      required String desc,
      required String priority,
      required String dueDate});

  Future<bool> deleteTodo(String id);

  Future<String> uploadImage(File image);
}

class TodoRemoteDataSource implements BaseTodoRemoteDataSource {
  @override
  Future<TodoModel> addTodo(
      {required String image,
      required String title,
      required String desc,
      required String priority,
      required String dueDate}) async {
    final response = await DioHelper.postData(url: AppApiPaths.todo, data: {
      "image": image,
      "title": title,
      "desc": desc,
      "priority": priority,
      "dueDate": dueDate
    });
    if (response.statusCode == 200 || response.statusCode == 201) {
      return TodoModel.fromJson(response.data);
    } else {
      throw ServerException(
          errorMessageModel: ErrorMessageModel.fromJson(response.data));
    }
  }

  @override
  Future<bool> deleteTodo(String id) async {
    final response = await DioHelper.deleteData(url: "${AppApiPaths.todo}/$id");
    if (response.statusCode == 200 || response.statusCode == 201) {
      return true;
    } else {
      throw ServerException(
          errorMessageModel: ErrorMessageModel.fromJson(response.data));
    }
  }

  @override
  Future<TodoModel> editTodo(
      {required String image,
      required String title,
      required String id,
      required String desc,
      required String priority,
      required String status,
      required String user}) async {
    final response =
        await DioHelper.putData(url: "${AppApiPaths.todo}/$id", data: {
      "image": image,
      "title": title,
      "desc": desc,
      "priority": priority,
      "status": status,
      "user": user
    });
    if (response.statusCode == 200 || response.statusCode == 201) {
      return TodoModel.fromJson(response.data);
    } else {
      throw ServerException(
          errorMessageModel: ErrorMessageModel.fromJson(response.data));
    }
  }

  @override
  Future<TodoModel> getTodoDetails(String id) async {
    final response = await DioHelper.getData(url: "${AppApiPaths.todo}/$id");
    if (response.statusCode == 200 || response.statusCode == 201) {
      return TodoModel.fromJson(response.data);
    } else {
      throw ServerException(
          errorMessageModel: ErrorMessageModel.fromJson(response.data));
    }
  }

  @override
  Future<List<TodoModel>> getTodoList(int page) async {
    final response =
        await DioHelper.getData(url: "${AppApiPaths.todo}?page=$page");
    if (response.statusCode == 200 || response.statusCode == 201) {
      return List<TodoModel>.from((response.data as List).map(
        (e) => TodoModel.fromJson(e),
      ));
    } else {
      throw ServerException(
          errorMessageModel: ErrorMessageModel.fromJson(response.data));
    }
  }

  @override
  Future<String> uploadImage(File image) async {
    final response =
        await DioHelper.uploadFiles(AppApiPaths.uploadImage, file: image);
    if (response.statusCode == 200 || response.statusCode == 201) {
      return response.data['image'];
    } else {
      throw ServerException(
          errorMessageModel: ErrorMessageModel.fromJson(response.data));
    }
  }
}
