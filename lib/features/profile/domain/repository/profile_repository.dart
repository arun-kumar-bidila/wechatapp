import 'dart:io';

import 'package:fpdart/fpdart.dart';
import 'package:wechat/core/error/failure.dart';
import 'package:wechat/features/auth/domain/entities/user.dart';

abstract interface class ProfileRepository {
  Future<Either<Failure, User>> updateUser({
    required String fullName,
    required String bio,
    File? image,
  });

}
