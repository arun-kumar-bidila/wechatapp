import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wechat/common/usecase/usecase.dart';
import 'package:wechat/features/auth/domain/entities/user.dart';
import 'package:wechat/features/home/domain/usecases/get_all_users_usecase.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetAllUsersUsecase _getAllUsersUsecase;

  HomeBloc({required GetAllUsersUsecase getAllUsersUsecase})
    : _getAllUsersUsecase = getAllUsersUsecase,
      super(HomeInitial()) {
    on<HomeOnFetchAllUsers>(_onFetchAllUsers);
  }

  void _onFetchAllUsers(
    HomeOnFetchAllUsers event,
    Emitter<HomeState> emit,
  ) async {
    final res = await _getAllUsersUsecase(NoParams());
    res.fold(
      (l) => emit(HomeAllUsersFetchFailure(l.message)),
      (r) => emit(HomeAllUsersFetchSuccess(r)),
    );
  }
}
