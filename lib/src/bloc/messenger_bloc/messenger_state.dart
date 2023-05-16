part of 'messenger_bloc.dart';

class MessengerState extends Equatable {
  const MessengerState({
    this.canSend = false,
    this.emojiShowing = true,
    required this.openedChat,
    this.chatLoadingStatus = FormzStatus.pure,
    this.messagesLoadingStatus = FormzStatus.pure,
    this.errorMessage = "",
    this.userId,
    this.messages = const [],
  });

  final bool canSend;
  final bool emojiShowing;
  final OpenedChat openedChat;
  final List<Message> messages;

  final FormzStatus chatLoadingStatus;
  final FormzStatus messagesLoadingStatus;

  final String errorMessage;

  final int? userId;

  MessengerState addMessage(Message message) {
    messages.insert(messages.length, message);
    return this;
  }

  MessengerState copyWith({
    bool? canSend,
    bool? emojiShowing,
    OpenedChat? openedChat,
    FormzStatus? chatLoadingStatus,
    FormzStatus? messagesLoadingStatus,
    String? errorMessage,
    int? userId,
    List<Message>? messages
  }) => MessengerState(
    canSend: canSend?? this.canSend,
    emojiShowing: emojiShowing?? this.emojiShowing,
    openedChat: openedChat?? this.openedChat,
    chatLoadingStatus: chatLoadingStatus?? this.chatLoadingStatus,
    messagesLoadingStatus: messagesLoadingStatus?? this.messagesLoadingStatus,
    errorMessage: errorMessage?? this.errorMessage,
    userId: userId?? this.userId,
    messages: messages?? this.messages
  );

  @override
  List<Object?> get props => [
    canSend, 
    emojiShowing, 
    chatLoadingStatus, 
    messagesLoadingStatus,
    errorMessage,
    openedChat,
    userId,
    messages
  ];
}