import 'package:todo_app/core/error/error_message_model.dart';
import 'package:todo_app/core/error/exception.dart';
import 'package:todo_app/core/network/api_path.dart';
import 'package:todo_app/core/network/dio_helper.dart';
import 'package:todo_app/helpers/preferences/pref_manager.dart';
import 'package:todo_app/modules/auth/data/models/auth_model.dart';
import 'package:todo_app/modules/auth/data/models/user_model.dart';

abstract class BaseAuthRemoteDataSource {
  Future<AuthModel> login({required String phone, required String password});

  Future<AuthModel> register(
      {required String phone,
      required String password,
      required String displayName,
      required int experienceYears,
      required String address,
      required String level});

  Future<bool> logout();

  Future<AuthModel> refreshToken();

  Future<UserModel> profile();
}

class AuthRemoteDataSource implements BaseAuthRemoteDataSource {
  @override
  Future<AuthModel> login(
      {required String phone, required String password}) async {
    final response = await DioHelper.postData(
        url: AppApiPaths.login, data: {"phone": phone, "password": password});
    if (response.statusCode == 200 || response.statusCode == 201) {
      return AuthModel.fromJson(response.data);
    } else {
      throw ServerException(
        errorMessageModel: ErrorMessageModel.fromJson(response.data),
      );
    }
  }

  @override
  Future<bool> logout() async {
    final response = await DioHelper.postData(url: AppApiPaths.logout);
    if (response.statusCode == 200 || response.statusCode == 201) {
      return true;
    } else {
      throw ServerException(
          errorMessageModel: ErrorMessageModel.fromJson(response.data));
    }
  }

  @override
  Future<UserModel> profile() async {
    final response = await DioHelper.getData(url: AppApiPaths.profile);
    if (response.statusCode == 200 || response.statusCode == 201) {
      return UserModel.fromJson(response.data);
    } else {
      throw ServerException(
          errorMessageModel: ErrorMessageModel.fromJson(response.data));
    }
  }

  @override
  Future<AuthModel> refreshToken() async {
    final response = await DioHelper.getData(
        url:
            "${AppApiPaths.refreshToken}?token=${PrefManager.getRefreshToken()}");
    if (response.statusCode == 200 || response.statusCode == 201) {
      return AuthModel.fromJson(response.data);
    } else {
      throw ServerException(
          errorMessageModel: ErrorMessageModel.fromJson(response.data));
    }
  }

  @override
  Future<AuthModel> register(
      {required String phone,
      required String password,
      required String displayName,
      required int experienceYears,
      required String address,
      required String level}) async {
    final response = await DioHelper.postData(url: AppApiPaths.register, data: {
      "phone": phone,
      "password": password,
      "displayName": displayName,
      "experienceYears": experienceYears,
      "address": address,
      "level": level
    });
    if (response.statusCode == 200 || response.statusCode == 201) {
      return AuthModel.fromJson(response.data);
    } else {
      throw ServerException(
          errorMessageModel: ErrorMessageModel.fromJson(response.data));
    }
  }
}
