import 'package:fpdart/fpdart.dart';
import 'package:wechat/common/entities/user.dart';
import 'package:wechat/core/error/exceptions.dart';
import 'package:wechat/core/error/failure.dart';
import 'package:wechat/core/utils/connection_checker.dart';
import 'package:wechat/features/auth/data/datasources/auth_datasource.dart';
import 'package:wechat/features/auth/domain/repository/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthDatasource authDatasource;
  final ConnectionChecker connectionChecker;
  AuthRepositoryImpl(this.authDatasource,this.connectionChecker);
  @override
  Future<Either<Failure, User>> signUpUser({
    required String email,
    required String fullName,
    required String password,
    required String bio,
  }) async {
    try {
      if (await (connectionChecker.isConnected) == false) {
        throw ServerException("No Internet Connection");
      }
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
       if (await (connectionChecker.isConnected) == false) {
        throw ServerException("No Internet Connection");
      }
      final response = await authDatasource.loginUser(
        email: email,
        password: password,
      );
      return right(response);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, User>> checkAuth() async {
    try {
       if (await (connectionChecker.isConnected) == false) {
        throw ServerException("No Internet Connection");
      }
      final response = await authDatasource.checkAuth();

      return right(response);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, void>> logooutUser() async {
    try {
      await authDatasource.logoutUser();
      return right(null);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}
