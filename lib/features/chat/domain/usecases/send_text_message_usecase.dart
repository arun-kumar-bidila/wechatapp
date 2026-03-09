import 'package:fpdart/fpdart.dart';
import 'package:wechat/common/usecase/usecase.dart';
import 'package:wechat/core/error/failure.dart';
import 'package:wechat/features/chat/domain/repository/chat_repository.dart';

class SendTextMessageUsecase
    implements Usecase<void, SendTextMessageUsecaseParams> {
  final ChatRepository chatRepository;
  SendTextMessageUsecase(this.chatRepository);
  @override
  Future<Either<Failure, void>> call(
    SendTextMessageUsecaseParams params,
  ) async {
    return await chatRepository.sendTextMessage(
      selectedUserId: params.selectedUserId,
      message: params.message,
    );
  }
}

class SendTextMessageUsecaseParams {
  final String selectedUserId;
  final String message;
  SendTextMessageUsecaseParams({
    required this.selectedUserId,
    required this.message,
  });
}
