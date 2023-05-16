part of 'messenger_bloc.dart';

abstract class MessengerEvent extends Equatable {
  const MessengerEvent();
  
  @override
  List<Object> get props => [];
}

class MessengerTextFieldChanged extends MessengerEvent{}

class MessengerEmojiPickerShowed extends MessengerEvent{}

class MessengerScrollPositionInited extends MessengerEvent {}

class MessageSended extends MessengerEvent{
  const MessageSended(this.type);
  final MessageType type;

  @override
  List<Object> get props => [type];
}

class ChatViewOpened extends MessengerEvent {}

class MessageRequested extends MessengerEvent {}