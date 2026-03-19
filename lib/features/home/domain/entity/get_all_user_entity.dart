import 'package:wechat/common/entities/user.dart';
import 'package:wechat/features/home/domain/entity/last_message_entity.dart';

class GetAllUserEntity {
  final List<User> users;
  final Map<String, dynamic> unseen;
  final List<LastMessageEntity> lastMessages;
  GetAllUserEntity({
    required this.users,
    required this.unseen,
    required this.lastMessages,
  });
  GetAllUserEntity copyWith({
    List<User>? users,
    Map<String, int>? unseen,
    List<LastMessageEntity>? lastMessages,
  }) {
    return GetAllUserEntity(
      users: users ?? this.users,
      unseen: unseen ?? this.unseen,
      lastMessages: lastMessages ?? this.lastMessages,
    );
  }
}
