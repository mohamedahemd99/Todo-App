import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:todo_app/modules/todo/domain/repo/base_todo_repo.dart';

import '../../../../core/error/exception.dart';

class UploadImageUseCase {
  final BaseTodoRepository baseTodoRepository;

  UploadImageUseCase(this.baseTodoRepository);

  Future<Either<ServerException, String>> call(File image) async {
    return baseTodoRepository.uploadImage(image);
  }
}
