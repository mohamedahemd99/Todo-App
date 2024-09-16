import 'package:dartz/dartz.dart';
import 'package:todo_app/core/error/error_message_model.dart';
import 'package:todo_app/core/error/exception.dart';
import 'package:todo_app/modules/auth/data/remote_data_sources/auth_remote_date_source.dart';
import 'package:todo_app/modules/auth/domain/entities/auth.dart';
import 'package:todo_app/modules/auth/domain/entities/user.dart';
import 'package:todo_app/modules/auth/domain/repo/base_auth_repo.dart';

class AuthRepository implements BaseAuthRepository {
  final BaseAuthRemoteDataSource baseAuthRemoteDataSource;

  const AuthRepository(this.baseAuthRemoteDataSource);

  @override
  Future<Either<ServerException, Auth>> login(
      {required String phone, required String password}) async {
    try {
      final result = await baseAuthRemoteDataSource.login(
          phone: phone, password: password);
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
  Future<Either<ServerException, bool>> logout() async {
    final result = await baseAuthRemoteDataSource.logout();
    try {
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
  Future<Either<ServerException, User>> profile() async {
    try {
      final result = await baseAuthRemoteDataSource.profile();
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
  Future<Either<ServerException, Auth>> refreshToken() async {
    final result = await baseAuthRemoteDataSource.refreshToken();
    try {
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
  Future<Either<ServerException, Auth>> register(
      {required String phone,
      required String password,
      required String displayName,
      required int experienceYears,
      required String address,
      required String level}) async {
    final result = await baseAuthRemoteDataSource.register(
        phone: phone,
        password: password,
        displayName: displayName,
        experienceYears: experienceYears,
        address: address,
        level: level);
    try {
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
