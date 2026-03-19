import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wechat/core/utils/socket_service.dart';
import 'package:wechat/features/chat/data/models/message_model.dart';
import 'package:wechat/features/chat/domain/entities/message_entity.dart';
import 'package:wechat/features/chat/domain/usecases/chat_messages_fetch_usecase.dart';
import 'package:wechat/features/chat/domain/usecases/mark_message_as_seen_usecase.dart';
import 'package:wechat/features/chat/domain/usecases/send_image_message_usecase.dart';
import 'package:wechat/features/chat/domain/usecases/send_text_message_usecase.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final ChatMessagesFetchUsecase _chatMessagesFetchUsecase;
  final SendTextMessageUsecase _sendTextMessageUsecase;
  final SendImageMessageUsecase _sendImageMessageUsecase;
  final SocketService _socketService;
  final MarkMessageAsSeenUsecase _markMessageAsSeenUsecase;

  ChatBloc({
    required ChatMessagesFetchUsecase chatMessagesFetchUsecase,
    required SendTextMessageUsecase sendTextMessageUsecase,
    required SendImageMessageUsecase sendImageMessageUsecase,
    required SocketService socketService,
     required MarkMessageAsSeenUsecase markMessageAsSeenUsecase
  }) : _chatMessagesFetchUsecase = chatMessagesFetchUsecase,
       _sendTextMessageUsecase = sendTextMessageUsecase,
       _sendImageMessageUsecase = sendImageMessageUsecase,
       _socketService = socketService,
       _markMessageAsSeenUsecase=markMessageAsSeenUsecase,
       super(const ChatState()) {
    _socketService.messageStreamController.stream.listen((data) {
      final message = MessageModel.fromJson(data);
      add(ChatSocketMessageReceivedEvent(message));
    });
    on<ChatInitializeEvent>(_onChatInitializeEvent);
    on<ChatMessagesFetchEvent>(_onChatMessagesFetch);
    on<ChatTextMessageSendEvent>(_onTextMessageSendEvent);
    on<ChatImageMessageSendEvent>(_onImageMessageSendEvent);
    on<ChatSocketMessageReceivedEvent>(_onSocketMessageReceived);
    on<ChatResetEvent>((event, emit) {
      emit(ChatState.initial());
    });
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
    result.fold((failure) => emit(state.copyWith(error: failure.message)), (r) {
      final exists = state.messages.any((m) => m.id == r.id);

      if (exists) return;

      final updatedMessages = List<MessageEntity>.from(state.messages)..add(r);

      emit(state.copyWith(messages: updatedMessages));
    });
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
    result.fold((failure) => emit(state.copyWith(error: failure.message)), (r) {
      final exists = state.messages.any((m) => m.id == r.id);

      if (exists) return;

      final updatedMessages = List<MessageEntity>.from(state.messages)..add(r);

      emit(state.copyWith(messages: updatedMessages));
    });
  }

  void _onSocketMessageReceived(
    ChatSocketMessageReceivedEvent event,
    Emitter<ChatState> emit,
  )async {
    if (event.message.senderId != state.selectedUserId) {
      return;
    }
    final exists = state.messages.any((m) => m.id == event.message.id);

    if (exists) return;

    final updatedMessages = List<MessageEntity>.from(state.messages)
      ..add(event.message);

    emit(state.copyWith(messages: updatedMessages));
    await _markMessageAsSeenUsecase(MarkMessageAsSeenUsecaseParams(messageId: event.message.id));
  }

  void _onChatInitializeEvent(
    ChatInitializeEvent event,
    Emitter<ChatState> emit,
  ) {
    emit(state.copyWith(selectedUserId: event.selectedUserId));
  }
}
