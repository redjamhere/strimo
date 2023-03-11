// описание логики мессенджера

import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:joyvee/messages_list.dart';
import 'package:joyvee/src/models/models.dart';
import 'package:joyvee/src/repository/respository.dart';

part 'messenger_state.dart';
part 'messenger_event.dart';

class MessengerBloc extends Bloc<MessengerEvent, MessengerState> {
  MessengerBloc({
    required UserRepository userRepository,
    required MessengerRepository messengerRepository,
  })
  : _userRepository = userRepository,
    _messengerRepository = messengerRepository,
    super(MessengerState()) {
      on<MessengerTextFieldChanged>(_onMessengerTextFieldChanged);
      on<MessengerEmojiPickerShowed>(_onMessengerEmojiPickerShowed);
      on<MessengerScrollPositionInited>(_onMessengerScrollPositionInited);
    }
    
  final UserRepository _userRepository;
  final MessengerRepository _messengerRepository;
  final TextEditingController textEditingController = TextEditingController();
  final ScrollController scrollController = ScrollController();

  void _onMessengerTextFieldChanged(
    MessengerTextFieldChanged event,
    Emitter<MessengerState> emit,
  ) {
    if (textEditingController.text.isEmpty) {
      emit(state.copyWith(canSend: false));
    }
    if (textEditingController.text.isNotEmpty) {
      emit(state.copyWith(canSend: true));
    }
  }

  void _onMessengerEmojiPickerShowed(
    MessengerEmojiPickerShowed event,
    Emitter<MessengerState> emit
  ) {
    emit(state.copyWith(emojiShowing: state.emojiShowing ? false : true));
  }

  void _onMessengerScrollPositionInited(
    MessengerScrollPositionInited event,
    Emitter<MessengerState> emit
  ) {
    //TODO: брать из кеша на какой позиции остался пользователь
    scrollController.jumpTo(scrollController.position.maxScrollExtent);
  }
}