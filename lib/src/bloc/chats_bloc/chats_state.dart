part of 'chats_bloc.dart';


class ChatsState extends Equatable {
  const ChatsState({
    this.defaultChats = const [],
    this.streamChats = const [],
    this.groupChats = const [],
    this.errorMessage = "",
    this.openedChat
  });


  final List<Chat> defaultChats;
  final List<StreamChat> streamChats;
  final List<GroupChat> groupChats;

  final OpenedChat? openedChat;

  final String errorMessage;

  ChatsState copyWith({
    List<Chat>? defaultChats,
    List<StreamChat>? streamChats,
    List<GroupChat>? groupChats,
    String? errorMessage,
    OpenedChat? openedChat
  }) => ChatsState(
    defaultChats: defaultChats?? this.defaultChats,
    streamChats: streamChats?? this.streamChats,
    groupChats: groupChats?? this.groupChats,
    errorMessage: errorMessage?? this.errorMessage,
    openedChat: openedChat?? this.openedChat
  );

  @override 
  List<Object?> get props => [
    defaultChats, 
    streamChats, 
    groupChats,
    errorMessage,
    openedChat,
  ];
}