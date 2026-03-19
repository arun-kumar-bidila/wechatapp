import 'dart:convert';
import 'dart:io';

import 'package:wechat/core/error/exceptions.dart';
import 'package:wechat/features/chat/data/models/message_model.dart';
import 'dart:async';
import 'package:dio/dio.dart';

abstract interface class ChatRemoteDatasource {
  Future<List<MessageModel>> fetchMessages({required String selectedUserId});
  Future<MessageModel> sendTextMessage({
    required String selectedUserId,
    required String message,
  });

  Future<MessageModel> sendImageMessage({
    required String selectedUserId,
    required File image,
  });

  Future<bool> markMessageAsSeen({required String messageId});
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
  Future<MessageModel> sendTextMessage({
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
      return MessageModel.fromJson(response.data['newMessage']);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<MessageModel> sendImageMessage({
    required String selectedUserId,
    required File image,
  }) async {
    try {
      String base64Image;

      final bytes = await image.readAsBytes();
      base64Image = "data:image/jpeg;base64,${base64Encode(bytes)}";

      final response = await _dio.post(
        '/api/messages/send/$selectedUserId',
        data: {'image': base64Image},
      );

      final data = response.data;

      if (response.statusCode != 200) {
        throw ServerException(data['message']);
      }
      return MessageModel.fromJson(response.data['newMessage']);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<bool> markMessageAsSeen({required String messageId}) async {
    try {
      final response = await _dio.put('/api/messages/mark/$messageId');
      if (response.data['success']) {
        return true;
      } else {
        throw ServerException('Failed to mark message');
      }
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
