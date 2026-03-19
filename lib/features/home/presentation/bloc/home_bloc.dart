import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wechat/common/usecase/usecase.dart';
import 'package:wechat/core/utils/socket_service.dart';
import 'package:wechat/features/chat/data/models/message_model.dart';
import 'package:wechat/features/chat/domain/entities/message_entity.dart';

import 'package:wechat/features/home/domain/entity/get_all_user_entity.dart';
import 'package:wechat/features/home/domain/usecases/get_all_users_usecase.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetAllUsersUsecase _getAllUsersUsecase;
  final SocketService _socketService;

  HomeBloc({
    required GetAllUsersUsecase getAllUsersUsecase,
    required SocketService socketService,
  }) : _getAllUsersUsecase = getAllUsersUsecase,
       _socketService = socketService,
       super(HomeState()) {
    _socketService.onlineUsers.addListener(() {
      add(HomeOnlineUsersUpdated(_socketService.onlineUsers.value));
      // print("ONLINE USERS CHANGED: ${_socketService.onlineUsers.value}");
    });
    _socketService.messageStreamController.stream.listen((data) {
      final message = MessageModel.fromJson(data);

      add(HomeMessageReceivedEvent(message));
    });
    on<HomeOnFetchAllUsers>(_onFetchAllUsers);
    on<HomeOnlineUsersUpdated>((event, emit) {
      emit(state.copyWith(onlineUsers: event.onlineUsers));
    });
    on<HomeMessageReceivedEvent>(_onHomeMessageReceivedEvent);
    on<HomeResetUnseenEvent>(_onHomeResetUnseenEvent);
    on<HomeResetEvent>((event, emit) {
      emit(HomeState.initial());
    });
  }

  void _onFetchAllUsers(
    HomeOnFetchAllUsers event,
    Emitter<HomeState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, error: null));
    final res = await _getAllUsersUsecase(NoParams());
    res.fold(
      (l) => emit(state.copyWith(isLoading: false, error: l.message)),
      (r) => emit(state.copyWith(isLoading: false, allUsersData: r)),
    );
  }

  void _onHomeMessageReceivedEvent(
    HomeMessageReceivedEvent event,
    Emitter<HomeState> emit,
  ) async {
    if (state.allUsersData == null) return;

    final unseen = Map<String, int>.from(state.allUsersData!.unseen);

    unseen[event.message.senderId] = (unseen[event.message.senderId] ?? 0) + 1;

    emit(
      state.copyWith(
        allUsersData: state.allUsersData!.copyWith(unseen: unseen),
      ),
    );
  }

  void _onHomeResetUnseenEvent(
    HomeResetUnseenEvent event,
    Emitter<HomeState> emit,
  ) async {
    final unseen = Map<String, int>.from(state.allUsersData!.unseen);

    unseen[event.selectedUserId] = 0;

    emit(
      state.copyWith(
        allUsersData: state.allUsersData!.copyWith(unseen: unseen),
      ),
    );
  }
}
