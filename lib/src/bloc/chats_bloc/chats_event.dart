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