import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:joyvee/src/mixin/mixins.dart';
import 'package:joyvee/src/models/models.dart';
import 'package:joyvee/src/repository/respository.dart';
import 'package:joyvee/src/utils/utils.dart';

part 'messenger_state.dart';
part 'messenger_event.dart';

class MessengerBloc extends Bloc<MessengerEvent, MessengerState> with UserStorageMixin {
  MessengerBloc({
    required MessengerRepository messengerRepository,
    required OpenedChat openedChat
  }) : 
    _messengerRepository = messengerRepository,
    super(MessengerState(openedChat: openedChat)) {
      on<MessengerTextFieldChanged>(_onMessengerTextFieldChanged);
      on<MessengerEmojiPickerShowed>(_onMessengerEmojiPickerShowed);
      on<MessengerScrollPositionInited>(_onMessengerScrollPositionInited);
      on<MessageSended>(_onMessageSended);
      on<ChatViewOpened>(_onChatViewOpened);
      on<MessageRequested>(_onMessageRequested);
    }

  final MessengerRepository _messengerRepository;

  final TextEditingController textEditingController = TextEditingController();
  final ScrollController scrollController = ScrollController();

  @override
  Future<void> close() async {
    scrollController.dispose();
    textEditingController.dispose();
    return super.close();
  }


  void _onMessengerTextFieldChanged(
    MessengerTextFieldChanged event,
    Emitter<MessengerState> emit
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
    ///[TODO]: брать из кеша на какой позиции остался пользователь
    scrollController.jumpTo(scrollController.position.maxScrollExtent);
  }
  
  void _onMessageSended(
    MessageSended event,
    Emitter<MessengerState> emit
  ) {
    if (event.type == MessageType.message) {
      _messengerRepository.sendMessage(message: SendedMessage(
        content: textEditingController.text.trim(), 
        receiverId: state.openedChat.receiver.userId!));
    }
    textEditingController.clear();
  }

  // берет информацию о сообщениях в чате
  void _onChatViewOpened(
    ChatViewOpened event,
    Emitter<MessengerState> emit
  ) async {
    // если открыт новый чат
    /// [TODO] сделать проверку на наличие чата по переходу из профиля
    if (state.openedChat.chat == null) {
      emit(state.copyWith(chatLoadingStatus: FormzStatus.submissionSuccess));
    } else {
      emit(state.copyWith(chatLoadingStatus: FormzStatus.submissionInProgress));
      try {
        var user = getUserFromStorage();
        var chatData = await _messengerRepository.getChatMessagesData(chat: state.openedChat.chat!, user: user!);
        emit(state.copyWith(
          userId: user.id,
          chatLoadingStatus: FormzStatus.submissionSuccess,
          openedChat: state.openedChat.copyWith(
            messageCount: chatData.messageCount,
            nextUrl: chatData.nextUrl),
            messages: chatData.messages));
      } catch (e) {
        emit(state.copyWith(chatLoadingStatus: FormzStatus.submissionFailure, errorMessage: e.toString()));
      }
    }
  }

  void _onMessageRequested(
    MessageRequested event,
    Emitter<MessengerState> emit
  ) async {
    await emit.forEach(_messengerRepository.messageStream.getResponse, 
    onData: (message) {
      if (message.chatId == state.openedChat.chat?.id) {
        return state.addMessage(message);
      } else {
        return state;
      }
    });
  }
}