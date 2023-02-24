part of 'stream_chat_bloc.dart';

class StreamChatState extends Equatable {
  const StreamChatState({
    required this.streamInfo,
    this.isConnected = false,
    this.messages = const [],
  });

  final bool isConnected;
  final JStream streamInfo;
  final List<StreamChatMessage> messages;

  StreamChatState copyWith({
    bool? isConnected,
    JStream? streamInfo,
    List<StreamChatMessage>? messages,
  }) => StreamChatState(
    isConnected: isConnected?? this.isConnected,
    streamInfo: streamInfo?? this.streamInfo,
    messages: messages?? this.messages
  );

  @override
  List<Object> get props => [isConnected, streamInfo, messages];
}