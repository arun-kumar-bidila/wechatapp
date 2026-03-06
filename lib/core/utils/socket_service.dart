import 'package:flutter/cupertino.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketService {
  IO.Socket? socket;

  void connect(String userId, Function(List<dynamic>) onOnlineUsers) {
  
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

    socket!.onConnectError((data) {
      debugPrint("Connect Error: $data");
    });

    socket!.onError((data) {
      debugPrint("Socket Error: $data");
    });

    socket!.on("getOnlineUsers", (userIds) {
      onOnlineUsers(List.from(userIds));
    });

    socket!.onDisconnect((_) {
      debugPrint("❌ Disconnected");
    });
  }

  void disconnect() {
    socket?.disconnect();
  }
}
