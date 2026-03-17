part of 'chat_bloc.dart';

@immutable
// sealed class ChatState {}
// final class ChatInitial extends ChatState {}
// final class ChatMessagesLoading extends ChatState {}
// final class ChatMessagesFetchSuccess extends ChatState {
//   final List<MessageEntity> messages;
//   ChatMessagesFetchSuccess(this.messages);
// }
// final class ChatMessagesFetchFailure extends ChatState {
//   final String message;
//   ChatMessagesFetchFailure(this.message);
// }
// final class ChatTextMessageSentFailure extends ChatState{}
// final class ChatTextMessageSentSuccess extends ChatState{}
class ChatState {
  final bool isLoading;
  final String? error;
  final List<MessageEntity> messages;
  final String? selectedUserId;

  const ChatState({
    this.isLoading = false,
    this.error,
    this.messages = const [],
    this.selectedUserId,
  });

  ChatState copyWith({
    bool? isLoading,
    String? error,
    List<MessageEntity>? messages,
    String? selectedUserId,
  }) {
    return ChatState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      messages: messages ?? this.messages,
      selectedUserId: selectedUserId ?? this.selectedUserId,
    );
  }

  factory ChatState.initial() {
    return const ChatState(
      isLoading: false,
      error: null,
      messages: [],
      selectedUserId: null,
    );
  }
}
