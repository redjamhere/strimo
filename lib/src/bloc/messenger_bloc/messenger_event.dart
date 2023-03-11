part of 'messenger_bloc.dart';

abstract class MessengerEvent extends Equatable {}

class MessengerTextFieldChanged extends MessengerEvent {
  List<Object> get props => [];
}

class MessengerEmojiPickerShowed extends MessengerEvent {
  List<Object> get props => [];
}

class MessengerScrollPositionInited extends MessengerEvent {
  List<Object> get props => [];
}