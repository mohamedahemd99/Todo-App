import 'package:get_it/get_it.dart';
import 'package:todo_app/modules/auth/data/remote_data_sources/auth_remote_date_source.dart';
import 'package:todo_app/modules/auth/data/repo/auth_repo.dart';
import 'package:todo_app/modules/auth/domain/repo/base_auth_repo.dart';
import 'package:todo_app/modules/auth/domain/usecase/login_use_case.dart';
import 'package:todo_app/modules/auth/domain/usecase/logout_use_case.dart';
import 'package:todo_app/modules/auth/domain/usecase/profile_use_case.dart';
import 'package:todo_app/modules/auth/domain/usecase/refresh_token_use_case.dart';
import 'package:todo_app/modules/auth/domain/usecase/register_use_case.dart';

import '../../modules/todo/data/remote_data_sources/todo_remote_date_source.dart';
import '../../modules/todo/data/repo/todo_repo.dart';
import '../../modules/todo/domain/repo/base_todo_repo.dart';
import '../../modules/todo/domain/usecase/add_todo_use_case.dart';
import '../../modules/todo/domain/usecase/delete_todo_use_case.dart';
import '../../modules/todo/domain/usecase/edit_todo_use_case.dart';
import '../../modules/todo/domain/usecase/get_todo_details_use_case.dart';
import '../../modules/todo/domain/usecase/get_todo_list_use_case.dart';
import '../../modules/todo/domain/usecase/upload_image_use_case.dart';

final sl = GetIt.instance;

class ServiceLocator {
  static void init() {
    ///AuthSl
    ///UseCases
    sl.registerLazySingleton(() => LoginUseCase(sl()));
    sl.registerLazySingleton(() => RegisterUseCase(sl()));
    sl.registerLazySingleton(() => RefreshTokenUseCase(sl()));
    sl.registerLazySingleton(() => LogoutUseCase(sl()));
    sl.registerLazySingleton(() => ProfileUseCase(sl()));

    ///Repository
    sl.registerLazySingleton<BaseAuthRepository>(() => AuthRepository(sl()));

    ///Data sources
    sl.registerLazySingleton<BaseAuthRemoteDataSource>(
        () => AuthRemoteDataSource());

    ///HomeTodoSl
    ///UseCases
    sl.registerLazySingleton(() => AddTodoUseCase(sl()));
    sl.registerLazySingleton(() => DeleteTodoUseCase(sl()));
    sl.registerLazySingleton(() => EditTodoUseCase(sl()));
    sl.registerLazySingleton(() => GetTodoListUseCase(sl()));
    sl.registerLazySingleton(() => GetTodoDetailsUseCase(sl()));
    sl.registerLazySingleton(() => UploadImageUseCase(sl()));

    ///Repository
    sl.registerLazySingleton<BaseTodoRepository>(() => TodoRepository(sl()));

    ///Data sources
    sl.registerLazySingleton<BaseTodoRemoteDataSource>(
        () => TodoRemoteDataSource());
  }
}
