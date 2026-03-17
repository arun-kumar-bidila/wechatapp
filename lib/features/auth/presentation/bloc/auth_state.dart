part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class AuthSignUpLoading extends AuthState {}

final class AuthSignUpFailure extends AuthState {
  final String message;
  AuthSignUpFailure(this.message);
}

final class AuthSignUpSuccess extends AuthState {
  final User user;
  AuthSignUpSuccess(this.user);
}

final class AuthLoginLoading extends AuthState {}

final class AuthLoginFailure extends AuthState {
  final String message;
  AuthLoginFailure(this.message);
}

final class AuthLoginSuccess extends AuthState {
  final User user;
  AuthLoginSuccess(this.user);
}

final class AuthCheckLoading extends AuthState {}

final class AuthCheckFailure extends AuthState {}

final class AuthCheckSuccess extends AuthState {
  final User user;
  AuthCheckSuccess(this.user);
}

final class AuthUserLoggedOutSuccess extends AuthState {}

final class AuthUserLoggedOutLoading extends AuthState {}

final class AuthUserLoggedOutFailure extends AuthState {
  final String message;
  AuthUserLoggedOutFailure(this.message);
}
