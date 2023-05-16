import 'package:joyvee/src/utils/utils.dart';
import 'package:joyvee/src/interfaces/interfaces.dart';
import 'package:enum_to_string/enum_to_string.dart';


class Message extends MessageInterface 
  implements Comparable{

  const Message({
    required super.id,
    required super.chatId,
    required super.senderId,
    super.type = MessageType.message,
    required super.date,
    required super.content
  });

  factory Message.fromJson(Map<String, dynamic> data) => Message(
    id: data['message_id']?? data['id'],
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
  String toString() => '$id: $date';

  @override
  int compareTo(other) {
    return date!.compareTo(other.date);
  }

}

class SendedMessage extends MessageInterface 
  implements Comparable{
  const SendedMessage({
    super.type = MessageType.message,
    required super.content,
    required super.receiverId
  });

  Map<String, dynamic> toJson() => {
    "type": EnumToString.convertToString(type).toUpperCase(),
    "content": content,
    "receiver_id": receiverId
  };

  @override
  int compareTo(other) {
    return date!.compareTo(other.date);
  }
}