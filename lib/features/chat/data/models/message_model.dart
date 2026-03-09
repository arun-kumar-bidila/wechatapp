import 'package:wechat/features/chat/domain/entities/message_entity.dart';

class MessageModel extends MessageEntity {
  MessageModel({
    required super.senderId,
    required super.receiverId,
    super.text,
    super.image,
    required super.seen,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      senderId: json['senderId'],
      receiverId: json['receiverId'],
      text: json['text'] ?? '',
      image: json['image'] ?? '',
      seen: json['seen'],
    );
  }
}
