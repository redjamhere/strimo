part of 'messenger_bloc.dart';

class MessengerState extends Equatable {
  MessengerState({
    LinkedHashMap<DateTime, List<Message>>? messages,
    this.canSend = false,
    this.emojiShowing = true,
  }) : messages = kMessages; 

  final LinkedHashMap<DateTime, List<Message>> messages;
  final bool canSend;
  final bool emojiShowing;

  MessengerState copyWith({
    LinkedHashMap<DateTime, List<Message>>? messages,
    bool? canSend,
    bool? emojiShowing
  }) => MessengerState(
    messages: messages?? this.messages,
    canSend: canSend?? this.canSend,
    emojiShowing: emojiShowing?? this.emojiShowing
  );

  @override 
  List<Object> get props => [messages, canSend, emojiShowing];
}