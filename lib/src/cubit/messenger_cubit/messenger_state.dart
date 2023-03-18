part of 'messenger_cubit.dart';

class MessengerState extends Equatable {
  const MessengerState({
    this.canSend = false,
    this.emojiShowing = true,
    required this.openedChat,
    this.chatLoadingStatus = FormzStatus.pure,
    this.messagesLoadingStatus = FormzStatus.pure,
    this.errorMessage = ""
  });

  final bool canSend;
  final bool emojiShowing;
  final OpenedChat openedChat;

  final FormzStatus chatLoadingStatus;
  final FormzStatus messagesLoadingStatus;

  final String errorMessage;

  MessengerState copyWith({
    bool? canSend,
    bool? emojiShowing,
    OpenedChat? openedChat,
    FormzStatus? chatLoadingStatus,
    FormzStatus? messagesLoadingStatus,
    String? errorMessage
  }) => MessengerState(
    canSend: canSend?? this.canSend,
    emojiShowing: emojiShowing?? this.emojiShowing,
    openedChat: openedChat?? this.openedChat,
    chatLoadingStatus: chatLoadingStatus?? this.chatLoadingStatus,
    messagesLoadingStatus: messagesLoadingStatus?? this.messagesLoadingStatus,
    errorMessage: errorMessage?? this.errorMessage
  );

  @override
  List<Object> get props => [
    canSend, 
    emojiShowing, 
    chatLoadingStatus, 
    messagesLoadingStatus,
    errorMessage,
    openedChat
  ];
}