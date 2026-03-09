import 'package:flutter/cupertino.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketService {
  static final SocketService _instance = SocketService._internal();

  factory SocketService() => _instance;

  SocketService._internal();

  IO.Socket? socket;

  final ValueNotifier<List<dynamic>> onlineUsers = ValueNotifier([]);

  void connect(String userId) {

    if (socket != null && socket!.connected) return;

    socket = IO.io(
      "https://wechat-y4je.onrender.com",
      IO.OptionBuilder()
          .setTransports(['websocket'])
          .disableAutoConnect()
          .setQuery({'userId': userId})
          .build(),
    );

    socket!.connect();

    socket!.onConnect((_) {
      debugPrint("✅ Connected");
    });

    socket!.on("getOnlineUsers", (userIds) {
      onlineUsers.value = List.from(userIds);
    });

    socket!.onDisconnect((_) {
      debugPrint("❌ Disconnected");
    });

  }

  void disconnect() {
    socket?.disconnect();
  }
}