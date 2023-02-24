part of 'stream_chat_bloc.dart';


// события для чата стр
class StreamChatEvent extends Equatable {
  const StreamChatEvent();

  @override
  List<Object> get props => [];
}

class StreamChatConnect extends StreamChatEvent {
  const StreamChatConnect();

  @override
  List<Object> get props => [];
}


class StreamChatConnected extends StreamChatEvent {
  const StreamChatConnected();

  @override
  List<Object> get props => [];
}

class StreamChatDisconnected extends StreamChatEvent{
  const StreamChatDisconnected();
  @override
  List<Object> get props => [];
}

class StreamChatReceiveMessage extends StreamChatEvent {
  const StreamChatReceiveMessage(this.message);
  final StreamChatMessage message;

  @override
  List<Object> get props => [];
}

class StreamChatSendMessage extends StreamChatEvent {
  const StreamChatSendMessage(this.message);
  final String message;

  @override
  List<Object> get props => [message];
}