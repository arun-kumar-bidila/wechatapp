import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wechat/features/chat/domain/entities/message_entity.dart';
import 'package:wechat/features/chat/domain/usecases/chat_messages_fetch_usecase.dart';
import 'package:wechat/features/chat/domain/usecases/send_image_message_usecase.dart';
import 'package:wechat/features/chat/domain/usecases/send_text_message_usecase.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final ChatMessagesFetchUsecase _chatMessagesFetchUsecase;
  final SendTextMessageUsecase _sendTextMessageUsecase;
  final SendImageMessageUsecase _sendImageMessageUsecase;

  ChatBloc({
    required ChatMessagesFetchUsecase chatMessagesFetchUsecase,
    required SendTextMessageUsecase sendTextMessageUsecase,
    required SendImageMessageUsecase sendImageMessageUsecase,
  }) : _chatMessagesFetchUsecase = chatMessagesFetchUsecase,
       _sendTextMessageUsecase = sendTextMessageUsecase,
       _sendImageMessageUsecase = sendImageMessageUsecase,
       super(const ChatState()) {
    on<ChatMessagesFetchEvent>(_onChatMessagesFetch);
    on<ChatTextMessageSendEvent>(_onTextMessageSendEvent);
    on<ChatImageMessageSendEvent>(_onImageMessageSendEvent);
  }

  void _onChatMessagesFetch(
    ChatMessagesFetchEvent event,
    Emitter<ChatState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));

    final result = await _chatMessagesFetchUsecase(
      ChatMessagesFetchUsecaseParams(event.selectedUserId),
    );

    result.fold(
      (failure) =>
          emit(state.copyWith(isLoading: false, error: failure.message)),
      (messages) => emit(
        state.copyWith(isLoading: false, messages: messages, error: null),
      ),
    );
  }

  void _onTextMessageSendEvent(
    ChatTextMessageSendEvent event,
    Emitter<ChatState> emit,
  ) async {
    final result = await _sendTextMessageUsecase(
      SendTextMessageUsecaseParams(
        selectedUserId: event.selectedUserId,
        message: event.message,
      ),
    );
    result.fold(
      (failure) => emit(state.copyWith(error: failure.message)),
      (_) {},
    );
  }

  void _onImageMessageSendEvent(
    ChatImageMessageSendEvent event,
    Emitter<ChatState> emit,
  ) async {
    final result = await _sendImageMessageUsecase(
      SendImageMessageUsecaseParams(
        selectedUserId: event.selectedUserId,
        image: event.image,
      ),
    );
    result.fold(
      (failure) => emit(state.copyWith(error: failure.message)),
      (_) {},
    );
  }
}
