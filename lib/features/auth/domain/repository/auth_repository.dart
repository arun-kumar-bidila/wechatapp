import 'package:fpdart/fpdart.dart';
import 'package:wechat/features/auth/domain/entities/user.dart';
import 'package:wechat/common/error/failure.dart';

abstract interface class AuthRepository {
  Future<Either<Failure, User>> signUpUser({
    required String email,
    required String fullName,
   required String password,
   required String bio,
  });
}
