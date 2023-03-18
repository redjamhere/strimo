import 'dart:async';

import 'package:joyvee/src/interfaces/repository_interface.dart';
import 'package:joyvee/src/services/services.dart';
import 'package:joyvee/src/mixin/mixins.dart';
import 'package:joyvee/src/models/models.dart';

class MessengerRepository with UserMixin implements Repository{
  late final MessengerService _api;
  MessengerRepository() {
    init();
  }

  late final StreamSocket _socket;
  StreamSocket get socket => _socket;

  @override
  Future<void> init() async {
    var token = await getToken();
    if (token != null) {
     _api = MessengerService.init(token: token);
     _socket = _api.socket;
    } 
  }
  
  void sendMessage({required SendedMessage message}) {
    _api.sendMessage(msg: message.toJson());
  }

  void joinToChat({int? chatId}) {}

  Stream<List<Chat>> fetchChats({required JUser user}) async* {
    var result = await _api.fetchChats(user: user);
    yield (result['SINGLE'] as List).map((e) => Chat.fromJson(e)).toList();
    yield (result['STREAM'] as List).map((e) => StreamChat.fromJson(e)).toList();
    yield (result['GROUP'] as List).map((e) => GroupChat.fromJson(e)).toList();
  }

  Future<OpenedChat> getChatMessagesData({required Chat chat, required JUser user}) async {
    Map<String, dynamic> result = await _api.fetchMessages(chat: chat, user: user);
    var openedChat = OpenedChat.fromJson(result,
      chat.members.where((element) => element.userId != user.id).toList().first);
    return openedChat;
  }

  Future fetchNextMessages() async {}

  void dispose() {
    _socket.dispose();
  }
}