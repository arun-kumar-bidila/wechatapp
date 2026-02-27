import 'package:fpdart/fpdart.dart';
import 'package:wechat/features/auth/domain/entities/user.dart';
import 'package:wechat/core/error/failure.dart';

abstract interface class AuthRepository {
  Future<Either<Failure, User>> signUpUser({
    required String email,
    required String fullName,
    required String password,
    required String bio,
  });

  Future<Either<Failure, User>> loginUser({
    required String email,

    required String password,
  });

  Future<Either<Failure, User>> checkAuth();
}
