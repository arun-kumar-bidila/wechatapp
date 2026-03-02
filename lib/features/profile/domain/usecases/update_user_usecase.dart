import 'dart:io';

import 'package:fpdart/fpdart.dart';
import 'package:wechat/common/usecase/usecase.dart';
import 'package:wechat/core/error/failure.dart';
import 'package:wechat/features/auth/domain/entities/user.dart';
import 'package:wechat/features/profile/domain/repository/profile_repository.dart';

class UpdateUserUsecase implements Usecase<User, UpdateUserUsecaseParams> {
  final ProfileRepository profileRepository;
  UpdateUserUsecase(this.profileRepository);
  @override
  Future<Either<Failure, User>> call(UpdateUserUsecaseParams params) async {
    return await profileRepository.updateUser(
      fullName: params.fullName,
      bio: params.bio,
      image: params.image

    );
  }
}

class UpdateUserUsecaseParams {
  final String fullName;
  final String bio;
  File? image;
  UpdateUserUsecaseParams({
    required this.fullName,
    required this.bio,
    this.image,
  });
}
