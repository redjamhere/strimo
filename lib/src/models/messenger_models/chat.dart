// Описание моделей сообщений и чатов

import 'package:joyvee/src/interfaces/interfaces.dart';

import '../../utils/utils.dart';
import './message.dart';

class Chat {
  final int id;
  final ChatType type;
  final int? ownerId;
  final List<ChatMember> members;
  final Message lastMessage;
  final bool? isStreamDeleted;

  const Chat({
    required this.id,
    required this.type,
    this.ownerId,
    required this.members,
    required this.lastMessage,
    this.isStreamDeleted
  });

  factory Chat.fromJson(Map<String, dynamic> data) => Chat(
    id: data['id_chat'],
    type: JoyveeFunctions.chatTypeFromString(data['type_chat']),
    ownerId: data['owner_id'],
    members: List.generate(data['members'].length, (index) => ChatMember.fromJson(data['members'][index])),
    lastMessage: Message.fromJson(data['last_msg']),
    isStreamDeleted: (data['type_chat'] == "STREAM") ? data['is_stream_deleted'] : null,
  );
}

class ChatMember extends Profile {
  const ChatMember({
    required int userId,
    required String firstname,
    required String lastname,
    required String avatar,
    required bool isOnline
  }) : super(
    userId: userId,
    firstname: firstname,
    lastname: lastname,
    avatar: avatar,
    isOnline: isOnline
  );

  factory ChatMember.fromJson(Map<String, dynamic> data) => ChatMember(
      userId: data['user_id'],
      firstname: data['firstname'],
      lastname: data['lastname'],
      avatar: data['avatar'],
      isOnline: data['is_online']);

  @override
  Map<String, dynamic> toJson() => {};

  @override
  List<Object> get props => [];
}

// class Message {
//   final int? id;
//   final int? chatId;
//   final int senderId;
//   final MessageType type;
//   final dynamic content;
//   final int? requesterId;
//   final int? streamId;
//   final DateTime? createTime;
//
//   const Message({
//     this.id,
//     this.chatId,
//     required this.senderId,
//     required this.type,
//     required this.content,
//     this.requesterId,
//     this.streamId,
//     this.createTime});
//
//   factory Message.fromJson(Map<String, dynamic> data) => Message(
//       id: data['id'],
//       chatId: data['chat_id'],
//       senderId: data["sender"],
//       type: JoyveeFunctions.intToMessageType(data['type_id']),
//       content: data['content'],
//       createTime: DateTime.parse(data['date_create'])
//   );
//
//   Map<String, dynamic> toJson() => {
//     "chat_id": chatId,
//     "sender": senderId,
//     "stream_id": streamId,
//     "type": JoyveeFunctions.messageTypeToString(type),
//     "requester_id": requesterId,
//     "content": content
//   };
//
//   @override
//   String toString() => 'MESSAGE FROM $senderId';
// }