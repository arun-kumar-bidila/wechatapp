import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wechat/common/usecase/usecase.dart';
import 'package:wechat/features/auth/domain/entities/user.dart';
import 'package:wechat/features/auth/domain/usecases/check_auth_case.dart';
import 'package:wechat/features/auth/domain/usecases/login_use_case.dart';
import 'package:wechat/features/auth/domain/usecases/logout_user_usecase.dart';
import 'package:wechat/features/auth/domain/usecases/sign_up_use_case.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SignUpUseCase _signUpUseCase;
  final LoginUseCase _loginUseCase;
  final CheckAuthCase _checkAuthCase;
  final LogoutUserUsecase _logoutUserUsecase;

  AuthBloc({
    required SignUpUseCase signUpUseCase,
    required LoginUseCase loginUseCase,
    required CheckAuthCase checkAuthCase,
    required LogoutUserUsecase logoutUserUsecase,
  }) : _signUpUseCase = signUpUseCase,
       _loginUseCase = loginUseCase,
       _checkAuthCase = checkAuthCase,
       _logoutUserUsecase = logoutUserUsecase,

       super(AuthInitial()) {
    on<AuthUserSignUpEvent>(_onUserSighUo);
    on<AuthUserLoginEvent>(_onUserLogin);
    on<AuthCheck>(_onAuthCheck);
    on<AuthUserLoggedOutEvent>(_onUserLoggedOut);
  }

  void _onUserSighUo(AuthUserSignUpEvent event, Emitter<AuthState> emit) async {
    emit(AuthSignUpLoading());
    final res = await _signUpUseCase(
      SignUpUseCaseParams(
        email: event.email,
        password: event.password,
        fullName: event.fullName,
        bio: event.bio,
      ),
    );
    res.fold(
      (l) => emit(AuthSignUpFailure(l.message)),
      (r) => emit(AuthUserLoggedIn(r)),
    );
  }

  void _onUserLogin(AuthUserLoginEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoginLoading());
    final res = await _loginUseCase(
      LoginUseCaseParams(email: event.email, password: event.password),
    );
    res.fold(
      (l) => emit(AuthLoginFailure(l.message)),
      (r) => emit(AuthUserLoggedIn(r)),
    );
  }

  void _onAuthCheck(AuthCheck event, Emitter<AuthState> emit) async {
    emit(AuthCheckLoading());
    final res = await _checkAuthCase(NoParams());
    res.fold((l) => emit(AuthCheckFailure()), (r) => emit(AuthUserLoggedIn(r)));
  }

  void _onUserLoggedOut(
    AuthUserLoggedOutEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthUserLoggedOutLoading());
    final res = await _logoutUserUsecase(NoParams());
    res.fold(
      (l) => emit(AuthUserLoggedOutFailure(l.message)),
      (r) => emit(AuthUserLoggedOut()),
    );
  }
}
