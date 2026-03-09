

import 'package:fpdart/fpdart.dart';
import 'package:wechat/core/error/failure.dart';

import 'package:wechat/features/chat/domain/entities/message_entity.dart';

abstract interface class ChatRepository {
  Future<Either<Failure, List<MessageEntity>>> fetchMessages({
    required String selectedUserId,
  });
}
