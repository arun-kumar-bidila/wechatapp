import 'dart:io';

import 'package:fpdart/fpdart.dart';
import 'package:wechat/core/error/failure.dart';

import 'package:wechat/features/chat/domain/entities/message_entity.dart';

abstract interface class ChatRepository {
  Future<Either<Failure, List<MessageEntity>>> fetchMessages({
    required String selectedUserId,
  });

  Future<Either<Failure, MessageEntity>> sendTextMessage({
    required String selectedUserId,
    required String message,
  });
  Future<Either<Failure, MessageEntity>> sendImageMessage({
    required String selectedUserId,
    required File image,
  });
  Future<Either<Failure, bool>> markMessageAsSeen({required String messageId});
}
