import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:joyvee/src/models/models.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:joyvee/src/utils/utils.dart';

class MessengerService {
  late final Socket _channel;

  Socket get channel => _channel;

  final StreamSocket _socket = StreamSocket();
  StreamSocket get socket => _socket;

  MessengerService.init({required String token}) :
    _channel = io(MessengerAPI.messengerLiveURL,
      OptionBuilder()
        .setTransports(['websocket'])
        .setExtraHeaders({
          "Bearer": token
        }).build()) {

      _channel.on('messenger_receive_message', (data) {
        return _socket.addResponse(Message.fromJson(data['data']));
      });

      _channel.on('messenger_typing_message', (data) => print(data));
    }
  
  void joinToChat({required int chatId, required receiverId}) {
    _channel.emit('join_room', json.encode({
      "receiver_id": receiverId
    }));
  }

  void sendMessage({required Map<String, dynamic> msg}) {
    _channel.emit('send_message', json.encode(msg));
  }

  void typingMessenger() {
    _channel.emit('typing_message');
  }

  Future<Map<String, dynamic>> fetchChats({required JUser user}) async {
    http.Response response = await http.post(Uri.parse(MessengerAPI.chatsURL),
      headers: <String, String> {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ${user.token}'
      },
      body: json.encode({"user_id" : user.id})
    );
    Map<String, dynamic> result = json.decode(response.body);
    HttpError status = JoyveeFunctions.generateHttpException(result);
    if (status.result) {
      return result;
    } else {
      throw status;
    }
  }

  Future<Map<String, dynamic>> fetchMessages({required Chat chat, required JUser user}) async {
    http.Response response = await http.post(Uri.parse('${MessengerAPI.messagesURL}${chat.id}'),
      headers: <String, String> {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ${user.token}'
      },
      body: json.encode({
        "user_id": user.id
      })
    );
    Map<String, dynamic> result = json.decode(response.body);
    HttpError status = JoyveeFunctions.generateHttpException(result);
    if (status.result) {
      return result;
    } else {
      throw status;
    }
  }
}


class StreamSocket{
  final _socketResponse= StreamController<Message>();

  void Function(Message) get addResponse => _socketResponse.sink.add;

  Stream<Message> get getResponse => _socketResponse.stream;

  void dispose(){
    _socketResponse.close();
  }
}