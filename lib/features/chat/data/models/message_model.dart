import 'package:wechat/features/chat/domain/entities/message_entity.dart';

class MessageModel extends MessageEntity {
  MessageModel({
    required super.id,
    required super.senderId,
    required super.receiverId,
    super.text,
    super.image,
    required super.seen,
    required super.createdAt,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      id: json['_id'],
      senderId: json['senderId'],
      receiverId: json['receiverId'],
      text: json['text'],
      image: json['image'] ,
      seen: json['seen'],
      createdAt:  DateTime.parse(json['createdAt'])
    );
  }
}
