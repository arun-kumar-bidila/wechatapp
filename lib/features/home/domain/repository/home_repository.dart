import 'package:fpdart/fpdart.dart';
import 'package:wechat/core/error/failure.dart';
import 'package:wechat/features/home/domain/entity/get_all_user_entity.dart';

abstract interface class HomeRepository {
  Future<Either<Failure, GetAllUserEntity>> getAllUsers();
}
