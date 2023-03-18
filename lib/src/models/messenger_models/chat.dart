// Описание моделей сообщений и чатов
import 'dart:collection';
import 'dart:convert';
import 'package:equatable/equatable.dart';
import 'package:joyvee/src/interfaces/interfaces.dart';
import 'package:joyvee/src/mixin/mixins.dart';
import 'package:joyvee/src/models/models.dart';

import '../../utils/utils.dart';
import './message.dart';

class Chat extends Equatable{
  final int id;
  final List<ChatMember> members;
  final Message lastMessage;

  const Chat({
    required this.id,
    required this.members,
    required this.lastMessage,
  });

  factory Chat.fromJson(Map<String, dynamic> data) => Chat(
    id: data['id_chat'],
    members: List.generate(data['members'].length, (index) => ChatMember.fromJson(data['members'][index])),
    lastMessage: Message.fromJson(data['last_msg']),
  );

  @override
  List<Object> get props => [id];
}

class StreamChat extends Chat {
  const StreamChat({
    required int id,
    required List<ChatMember> members,
    required Message lastMessage,
    required this.isStreamDeleted
  }) : super(id: id, members: members, lastMessage: lastMessage);

  final bool isStreamDeleted;

  factory StreamChat.fromJson(Map<String, dynamic> data) => StreamChat(
    id: data['id_chat'], 
    members: (data['members'] as List<Map<String, dynamic>>)
      .map((e) => ChatMember.fromJson(e)).toList(), 
    lastMessage: Message.fromJson(data['last_msg']), 
    isStreamDeleted: data['is_stream_deleted']);
} 

class GroupChat extends Chat {
  const GroupChat({
    required int id,
    required List<ChatMember> members,
    required this.ownerId,
    required Message lastMessage,
  }) : super(id: id, members: members, lastMessage: lastMessage);
  final int ownerId;

  factory GroupChat.fromJson(Map<String, dynamic> data) => GroupChat(
    id: data['id_chat'],
    members: (data['members'] as List<Map<String, dynamic>>)
      .map((e) => ChatMember.fromJson(e)).toList(),
    lastMessage: Message.fromJson(data['last_msg']), 
    ownerId: data['owner_id']
  );
}

class OpenedChat {
  OpenedChat({
    this.chat, 
    this.messageCount, 
    this.nextUrl, 
    LinkedHashMap<DateTime, List<Message>>? messages, 
    required this.receiver})
    : _messageList = messages?? LinkedHashMap<DateTime, List<Message>>.from({});
  
  final Chat? chat;
  final int? messageCount;
  final String? nextUrl;
  final Profile receiver;
  
  final LinkedHashMap<DateTime, List<Message>> _messageList;
  LinkedHashMap<DateTime, List<Message>> get messages => _messageList;

  factory OpenedChat.fromJson(Map<String, dynamic> data, ChatMember receiver) {
    var messageList = (data['results']['data'] as List)
      .map((e) => Message.fromJson(e)).toList();
    var mappedMessages = Map.fromIterable((messageList),
      key: (item) => (item as Message).date!.toUtc(),
      value:  (item) {
        List<Message> mss = [];
        for (Message m in messageList) {
          if (m.date!.year == item.date.year && m.date!.day == item.date.day && m.date!.month == item.date.month) {
            mss.add(m);
          }
        }
        return mss;
      }
    );
    return OpenedChat(
      messages: LinkedHashMap<DateTime, List<Message>>(
        equals: (DateTime? a, DateTime? b) {
          if (a == null || b == null) {
            return false;
          }
          return a.year == b.year && a.month == b.month && a.day == b.day;
        }
      )..addAll(mappedMessages),
      nextUrl: data['next'],
      messageCount: data['count'],
      receiver: receiver
    );
  }

  OpenedChat copyWith({
    Chat? chat,
    int? messageCount,
    String? nextUrl,
    Profile? receiver,
    LinkedHashMap<DateTime, List<Message>>? messages, 
  }) => OpenedChat(
    chat: chat?? this.chat,
    receiver: receiver?? this.receiver,
    nextUrl: nextUrl?? this.nextUrl,
    messageCount: messageCount?? this.messageCount,
    messages: messages?? this.messages,
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
      avatar: "${ImageAPI.avatarsURL}${data['avatar']}.jpg",
      isOnline: data['is_online']);

  @override
  Map<String, dynamic> toJson() => {};

  @override
  List<Object> get props => [userId!];
}