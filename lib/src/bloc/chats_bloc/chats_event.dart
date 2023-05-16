part of 'chats_bloc.dart';

abstract class ChatsEvent extends Equatable {}

class ChatsRequested extends ChatsEvent {
  @override
  List<Object> get props => [];
}

class ChatOpened extends ChatsEvent {
  ChatOpened({this.chat, this.receiver});
  final Chat? chat;
  final Profile? receiver;

  @override
  List<Object> get props => [];
}

class ChatMessageReceived extends ChatsEvent {
  ChatMessageReceived(this.message);
  final Message message;
  @override
  List<Object> get props => [];
}

class ChatLastMessageUpdated extends ChatsEvent {
  @override
  List<Object> get props => [];
}
