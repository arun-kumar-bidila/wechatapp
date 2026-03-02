import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:wechat/core/error/exceptions.dart';
import 'package:wechat/features/auth/data/models/user_model.dart';

abstract interface class ProfileRemoteDataSource {
  Future<UserModel> updateUser({
    required String fullName,
    required String bio,
    File? image,
  });
}

class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  final Dio dio;
  ProfileRemoteDataSourceImpl(this.dio);
  @override
  Future<UserModel> updateUser({
    required String fullName,
    required String bio,
    File? image,
  }) async {
    try {
      String? base64Image;
      if (image != null) {
        final bytes = await image.readAsBytes();
        base64Image = "data:image/jpeg;base64,${base64Encode(bytes)}";
      }

      final response = await dio.put(
        '/api/auth/update-profile',
        data: {
          'fullName': fullName,
          'bio': bio,
          if (base64Image != null) 'profilePic': base64Image,
        },
      );

      final data = response.data;

      if (!data['success']) {
        throw ServerException(data['message']);
      }
      return UserModel.fromJson(data['user']);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
