import 'dart:io';

import 'package:fpdart/fpdart.dart';
import 'package:wechat/core/error/exceptions.dart';
import 'package:wechat/core/error/failure.dart';
import 'package:wechat/features/auth/domain/entities/user.dart';
import 'package:wechat/features/profile/data/datasources/profile_remote_data_source.dart';
import 'package:wechat/features/profile/domain/repository/profile_repository.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileRemoteDataSource profileRemoteDataSource;
  ProfileRepositoryImpl(this.profileRemoteDataSource);
  @override
  Future<Either<Failure, User>> updateUser({
    required String fullName,
    required String bio,
    File? image,
  }) async {
    try {
      
      
        final res = await profileRemoteDataSource.updateUser(
          fullName: fullName,
          bio: bio,
          image: image,
        );
        return right(res);
      
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}
