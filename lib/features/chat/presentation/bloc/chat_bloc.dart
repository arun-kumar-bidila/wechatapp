import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wechat/features/chat/domain/entities/message_entity.dart';
import 'package:wechat/features/chat/domain/usecases/chat_messages_fetch_usecase.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final ChatMessagesFetchUsecase _chatMessagesFetchUsecase;

  ChatBloc({required ChatMessagesFetchUsecase chatMessagesFetchUsecase})
    : _chatMessagesFetchUsecase = chatMessagesFetchUsecase,
      super(ChatInitial()) {
    on<ChatMessagesFetchEvent>(_onChatMessagesFetch);
  }

  void _onChatMessagesFetch(
    ChatMessagesFetchEvent event,
    Emitter<ChatState> emit,
  ) async {
    emit(ChatMessagesLoading());

    final result = await _chatMessagesFetchUsecase(
      ChatMessagesFetchUsecaseParams(event.selectedUserId),
    );

    result.fold(
      (failure) => emit(ChatMessagesFetchFailure(failure.message)),
      (messages) => emit(ChatMessagesFetchSuccess(messages)),
    );
  }
}
