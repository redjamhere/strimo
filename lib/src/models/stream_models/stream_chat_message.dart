// модель сообщения приходящий в чат стрима

import 'package:equatable/equatable.dart';
import 'package:joyvee/src/interfaces/interfaces.dart';
import 'package:joyvee/src/utils/utils.dart';

enum StreamMessageType { message, direction, connection }

class StreamChatMessage extends Profile {
  const StreamChatMessage({
    int userId = 0,
    String avatar = "",
    String tagname = "",
    String firstname = "",
    String lastname = "",
    this.message = "",
    this.color = const [255, 255, 255],
    this.messageType =  StreamMessageType.message,
}) : super(userId: userId, avatar: avatar, username: tagname, firstname: firstname, lastname: lastname);

  final List color;
  final String message;
  final StreamMessageType messageType;
  
  factory StreamChatMessage.fromJson(Map<String, dynamic> data) => StreamChatMessage(
    userId: data['session']['user_id'],
    avatar: '${ImageAPI.avatarsURL}${data['session']['avatar']}.jpg',
    tagname: data['session']['tagname'],
    firstname: data['session']['firstname'],
    lastname: data['session']['lastname'],
    message: data['message']
  );

  Map<String, dynamic> toJson() => {};

  @override
  List<Object> get props => [message, color, messageType];
}