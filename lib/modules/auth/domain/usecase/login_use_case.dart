import 'package:dartz/dartz.dart';

import '../../../../core/error/exception.dart';
import '../entities/auth.dart';
import '../repo/base_auth_repo.dart';

class LoginUseCase {
  final BaseAuthRepository baseAuthRepository;

  LoginUseCase(this.baseAuthRepository);

  Future<Either<ServerException, Auth>> call(
      String phone, String password) async {
    return baseAuthRepository.login(phone: phone, password: password);
  }
}
