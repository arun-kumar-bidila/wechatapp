import 'package:fpdart/fpdart.dart';
import 'package:wechat/common/usecase/usecase.dart';
import 'package:wechat/core/error/failure.dart';
import 'package:wechat/features/chat/domain/repository/chat_repository.dart';

class MarkMessageAsSeenUsecase
    implements Usecase<bool, MarkMessageAsSeenUsecaseParams> {
  final ChatRepository chatRepository;
  MarkMessageAsSeenUsecase(this.chatRepository);
  @override
  Future<Either<Failure, bool>> call(
    MarkMessageAsSeenUsecaseParams params,
  ) async {
    return await chatRepository.markMessageAsSeen(messageId: params.messageId);
  }
}

class MarkMessageAsSeenUsecaseParams {
  final String messageId;
  MarkMessageAsSeenUsecaseParams({required this.messageId});
}
