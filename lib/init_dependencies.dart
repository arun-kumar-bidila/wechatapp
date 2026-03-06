import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:wechat/features/auth/data/datasources/auth_datasource.dart';
import 'package:wechat/features/auth/data/repository/auth_repository_impl.dart';
import 'package:wechat/features/auth/domain/repository/auth_repository.dart';
import 'package:wechat/features/auth/domain/usecases/check_auth_case.dart';
import 'package:wechat/features/auth/domain/usecases/login_use_case.dart';
import 'package:wechat/features/auth/domain/usecases/logout_user_usecase.dart';
import 'package:wechat/features/auth/domain/usecases/sign_up_use_case.dart';
import 'package:wechat/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:wechat/features/home/data/datasources/home_remote_data_source.dart';
import 'package:wechat/features/home/data/repository/home_repository_impl.dart';
import 'package:wechat/features/home/domain/repository/home_repository.dart';
import 'package:wechat/features/home/domain/usecases/get_all_users_usecase.dart';
import 'package:wechat/features/home/presentation/bloc/home_bloc.dart';
import 'package:wechat/features/profile/data/datasources/profile_remote_data_source.dart';
import 'package:wechat/features/profile/data/repository/profile_repository_impl.dart';
import 'package:wechat/features/profile/domain/repository/profile_repository.dart';
import 'package:wechat/features/profile/domain/usecases/update_user_usecase.dart';
import 'package:wechat/features/profile/presentation/bloc/profile_bloc.dart';

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
  _initProfile();
  _initHome();
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
    ..registerFactory(()=>LogoutUserUsecase(serviceLocator()))
    ..registerLazySingleton(
      () => AuthBloc(
        signUpUseCase: serviceLocator(),
        loginUseCase: serviceLocator(),
        checkAuthCase: serviceLocator(),
        logoutUserUsecase: serviceLocator()
      ),
    );
}

void _initProfile() {
  serviceLocator
    ..registerFactory<ProfileRemoteDataSource>(
      () => ProfileRemoteDataSourceImpl(serviceLocator()),
    )
    ..registerFactory<ProfileRepository>(
      () => ProfileRepositoryImpl(serviceLocator()),
    )
    ..registerFactory(() => UpdateUserUsecase(serviceLocator()))
    ..registerLazySingleton(
      () => ProfileBloc(updateUserUsecase: serviceLocator()),
    );
}

void _initHome() {
  serviceLocator
    ..registerFactory<HomeRemoteDataSource>(
      () => HomeRemoteDataSourceImpl(serviceLocator()),
    )
    ..registerFactory<HomeRepository>(
      () => HomeRepositoryImpl(serviceLocator()),
    )
    ..registerFactory(() => GetAllUsersUsecase(serviceLocator()))
    ..registerLazySingleton(
      () => HomeBloc(getAllUsersUsecase: serviceLocator()),
    );
}
