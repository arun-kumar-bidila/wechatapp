import 'package:wechat/features/home/domain/entity/last_message_entity.dart';

class LastMessageModel extends LastMessageEntity {
  LastMessageModel({
    required super.senderId,
    required super.receiverId,
    required super.lastMessage,
    required super.updatedAt,
  });

  factory LastMessageModel.fromJson(Map<String, dynamic> map) {
    return LastMessageModel(
      senderId: map['senderId'],
      receiverId: map['receiverId'],
      lastMessage: map['lastMessage'],
      updatedAt: DateTime.parse(map['updatedAt']),
    );
  }
}
