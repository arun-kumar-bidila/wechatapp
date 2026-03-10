import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wechat/common/usecase/usecase.dart';
import 'package:wechat/core/utils/socket_service.dart';

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
      add(HomeOnlineUsersUpdated(SocketService().onlineUsers.value));
    });
    on<HomeOnFetchAllUsers>(_onFetchAllUsers);
    on<HomeOnlineUsersUpdated>((event, emit) {
      emit(state.copyWith(onlineUsers: event.onlineUsers));
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
}
