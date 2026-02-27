import 'package:fpdart/fpdart.dart';
import 'package:wechat/core/error/failure.dart';

abstract interface class Usecase<SuccessType, Params> {
  Future<Either<Failure, SuccessType>> call(Params params);
}


class NoParams{}