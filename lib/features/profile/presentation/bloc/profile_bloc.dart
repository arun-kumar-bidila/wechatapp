import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wechat/features/profile/domain/usecases/update_user_usecase.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final UpdateUserUsecase _updateUserUsecase;
  ProfileBloc({required UpdateUserUsecase updateUserUsecase})
    : _updateUserUsecase = updateUserUsecase,
      super(ProfileInitial()) {
    on<ProfileUpdateEvent>(_onProfileUpdate);
    on<ProfileResetEvent>((event, emit) {
      emit(ProfileInitial());
    });
  }

  void _onProfileUpdate(
    ProfileUpdateEvent event,
    Emitter<ProfileState> emit,
  ) async {
    emit(ProfileUptadeLoading());
    final res = await _updateUserUsecase(
      UpdateUserUsecaseParams(
        fullName: event.fullName,
        bio: event.bio,
        image: event.image,
      ),
    );

    res.fold((l) => emit(ProfileUpdateFailure(l.message)), (r) {
      emit(ProfileUpdateSuccess());
    });
  }
}
