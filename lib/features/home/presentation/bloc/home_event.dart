part of 'home_bloc.dart';

@immutable
sealed class HomeEvent {}

final class HomeOnFetchAllUsers extends HomeEvent {}

class HomeOnlineUsersUpdated extends HomeEvent {
  final List<dynamic> onlineUsers;

  HomeOnlineUsersUpdated(this.onlineUsers);
}

class HomeMessageReceivedEvent extends HomeEvent {
  final MessageEntity message;

  HomeMessageReceivedEvent(this.message);
}

class HomeResetUnseenEvent extends HomeEvent {
  final String selectedUserId;
  HomeResetUnseenEvent({required this.selectedUserId});
}
