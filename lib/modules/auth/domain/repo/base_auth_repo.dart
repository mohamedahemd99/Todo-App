import 'package:dartz/dartz.dart';
import 'package:todo_app/modules/auth/domain/entities/auth.dart';
import 'package:todo_app/modules/auth/domain/entities/user.dart';

import '../../../../core/error/exception.dart';

abstract class BaseAuthRepository {
  Future<Either<ServerException, Auth>> login(
      {required String phone, required String password});

  Future<Either<ServerException, Auth>> register(
      {required String phone,
      required String password,
      required String displayName,
      required int experienceYears,
      required String address,
      required String level});

  Future<Either<ServerException, bool>> logout();

  Future<Either<ServerException, Auth>> refreshToken();

  Future<Either<ServerException, User>> profile();
}
