// описание спика сообщений
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:joyvee/src/bloc/bloc.dart';
import 'package:joyvee/src/models/messenger_models/chat.dart';
import 'package:joyvee/src/repository/respository.dart';
import 'package:joyvee/src/utils/utils.dart';
import 'package:joyvee/src/views/messenger_view/chat_view.dart';
import 'package:joyvee/src/widgets/widgets.dart';
import 'package:joyvee/src/cubit/cubit.dart';

class ChatList extends StatelessWidget {
  const ChatList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: BlocConsumer<ChatsBloc, ChatsState>(
        listenWhen: (previous, current) => previous.openedChat != current.openedChat,
        listener: (context, state) {
          Navigator.push(context, CupertinoPageRoute(
            builder: (context) => BlocProvider(
              // ================================ //
              create: (context) => MessengerCubit(
                messengerRepository: context.read<MessengerRepository>(), 
                userRepository: context.read<UserRepository>(), 
                openedChat: state.openedChat!)..onChatOpened(),
                child: const ChatView(),
              // ================================ //
            )));
        },
        builder: (context, state) {
          return ListView.separated(
            addAutomaticKeepAlives: false,
            itemCount: state.defaultChats.length,
            separatorBuilder: (ctx, index) =>
                SizedBox(height: SizeConfig.blockSizeVertical! * 2),
            itemBuilder: (ctx, index) {
              return Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {
                    context.read<ChatsBloc>().add(ChatOpened(
                    chat: state.defaultChats[index]));
                  },
                  child: Row(
                    children: [
                      JoyveeProfileAvatar(
                          avatar: state.defaultChats[index].members[0].avatar!,
                          isOnline: state.defaultChats[index].members[0].isOnline!),
                      SizedBox(width: SizeConfig.blockSizeHorizontal! * 3),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  JoyveeFunctions.ellipsisString(
                                      '${state.defaultChats[index].members[0].firstname!} ${state.defaultChats[index].members[0].lastname!}'),
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleLarge!
                                      .copyWith(
                                          fontSize: 14 *
                                              MediaQuery.textScaleFactorOf(
                                                  context),
                                          color: Theme.of(context)
                                              .colorScheme
                                              .scrim),
                                ),
                                RichText(
                                  text: TextSpan(children: [
                                    const WidgetSpan(
                                        child: Icon(
                                      Icons.abc,
                                      color: JoyveeColors.jvLightBlueLink,
                                    )),
                                    const TextSpan(text: " "),
                                    TextSpan(
                                        text: JoyveeFunctions
                                            .parseDateTimeToString(state.defaultChats[index]
                                                .lastMessage
                                                .date!),
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall!
                                            .copyWith(fontSize: 14))
                                  ]),
                                )
                              ],
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    JoyveeFunctions.ellipsisString(
                                        state.defaultChats[index].lastMessage.content),
                                    maxLines: 2,
                                    textScaleFactor:
                                        MediaQuery.textScaleFactorOf(context),
                                    overflow: TextOverflow.ellipsis,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall!
                                        .copyWith(fontSize: 14),
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.all(2),
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(360),
                                      color: JoyveeColors.jvLightBlueLink),
                                  child: Text(
                                    '123',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineLarge!
                                        .copyWith(
                                            fontSize: 14, color: Colors.white),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class StreamChatList extends StatelessWidget {
  const StreamChatList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      width: SizeConfig.screenWidth,
      child: ListView.separated(
          itemCount: 50,
          itemBuilder: (ctx, index) => Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () => '',
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: SizeConfig.blockSizeHorizontal! * 18,
                        height: SizeConfig.blockSizeVertical! * 7,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: CachedNetworkImageProvider(
                                    "https://picsum.photos/20$index"))),
                      ),
                      SizedBox(width: SizeConfig.blockSizeHorizontal! * 3),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                  child: Text(
                                      JoyveeFunctions.ellipsisString(
                                          'Тереза Мей'),
                                      overflow: TextOverflow.ellipsis,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge!
                                          .copyWith(
                                            fontSize: 14 *
                                                MediaQuery.textScaleFactorOf(
                                                    context),
                                            color: Theme.of(context)
                                                .colorScheme
                                                .scrim,
                                          )),
                                ),
                                SizedBox(
                                    width: SizeConfig.blockSizeHorizontal!),
                                Wrap(
                                  crossAxisAlignment: WrapCrossAlignment.center,
                                  children: [
                                    CircleAvatar(
                                      foregroundImage:
                                          CachedNetworkImageProvider(
                                              "https://i.pravatar.cc/35$index"),
                                      radius: 12,
                                    ),
                                    SizedBox(
                                      width: SizeConfig.blockSizeHorizontal!,
                                    ),
                                    Visibility(
                                        visible: true,
                                        child: Icon(
                                          Icons.circle,
                                          color: JoyveeColors.jvGreen,
                                          size: SizeConfig.blockSizeVertical! *
                                              1.5,
                                        ))
                                  ],
                                ),
                                Wrap(
                                  crossAxisAlignment: WrapCrossAlignment.center,
                                  children: [
                                    const Icon(
                                      Icons.check,
                                      color: JoyveeColors.jvLightBlueLink,
                                    ),
                                    Text("31 december 2020",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall!
                                            .copyWith(
                                                fontSize: 14 *
                                                    MediaQuery
                                                        .textScaleFactorOf(
                                                            context)))
                                  ],
                                )
                              ],
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                          JoyveeFunctions.ellipsisString(
                                              'Съемка города Личфилд'),
                                          overflow: TextOverflow.ellipsis,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyLarge),
                                      Text(
                                        JoyveeFunctions.ellipsisString((index %
                                                    2 ==
                                                0)
                                            ? 'Привет. Хочу поучаствовать в стриме. Готов забронировать'
                                            : 'Привет'),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall!
                                            .copyWith(
                                                fontSize: 14 *
                                                    MediaQuery
                                                        .textScaleFactorOf(
                                                            context)),
                                      )
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.all(2),
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(360),
                                      color: JoyveeColors.jvLightBlueLink),
                                  child: Text(
                                    '123',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineLarge!
                                        .copyWith(
                                            fontSize: 14, color: Colors.white),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
          separatorBuilder: (ctx, index) =>
              SizedBox(height: SizeConfig.blockSizeVertical! * 2)),
    );
  }
}
