// описание логики мессенджера

import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:google_place/google_place.dart';
import 'package:joyvee/src/cubit/cubit.dart';
import 'package:joyvee/src/interfaces/interfaces.dart';
import 'package:joyvee/src/models/models.dart';
import 'package:joyvee/src/repository/respository.dart';
import 'package:joyvee/src/views/messenger_view/chat_view.dart';

part 'chats_state.dart';
part 'chats_event.dart';

class ChatsBloc extends Bloc<ChatsEvent, ChatsState> {
  ChatsBloc({
    required UserRepository userRepository,
    required MessengerRepository messengerRepository,
  })
  : _userRepository = userRepository,
    _messengerRepository = messengerRepository,
    super(const ChatsState()) {
      on<ChatsRequested>(_onChatsRequested);
      on<ChatOpened>(_onChatOpened);
    }
    
  final UserRepository _userRepository;
  final MessengerRepository _messengerRepository;

  void _onChatsRequested(
    ChatsRequested event,
    Emitter<ChatsState> emit
  ) async {
    await emit.forEach(_messengerRepository.fetchChats(user: _userRepository.user), onData: (list) {
      if (list is List<StreamChat>) {
        return state.copyWith(streamChats: list);
      }
      if (list is List<GroupChat>) {
        return state.copyWith(groupChats: list);
      }
      return state.copyWith(defaultChats: list);
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