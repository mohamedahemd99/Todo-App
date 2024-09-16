import 'package:dartz/dartz.dart';
import 'package:todo_app/modules/auth/domain/entities/user.dart';

import '../../../../core/error/exception.dart';
import '../repo/base_auth_repo.dart';

class ProfileUseCase {
  final BaseAuthRepository baseAuthRepository;

  ProfileUseCase(this.baseAuthRepository);

  Future<Either<ServerException, User>> call() async {
    return baseAuthRepository.profile();
  }
}
