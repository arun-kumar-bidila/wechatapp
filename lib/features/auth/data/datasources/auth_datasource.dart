import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:wechat/core/error/exceptions.dart';
import 'package:wechat/features/auth/data/models/user_model.dart';

abstract interface class AuthDatasource {
  Future<UserModel> signUpUser({
    required String email,
    required String password,
    required String fullName,
    required String bio,
  });

  Future<UserModel> loginUser({
    required String email,
    required String password,
  });

  Future<UserModel> checkAuth();
}

class AuthDatasourceImpl implements AuthDatasource {
  final Dio dio;
  final FlutterSecureStorage storage;
  AuthDatasourceImpl(this.dio, this.storage);
  @override
  Future<UserModel> signUpUser({
    required String email,
    required String password,
    required String fullName,
    required String bio,
  }) async {
    try {
      final response = await dio.post(
        "/api/auth/register",
        data: {
          "fullName": fullName,
          "email": email,
          "password": password,
          "bio": bio,
        },
      );

      if (response.statusCode != 201) {
        throw ServerException(response.data["message"]);
      }
      final token = response.data['token'];

      await storage.write(key: 'token', value: token);

      dio.options.headers['token'] = token;

      return UserModel.fromJson(response.data["userData"]);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<UserModel> loginUser({
    required String email,
    required String password,
  }) async {
    try {
      final response = await dio.post(
        "/api/auth/login",
        data: {'email': email, 'password': password},
      );

      if (response.statusCode != 200) {
        throw ServerException(response.data['message']);
      }
      final token = response.data['token'];

      await storage.write(key: 'token', value: token);

      dio.options.headers['token'] = token;

      return UserModel.fromJson(response.data['userData']);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<UserModel> checkAuth() async {
    try {
      final token = await storage.read(key: 'token');
      dio.options.headers['token'] = token;

      final response = await dio.get('/api/auth/check');
      if (response.statusCode != 200) {
        throw ServerException(response.data?['message'] ?? "Request Failed");
      }

      return UserModel.fromJson(response.data['user']);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
