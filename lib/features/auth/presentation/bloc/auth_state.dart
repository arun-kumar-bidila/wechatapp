part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class AuthSignUpLoading extends AuthState {}

final class AuthSignUpFailure extends AuthState {
  final String message;
  AuthSignUpFailure(this.message);
}

final class AuthUserLoggedIn extends AuthState {
  final User user;
  AuthUserLoggedIn(this.user);
}
