part of 'chat_bloc.dart';

@immutable
sealed class ChatEvent {}

final class ChatMessagesFetchEvent extends ChatEvent {
  final String selectedUserId;
  ChatMessagesFetchEvent({required this.selectedUserId});
}
