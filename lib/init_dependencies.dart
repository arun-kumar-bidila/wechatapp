import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:wechat/features/auth/data/datasources/auth_datasource.dart';
import 'package:wechat/features/auth/data/repository/auth_repository_impl.dart';
import 'package:wechat/features/auth/domain/repository/auth_repository.dart';
import 'package:wechat/features/auth/domain/usecases/check_auth_case.dart';
import 'package:wechat/features/auth/domain/usecases/login_use_case.dart';
import 'package:wechat/features/auth/domain/usecases/sign_up_use_case.dart';
import 'package:wechat/features/auth/presentation/bloc/auth_bloc.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  final dio = Dio(
    BaseOptions(
      baseUrl: "https://wechat-y4je.onrender.com",
      headers: {"Content-Type": "application/json"},
      validateStatus: (status) => true,
    ),
  );
  final storage = FlutterSecureStorage();

  serviceLocator.registerLazySingleton(() => dio);
  serviceLocator.registerLazySingleton(() => storage);
  _initAuth();
}

void _initAuth() {
  serviceLocator
    ..registerFactory<AuthDatasource>(
      () => AuthDatasourceImpl(serviceLocator(), serviceLocator()),
    )
    ..registerFactory<AuthRepository>(
      () => AuthRepositoryImpl(serviceLocator()),
    )
    ..registerFactory(() => SignUpUseCase(serviceLocator()))
    ..registerFactory(() => LoginUseCase(serviceLocator()))
    ..registerFactory(() => CheckAuthCase(serviceLocator()))
    ..registerLazySingleton(
      () => AuthBloc(
        signUpUseCase: serviceLocator(),
        loginUseCase: serviceLocator(),
        checkAuthCase: serviceLocator(),
      ),
    );
}
