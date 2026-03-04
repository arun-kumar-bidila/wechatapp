import 'package:dio/dio.dart';
import 'package:wechat/core/error/exceptions.dart';
import 'package:wechat/features/auth/data/models/user_model.dart';

abstract interface class HomeRemoteDataSource {
  Future<List<UserModel>> getAllUsers();
}

class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  final Dio dio;
  HomeRemoteDataSourceImpl(this.dio);
  @override
  Future<List<UserModel>> getAllUsers() async {
    try {
      final response = await dio.get('/api/messages/users');
      final resData = response.data;
      if (!resData['success']) {
        throw ServerException(resData['message']);
      }
      return (resData['users'] as List).map((user) => UserModel.fromJson(user)).toList();
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
