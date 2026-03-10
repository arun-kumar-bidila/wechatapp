import 'dart:io';

import 'package:fpdart/fpdart.dart';
import 'package:wechat/core/error/exceptions.dart';
import 'package:wechat/core/error/failure.dart';
import 'package:wechat/features/chat/data/datasources/chat_remote_datasource.dart';

import 'package:wechat/features/chat/domain/entities/message_entity.dart';
import 'package:wechat/features/chat/domain/repository/chat_repository.dart';

class ChatRepositoryImpl implements ChatRepository {
  final ChatRemoteDatasource chatRemoteDatasource;

  ChatRepositoryImpl(this.chatRemoteDatasource);

  @override
  Future<Either<Failure, List<MessageEntity>>> fetchMessages({
    required String selectedUserId,
  }) async {
    try {
      final res = await chatRemoteDatasource.fetchMessages(
        selectedUserId: selectedUserId,
      );
      return right(res);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, void>> sendTextMessage({
    required String selectedUserId,
    required String message,
  }) async {
    try {
      final res = await chatRemoteDatasource.sendTextMessage(
        selectedUserId: selectedUserId,
        message: message,
      );
      return right(res);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, void>> sendImageMessage({
    required String selectedUserId,
    required File image,
  }) async {
    try {
      final res = await chatRemoteDatasource.sendImageMessage(
        selectedUserId: selectedUserId,
        image: image,
      );
      return right(res);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}
