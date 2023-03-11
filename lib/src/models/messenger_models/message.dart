import 'package:equatable/equatable.dart';
import 'package:joyvee/src/utils/utils.dart';

class Message extends Equatable {

  const Message({
    required this.id,
    required this.chatId,
    required this.senderId,
    this.messageType = MessageType.message,
    required this.requesterId,
    required this.date,
    required this.content,
    this.streamId,
  });

  final int id;
  final int chatId;
  final int senderId;
  final MessageType messageType;
  final dynamic content;
  final int requesterId;
  final int? streamId;
  final DateTime date;

  factory Message.fromJson(Map<String, dynamic> data) => Message(
    id: data['id'],
    chatId: data['chat_id'],
    senderId: data["sender"],
    requesterId: data["requester"] ?? 0,
    messageType: JoyveeFunctions.intToMessageType(data['type_id']),
    content: data['content'],
    date: DateTime.parse(data['date_create'])
  );

  @override
  List<Object> get props => [id, chatId];

  @override
  String toString() => '$id: $date';
}