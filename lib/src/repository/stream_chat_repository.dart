import 'dart:async';
import 'dart:convert';

import 'package:joyvee/src/utils/config.dart';
import 'package:socket_io_client/socket_io_client.dart';

//utils
import 'package:joyvee/src/utils/utils.dart';

class StreamChatRepository {
  late final Socket _socket;

  final StreamController<String> _controller = StreamController<String>();

  void Function(String) get addResponse => _controller.sink.add;

  Stream<String> get getRepsone => _controller.stream;

  Socket get socket => _socket;

  void connectToChat(String token, String roomName) {
    _socket = io(ProjectConfig.WS,
      OptionBuilder()
        .setTransports(['websocket'])
        .setExtraHeaders({
          "Bearer": token
        }).build()
      );
    // _socket.emit('join_room', {"chat_name": roomName});
    _socket.emit('join_room', {"chat_name": "test"});

  }

  void sendMessage(String roomName, String message) {
    _socket.emit('send_message', {"chat_name": "test", "message": message});
  }

  void dispose() {
    _controller.close();
  }
}