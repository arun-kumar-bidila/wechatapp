import 'package:dio/dio.dart';
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
}

class AuthDatasourceImpl implements AuthDatasource {
  final Dio dio;
  AuthDatasourceImpl(this.dio);
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

      return UserModel.fromJson(response.data['userData']);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
