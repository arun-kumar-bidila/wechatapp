part of 'profile_bloc.dart';

@immutable
sealed class ProfileState {}

final class ProfileInitial extends ProfileState {}

final class ProfileUptadeLoading extends ProfileState {}

final class ProfileUpdateSuccess extends ProfileState {}

final class ProfileUpdateFailure extends ProfileState {
  final String message;
  ProfileUpdateFailure(this.message);
}
