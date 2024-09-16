import 'package:dartz/dartz.dart';

import '../../../../core/error/exception.dart';
import '../repo/base_auth_repo.dart';

class LogoutUseCase {
  final BaseAuthRepository baseAuthRepository;

  LogoutUseCase(this.baseAuthRepository);

  Future<Either<ServerException, bool>> call() async {
    return baseAuthRepository.logout();
  }
}
