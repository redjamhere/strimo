import 'dart:async';
import 'dart:collection';

import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:joyvee/src/models/models.dart';
import 'package:joyvee/src/repository/respository.dart';
import 'package:joyvee/src/utils/utils.dart';

part 'messenger_state.dart';

class MessengerCubit extends Cubit<MessengerState> {
  MessengerCubit({
    required MessengerRepository messengerRepository,
    required UserRepository userRepository,
    required OpenedChat openedChat
  }) : 
    _messengerRepository = messengerRepository,
    _userRepository = userRepository,  
    super(MessengerState(openedChat: openedChat)) {
      _messengerRepository.socket.getResponse.listen((message) {
        print(message);
      });
    }

  final MessengerRepository _messengerRepository;
  final UserRepository _userRepository;

  final TextEditingController textEditingController = TextEditingController();
  final ScrollController scrollController = ScrollController();
  
  @override
  Future<void> close() async {
    _messengerRepository.dispose();
    scrollController.dispose();
    textEditingController.dispose();
    return super.close();
  }

  void onMessengerTextFieldChanged() {
    if (textEditingController.text.isEmpty) {
      emit(state.copyWith(canSend: false));
    }
    if (textEditingController.text.isNotEmpty) {
      emit(state.copyWith(canSend: true));
    }
  }

  void onMessengerEmojiPickerShowed() {
    emit(state.copyWith(emojiShowing: state.emojiShowing ? false : true));
  }

  void onMessengerScrollPositionInited() {
    ///[TODO]: брать из кеша на какой позиции остался пользователь
    scrollController.jumpTo(scrollController.position.maxScrollExtent);
  }
  
  void onMessageSended(MessageType type) {
    if (type == MessageType.message) {
      _messengerRepository.sendMessage(message: SendedMessage(
        content: textEditingController.text.trim(), 
        receiverId: state.openedChat.receiver.userId!));
    }
  }

  // берет информацию о сообщениях в чате
  void onChatOpened() async {
    // если открыт новый чат
    /// [TODO] сделать проверку на наличие чата по переходу из профиля
    if (state.openedChat.chat == null) {
      emit(state.copyWith(chatLoadingStatus: FormzStatus.submissionSuccess));
    } else {
      emit(state.copyWith(chatLoadingStatus: FormzStatus.submissionInProgress));
      try {
        var chatData = await _messengerRepository.getChatMessagesData(chat: state.openedChat.chat!, user: _userRepository.user);
        emit(state.copyWith(
          chatLoadingStatus: FormzStatus.submissionSuccess, 
          openedChat: state.openedChat.copyWith(
            messageCount: chatData.messageCount,
            nextUrl: chatData.nextUrl,
            messages: chatData.messages
          )));
      } catch (e) {
        emit(state.copyWith(chatLoadingStatus: FormzStatus.submissionFailure, errorMessage: e.toString()));
      }
    }
  }

}