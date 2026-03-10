import 'dart:io';

import 'package:fpdart/fpdart.dart';
import 'package:wechat/common/usecase/usecase.dart';
import 'package:wechat/core/error/failure.dart';
import 'package:wechat/features/chat/domain/repository/chat_repository.dart';

class SendImageMessageUsecase
    implements Usecase<void, SendImageMessageUsecaseParams> {
  final ChatRepository chatRepository;
  SendImageMessageUsecase(this.chatRepository);
  @override
  Future<Either<Failure, void>> call(
    SendImageMessageUsecaseParams params,
  ) async {
    return await chatRepository.sendImageMessage(
      selectedUserId: params.selectedUserId,
      image: params.image,
    );
  }
}

class SendImageMessageUsecaseParams {
  final String selectedUserId;
  final File image;
  SendImageMessageUsecaseParams({
    required this.selectedUserId,
    required this.image,
  });
}
