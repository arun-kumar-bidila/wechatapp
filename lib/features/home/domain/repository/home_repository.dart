import 'package:fpdart/fpdart.dart';
import 'package:wechat/core/error/failure.dart';
import 'package:wechat/features/auth/domain/entities/user.dart';

abstract interface class HomeRepository {
  Future<Either<Failure, List<User>>> getAllUsers();
}
