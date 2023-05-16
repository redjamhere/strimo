// описание логики мессенджера

import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:joyvee/src/interfaces/interfaces.dart';
import 'package:joyvee/src/mixin/mixins.dart';
import 'package:joyvee/src/models/models.dart';
import 'package:joyvee/src/repository/respository.dart';

part 'chats_state.dart';
part 'chats_event.dart';

class ChatsBloc extends Bloc<ChatsEvent, ChatsState> with UserStorageMixin{
  ChatsBloc({
    required MessengerRepository messengerRepository,
  })
  : _messengerRepository = messengerRepository,
    super(const ChatsState()) {
      on<ChatsRequested>(_onChatsRequested);
      on<ChatOpened>(_onChatOpened);
      on<ChatLastMessageUpdated>(_onChatLastMessageUpdated);
    }
    
  final MessengerRepository _messengerRepository;
  late final StreamSubscription _messagesSubscription;
  
  @override
  Future<void> close() {
    _messagesSubscription.cancel();
    return super.close();
  }  

  void _onChatsRequested(
    ChatsRequested event,
    Emitter<ChatsState> emit
  ) async {
    var user = getUserFromStorage();
    await emit.forEach(_messengerRepository.fetchChats(user: user!), onData: (list) {
      if (list is List<StreamChat>) {
        return state.copyWith(streamChats: list);
      }
      if (list is List<GroupChat>) {
        return state.copyWith(groupChats: list);
      }
      return state.copyWith(defaultChats: list);
    });
  }

  void _onChatLastMessageUpdated(
    ChatLastMessageUpdated event,
    Emitter<ChatsState> emit
  ) async {
    await emit.forEach(_messengerRepository.messageStream.getResponse, 
      onData: (message) {
        int cIndex = state.defaultChats.indexWhere((element) => element.id == message.chatId);
        state.defaultChats[cIndex] = state.defaultChats[cIndex].copyWith(lastMessage: message);
        return state.copyWith(defaultChats: state.defaultChats);
      });
  }

  void _onChatOpened(
    ChatOpened event,
    Emitter<ChatsState> emit
  ) {
    late var op;
    if (event.chat != null) {
      op = OpenedChat(
          chat: event.chat,
          receiver: event.chat!.members[0]);
    } else {
      op = OpenedChat(receiver: event.receiver!);
    }
    emit(state.copyWith(openedChat: op));
  }

}