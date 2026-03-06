part of 'home_bloc.dart';

@immutable
sealed class HomeEvent {}

final class HomeOnFetchAllUsers extends HomeEvent{}

class HomeOnlineUsersUpdated extends HomeEvent {
  final List< dynamic> onlineUsers;

  HomeOnlineUsersUpdated(this.onlineUsers);
}