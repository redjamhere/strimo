import 'package:equatable/equatable.dart';
import 'package:joyvee/src/utils/utils.dart';
import 'package:joyvee/src/interfaces/interfaces.dart';
import 'package:enum_to_string/enum_to_string.dart';


class Message extends MessageInterface {

  const Message({
    required int id,
    required int chatId,
    required int senderId,
    MessageType type = MessageType.message,
    required DateTime date,
    required dynamic content
  }): super(
    id: id,
    chatId: chatId,
    senderId: senderId,
    type: type,
    date: date,
    content: content
  );

  factory Message.fromJson(Map<String, dynamic> data) => Message(
    id: data['message_id'],
    chatId: data['chat_id'],
    senderId: data["sender"],
    type: JoyveeFunctions.intToMessageType(data['type_id']),
    content: data['content'],
    date: DateTime.parse(data['date_create'])
  );

  // Map<String, dynamic> toJson() => {
  //   "chat_id": chatId,
  //   "type": type.toString(),
  //   "receiver_id": requesterId,
  //   "content": content
  // };

  @override
  List<Object> get props => [id!, chatId!];

  @override
  String toString() => '$id: $date';
}

class SendedMessage extends MessageInterface {
  const SendedMessage({
    MessageType type = MessageType.message,
    required dynamic content,
    required int receiverId
  }) : super(
    type: type,
    content: content,
    receiverId: receiverId
  );

  Map<String, dynamic> toJson() => {
    "type": EnumToString.convertToString(type),
    "content": content,
    "receiver_id": receiverId
  };

  @override
  List<Object> get props => [receiverId!];
}