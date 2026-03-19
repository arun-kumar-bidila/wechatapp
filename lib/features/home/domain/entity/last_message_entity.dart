class LastMessageEntity {
  final String senderId;
  final String receiverId;
  final String lastMessage;
  final DateTime updatedAt;
  LastMessageEntity({
    required this.senderId,
    required this.receiverId,
    required this.lastMessage,
    required this.updatedAt,
  });
}
