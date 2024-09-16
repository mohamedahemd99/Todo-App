import 'package:dartz/dartz.dart';

import '../../../../core/error/exception.dart';
import '../entities/auth.dart';
import '../repo/base_auth_repo.dart';

class RefreshTokenUseCase {
  final BaseAuthRepository baseAuthRepository;

  RefreshTokenUseCase(this.baseAuthRepository);

  Future<Either<ServerException, Auth>> call() async {
    return baseAuthRepository.refreshToken();
  }
}
