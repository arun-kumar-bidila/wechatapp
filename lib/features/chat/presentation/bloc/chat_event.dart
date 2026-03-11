part of 'chat_bloc.dart';

@immutable
sealed class ChatEvent {}

final class ChatInitializeEvent extends ChatEvent {
  final String selectedUserId;
  ChatInitializeEvent({required this.selectedUserId});
}

final class ChatMessagesFetchEvent extends ChatEvent {
  final String selectedUserId;
  ChatMessagesFetchEvent({required this.selectedUserId});
}

final class ChatTextMessageSendEvent extends ChatEvent {
  final String selectedUserId;
  final String message;
  ChatTextMessageSendEvent({
    required this.selectedUserId,
    required this.message,
  });
}

final class ChatImageMessageSendEvent extends ChatEvent {
  final String selectedUserId;
  final File image;
  ChatImageMessageSendEvent({
    required this.selectedUserId,
    required this.image,
  });
}

class ChatSocketMessageReceivedEvent extends ChatEvent {
  final MessageEntity message;

  ChatSocketMessageReceivedEvent(this.message);
}
