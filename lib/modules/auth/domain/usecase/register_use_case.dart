import 'package:dartz/dartz.dart';

import '../../../../core/error/exception.dart';
import '../entities/auth.dart';
import '../repo/base_auth_repo.dart';

class RegisterUseCase {
  final BaseAuthRepository baseAuthRepository;

  RegisterUseCase(this.baseAuthRepository);

  Future<Either<ServerException, Auth>> call(
      {required String phone,
      required String password,
      required String displayName,
      required int experienceYears,
      required String address,
      required String level}) async {
    return baseAuthRepository.register(
        phone: phone,
        password: password,
        address: address,
        displayName: displayName,
        experienceYears: experienceYears,
        level: level);
  }
}
