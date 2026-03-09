part of 'chat_bloc.dart';

@immutable
sealed class ChatState {}

final class ChatInitial extends ChatState {}

final class ChatMessagesLoading extends ChatState {}

final class ChatMessagesFetchSuccess extends ChatState {
  final List<MessageEntity> messages;

  ChatMessagesFetchSuccess(this.messages);
}

final class ChatMessagesFetchFailure extends ChatState {
  final String message;

  ChatMessagesFetchFailure(this.message);
}
