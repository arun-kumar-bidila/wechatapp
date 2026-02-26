import 'package:fpdart/fpdart.dart';
import 'package:wechat/features/auth/domain/entities/user.dart';
import 'package:wechat/core/error/exceptions.dart';
import 'package:wechat/core/error/failure.dart';
import 'package:wechat/features/auth/data/datasources/auth_datasource.dart';
import 'package:wechat/features/auth/domain/repository/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthDatasource authDatasource;
  AuthRepositoryImpl(this.authDatasource);
  @override
  Future<Either<Failure, User>> signUpUser({
    required String email,
    required String fullName,
    required String password,
    required String bio,
  }) async {
    try {
      final res = await authDatasource.signUpUser(
        email: email,
        password: password,
        fullName: fullName,
        bio: bio,
      );
      return right(res);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, User>> loginUser({
    required String email,
    required String password,
  }) async {
    try {
      final response = await authDatasource.loginUser(
        email: email,
        password: password,
      );
      return right(response);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}
