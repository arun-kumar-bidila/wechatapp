import 'package:fpdart/fpdart.dart';
import 'package:wechat/common/usecase/usecase.dart';
import 'package:wechat/core/error/failure.dart';
import 'package:wechat/features/chat/domain/entities/message_entity.dart';
import 'package:wechat/features/chat/domain/repository/chat_repository.dart';

class ChatMessagesFetchUsecase
    implements Usecase<List<MessageEntity>, ChatMessagesFetchUsecaseParams> {
  final ChatRepository chatRepository;
  ChatMessagesFetchUsecase(this.chatRepository);
  @override
  Future<Either<Failure, List<MessageEntity>>> call(
    ChatMessagesFetchUsecaseParams params,
  ) async {
    return await chatRepository.fetchMessages(
      selectedUserId: params.selectedUserId,
    );
  }
}

class ChatMessagesFetchUsecaseParams {
  final String selectedUserId;
  ChatMessagesFetchUsecaseParams(this.selectedUserId);
}
