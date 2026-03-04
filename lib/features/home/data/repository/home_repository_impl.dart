
import 'package:fpdart/fpdart.dart';
import 'package:wechat/core/error/exceptions.dart';
import 'package:wechat/core/error/failure.dart';
import 'package:wechat/features/auth/domain/entities/user.dart';
import 'package:wechat/features/home/data/datasources/home_remote_data_source.dart';
import 'package:wechat/features/home/domain/repository/home_repository.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeRemoteDataSource homeRemoteDataSource;
  HomeRepositoryImpl(this.homeRemoteDataSource);
  @override
  Future<Either<Failure, List<User>>> getAllUsers() async {
    try {
      final res = await homeRemoteDataSource.getAllUsers();
      return right(res);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}
