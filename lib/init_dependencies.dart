import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:wechat/common/cubit/app_user/app_user_cubit.dart';
import 'package:wechat/core/utils/connection_checker.dart';
import 'package:wechat/core/utils/socket_service.dart';
import 'package:wechat/features/auth/data/datasources/auth_datasource.dart';
import 'package:wechat/features/auth/data/repository/auth_repository_impl.dart';
import 'package:wechat/features/auth/domain/repository/auth_repository.dart';
import 'package:wechat/features/auth/domain/usecases/check_auth_case.dart';
import 'package:wechat/features/auth/domain/usecases/login_use_case.dart';
import 'package:wechat/features/auth/domain/usecases/logout_user_usecase.dart';
import 'package:wechat/features/auth/domain/usecases/sign_up_use_case.dart';
import 'package:wechat/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:wechat/features/chat/domain/usecases/mark_message_as_seen_usecase.dart';
import 'package:wechat/features/chat/domain/usecases/send_image_message_usecase.dart';
import 'package:wechat/features/chat/domain/usecases/send_text_message_usecase.dart';
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
import 'package:wechat/features/chat/data/datasources/chat_remote_datasource.dart';
import 'package:wechat/features/chat/data/repository/chat_repository_impl.dart';
import 'package:wechat/features/chat/domain/repository/chat_repository.dart';
import 'package:wechat/features/chat/domain/usecases/chat_messages_fetch_usecase.dart';
import 'package:wechat/features/chat/presentation/bloc/chat_bloc.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  final dio = Dio(
    BaseOptions(
      // baseUrl: "https://wechat-y4je.onrender.com",
      baseUrl: "http://192.168.0.241:5000",
      headers: {"Content-Type": "application/json"},
      validateStatus: (status) => true,
    ),
  );
  final storage = FlutterSecureStorage();

  serviceLocator.registerLazySingleton(() => dio);
  serviceLocator.registerLazySingleton(() => storage);
  serviceLocator.registerLazySingleton<SocketService>(() => SocketService());
  serviceLocator.registerFactory(() => AppUserCubit());
  serviceLocator.registerFactory(() => InternetConnection());
  serviceLocator.registerFactory<ConnectionChecker>(
    () => ConnectionCheckerImpl(serviceLocator()),
  );
  _initAuth();
  _initProfile();
  _initHome();
  _initChat();
}

void _initAuth() {
  serviceLocator
    ..registerFactory<AuthDatasource>(
      () => AuthDatasourceImpl(serviceLocator(), serviceLocator()),
    )
    ..registerFactory<AuthRepository>(
      () => AuthRepositoryImpl(serviceLocator(),serviceLocator()),
    )
    ..registerFactory(() => SignUpUseCase(serviceLocator()))
    ..registerFactory(() => LoginUseCase(serviceLocator()))
    ..registerFactory(() => CheckAuthCase(serviceLocator()))
    ..registerFactory(() => LogoutUserUsecase(serviceLocator()))
    ..registerFactory(
      () => AuthBloc(
        signUpUseCase: serviceLocator(),
        loginUseCase: serviceLocator(),
        checkAuthCase: serviceLocator(),
        logoutUserUsecase: serviceLocator(),
      ),
    );
}

void _initProfile() {
  serviceLocator
    ..registerFactory<ProfileRemoteDataSource>(
      () => ProfileRemoteDataSourceImpl(serviceLocator()),
    )
    ..registerFactory<ProfileRepository>(
      () => ProfileRepositoryImpl(serviceLocator(),serviceLocator()),
    )
    ..registerFactory(() => UpdateUserUsecase(serviceLocator()))
    ..registerFactory(() => ProfileBloc(updateUserUsecase: serviceLocator()));
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
    ..registerFactory(
      () => HomeBloc(
        getAllUsersUsecase: serviceLocator(),
        socketService: serviceLocator(),
      ),
    );
}

void _initChat() {
  serviceLocator
    ..registerFactory<ChatRemoteDatasource>(
      () => ChatRemoteDatasourceImpl(serviceLocator()),
    )
    ..registerFactory<ChatRepository>(
      () => ChatRepositoryImpl(serviceLocator()),
    )
    ..registerFactory(() => ChatMessagesFetchUsecase(serviceLocator()))
    ..registerFactory(() => SendTextMessageUsecase(serviceLocator()))
    ..registerFactory(() => SendImageMessageUsecase(serviceLocator()))
    ..registerFactory(() => MarkMessageAsSeenUsecase(serviceLocator()))
    ..registerFactory(
      () => ChatBloc(
        chatMessagesFetchUsecase: serviceLocator(),
        sendTextMessageUsecase: serviceLocator(),
        sendImageMessageUsecase: serviceLocator(),
        socketService: serviceLocator(),
        markMessageAsSeenUsecase: serviceLocator(),
      ),
    );
}
