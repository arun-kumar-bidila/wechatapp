import 'package:dio/dio.dart';
import 'package:wechat/core/error/exceptions.dart';
import 'package:wechat/features/auth/data/models/user_model.dart';
import 'package:wechat/features/home/data/models/get_all_user_res_model.dart';
import 'package:wechat/features/home/data/models/last_message_model.dart';

abstract interface class HomeRemoteDataSource {
  Future<GetAllUserResModel> getAllUsers();
}

class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  final Dio dio;
  HomeRemoteDataSourceImpl(this.dio);
  @override
  Future<GetAllUserResModel> getAllUsers() async {
    try {
      final response = await dio.get('/api/messages/users');
      final resData = response.data;
      if (!resData['success']) {
        throw ServerException(resData['message']);
      }
      final users = (resData['users'] as List)
          .map((user) => UserModel.fromJson(user))
          .toList();
      final unseenMessages = Map<String, dynamic>.from(
        resData['unseenMessages'] ?? {},
      );
      final lastMessages = (resData['lastMessages'] as List)
          .map((lastMessage) => LastMessageModel.fromJson(lastMessage))
          .toList();
      return GetAllUserResModel(
        users: users,
        unseen: unseenMessages,
        lastMessages: lastMessages,
      );
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
