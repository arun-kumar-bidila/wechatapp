import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketService {
  SocketService();

  IO.Socket? socket;

  final StreamController<dynamic> messageStreamController =
      StreamController.broadcast();

  final ValueNotifier<List<dynamic>> onlineUsers = ValueNotifier([]);

  void connect(String userId) {
    debugPrint("✅ SOCKET CONNECT USER: $userId");

    socket?.disconnect();
    socket?.dispose();

    socket = IO.io(
      // "https://wechat-y4je.onrender.com",
      "http://192.168.0.241:5000",
      IO.OptionBuilder()
          .setTransports(['websocket'])
          .setQuery({'userId': userId})
          .disableAutoConnect()
          .enableForceNew()
          .build(),
    );

    socket!.connect();

    socket!.onConnect((_) {
      debugPrint("✅ Connected");
    });

    socket!.on("getOnlineUsers", (userIds) {
      onlineUsers.value = List.from(userIds);
      debugPrint("Online Users: ${onlineUsers.value}");
    });

    socket!.on("newMessage", (data) {
      messageStreamController.add(data);
    });

    socket!.onDisconnect((_) {
      debugPrint("❌ Disconnected");
      onlineUsers.value = [];
    });
  }

  void disconnect() {
    socket?.disconnect();
    socket?.dispose();

    socket = null;
    onlineUsers.value = [];
  }

  void dispose() {
    messageStreamController.close();
  }
}
