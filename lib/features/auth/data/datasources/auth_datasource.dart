import 'package:dio/dio.dart';
import 'package:wechat/common/error/exceptions.dart';
import 'package:wechat/features/auth/data/models/user_model.dart';

abstract interface class AuthDatasource {
  Future<UserModel> signUpUser({
    required String email,
    required String password,
    required String fullName,
    required String bio,
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
}
