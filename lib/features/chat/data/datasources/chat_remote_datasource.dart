import 'package:wechat/core/error/exceptions.dart';
import 'package:wechat/features/chat/data/models/message_model.dart';
import 'dart:async';
import 'package:dio/dio.dart';

abstract interface class ChatRemoteDatasource {
  Future<List<MessageModel>> fetchMessages({required String selectedUserId});
  Future<void> sendTextMessage({
    required String selectedUserId,
    required String message,
  });
}

class ChatRemoteDatasourceImpl implements ChatRemoteDatasource {
  final Dio _dio;

  ChatRemoteDatasourceImpl(this._dio);

  @override
  Future<List<MessageModel>> fetchMessages({
    required String selectedUserId,
  }) async {
    try {
      final response = await _dio.get('/api/messages/$selectedUserId');

      if (response.statusCode == 200) {
        final data = response.data['messages'] as List;
        return data.map((e) => MessageModel.fromJson(e)).toList();
      } else {
        throw ServerException(
          'Failed to fetch messages: ${response.statusMessage}',
        );
      }
    } catch (e) {
      throw ServerException('Error fetching messages: $e');
    }
  }

  @override
  Future<void> sendTextMessage({
    required String selectedUserId,
    required String message,
  }) async {
    try {
      final response = await _dio.post(
        '/api/messages/send/$selectedUserId',
        data: {'text': message},
      );

      if (response.statusCode != 200) {
        throw ServerException(response.data['message']);
      }
      return;
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
