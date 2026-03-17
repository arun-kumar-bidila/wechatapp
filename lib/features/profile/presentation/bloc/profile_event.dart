part of 'profile_bloc.dart';

@immutable
sealed class ProfileEvent {}

class ProfileUpdateEvent extends ProfileEvent {
  final String fullName;
  final String bio;
  final File? image;
  ProfileUpdateEvent({required this.fullName, required this.bio, this.image});
}
class ProfileResetEvent extends ProfileEvent {}