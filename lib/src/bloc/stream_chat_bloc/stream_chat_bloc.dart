import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:joyvee/src/mixin/mixins.dart';
import 'package:joyvee/src/models/models.dart';
import 'package:joyvee/src/repository/respository.dart';
import 'package:socket_io_client/socket_io_client.dart';

part 'stream_chat_event.dart';
part 'stream_chat_state.dart';

class StreamChatBloc extends Bloc<StreamChatEvent, StreamChatState> with UserStorageMixin{
  StreamChatBloc({
    required JStream streamInfo,
    required StreamChatRepository streamChatRepository
  }) 
    : _streamChatRepository = streamChatRepository,
    super(StreamChatState(streamInfo: streamInfo)) {
      on<StreamChatConnected>(_onStreamChatConnected);
      on<StreamChatConnect>(_onStreamChatConnect);
      on<StreamChatReceiveMessage>(_onStreamChatReceiveMessage);
      on<StreamChatSendMessage>(_onStreamChatSendMessage);
    }
  
  final StreamChatRepository _streamChatRepository;

  void _onStreamChatConnected(
    StreamChatConnected event,
    Emitter<StreamChatState> emit
  ) {
    emit(state.copyWith(isConnected: true));
  }

  void _onStreamChatConnect(
    StreamChatConnect event,
    Emitter<StreamChatState> emit
  ) {
    var user = getUserFromStorage();
    _streamChatRepository.connectToChat(user!.token!, state.streamInfo.key!);
    _streamChatRepository.socket.onConnect((data) => add(const StreamChatConnected()));
    _streamChatRepository.socket.onDisconnect((data) => add(const StreamChatDisconnected()));
    _streamChatRepository.socket.on('receive_message', 
      (data) => add(StreamChatReceiveMessage(StreamChatMessage.fromJson(data)))); // TODO: привязать ивент
  }


  void _onStreamChatReceiveMessage(
    StreamChatReceiveMessage event,
    Emitter<StreamChatState> emit,
  ) {
    List<StreamChatMessage> temp = state.messages.toList();
    emit(state.copyWith(messages: state.messages.toList()..insert(0, event.message)));
  }

  void _onStreamChatSendMessage(
    StreamChatSendMessage event,
    Emitter<StreamChatState> emit
  ) {
    _streamChatRepository.sendMessage(state.streamInfo.key!, event.message);
  }

  @override
  Future<void> close() {
    _streamChatRepository.dispose();
    return super.close();
  }
}
