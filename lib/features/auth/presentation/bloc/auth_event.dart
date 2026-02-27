part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

final class AuthUserSignUpEvent extends AuthEvent {
  final String email;
  final String password;
  final String fullName;
  final String bio;
  AuthUserSignUpEvent({
    required this.email,
    required this.password,
    required this.fullName,
    required this.bio,
  });
}

final class AuthUserLoginEvent extends AuthEvent {
  final String email;
  final String password;
  AuthUserLoginEvent({required this.email, required this.password});
}


final class AuthCheck extends AuthEvent{}
