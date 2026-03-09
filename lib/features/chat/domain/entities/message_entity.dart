class MessageEntity {
  final String senderId;
  final String receiverId;
  final String? text;
  final String? image;
  final bool seen;

  MessageEntity({
    required this.senderId,
    required this.receiverId,
    this.text,
    this.image,
    required this.seen,
  });
}
