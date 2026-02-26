import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wechat/features/auth/domain/entities/user.dart';
import 'package:wechat/features/auth/domain/usecases/login_use_case.dart';
import 'package:wechat/features/auth/domain/usecases/sign_up_use_case.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SignUpUseCase _signUpUseCase;
  final LoginUseCase _loginUseCase;

  AuthBloc({
    required SignUpUseCase signUpUseCase,
    required LoginUseCase loginUseCase,
  }) : _signUpUseCase = signUpUseCase,
       _loginUseCase = loginUseCase,
       super(AuthInitial()) {
    on<AuthUserSignUpEvent>(_onUserSighUo);
    on<AuthUserLoginEvent>(_onUserLogin);
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
      LoginUseCaseParams(
        email: event.email,
        password: event.password,
      
      ),
    );
    res.fold(
      (l) => emit(AuthLoginFailure(l.message)),
      (r) => emit(AuthUserLoggedIn(r)),
    );
  }
}
