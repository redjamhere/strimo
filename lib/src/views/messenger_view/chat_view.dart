// описание чата
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:joyvee/src/models/models.dart';
import 'package:joyvee/src/repository/respository.dart';
import 'package:joyvee/src/utils/utils.dart';
import 'package:joyvee/src/widgets/widgets.dart';
import 'package:joyvee/src/cubit/cubit.dart';

import 'package:joyvee/src/bloc/bloc.dart';

class ChatView extends StatelessWidget {
  const ChatView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return BlocBuilder<MessengerCubit, MessengerState>(
      builder: (context, state) {
        return Scaffold(
            appBar: AppBar(
              iconTheme: const IconThemeData(color: Colors.black, size: 20),
              titleSpacing: 0,
              title: const _MessengerAppbarContentView(
                key: ObjectKey("appbar_content"),
              ),
            ),
            body: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                      controller:
                          context.read<MessengerCubit>().scrollController,
                      child: const _MessageListView(
                        key: ObjectKey("message_list"),
                      )),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                  child: Row(
                    children: [
                      Expanded(child: _TextFieldView()),
                    ],
                  ),
                ),
                const _EmojiPickerView()
              ],
            ));
      },
    );
  }
}

class _MessengerAppbarContentView extends StatelessWidget {
  const _MessengerAppbarContentView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MessengerCubit, MessengerState>(
      buildWhen: (previous, current) =>
          previous.openedChat != current.openedChat,
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CircleAvatar(
              foregroundImage:
                  CachedNetworkImageProvider(state.openedChat.receiver.avatar!),
              backgroundImage: const AssetImage('assets/jpg/appicon-bw.jpg'),
            ),
            SizedBox(width: SizeConfig.blockSizeHorizontal! * 2),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    state.openedChat.receiver.firstname!,
                    style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                        fontSize: 17 * MediaQuery.textScaleFactorOf(context)),
                  ),
                  Text("Messages",
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          fontSize: 13 * MediaQuery.textScaleFactorOf(context)))
                ],
              ),
            )
          ],
        );
      },
    );
  }
}

class _MessageListView extends StatelessWidget {
  const _MessageListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: BlocBuilder<MessengerCubit, MessengerState>(
          buildWhen: (previous, current) =>
              previous.openedChat.messages != current.openedChat.messages,
          builder: (context, state) {
            if (state.chatLoadingStatus.isSubmissionSuccess) {
              return Column(children: [
                for (int index = 0;
                    index < state.openedChat.messages.length;
                    index++)
                  Column(children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: SizeConfig.blockSizeVertical!),
                      child: Text(
                        JoyveeFunctions.formatDateToMessengerSeparator(
                            state.openedChat.messages.keys.toList()[index]),
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            fontSize: 12 * MediaQuery.textScaleFactorOf(context)),
                      ),
                    ),
                    for (Message m in state.openedChat.messages[
                        state.openedChat.messages.keys.toList()[index]]!)
                      _MessageView(message: m)
                  ]),
              ]);
            } else if (state.chatLoadingStatus.isSubmissionInProgress) {
              return const FullScreenProgressIndicator();
            } else {
              return const Placeholder();
            }
          }),
    );
  }
}

class _MessageView extends StatelessWidget {
  _MessageView({required this.message});
  final Message message;

  final LinearGradient senderGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      JoyveeColors.darkPurple,
      JoyveeColors.darkPurple.withOpacity(.7),
    ],
  );

  @override
  Widget build(BuildContext context) {
    int userId = context.read<UserRepository>().user.id!;
    return Align(
      key: ValueKey(message.id),
      alignment: userId == message.senderId
          ? Alignment.centerRight
          : Alignment.centerLeft,
      child: Container(
        padding: EdgeInsets.all(SizeConfig.blockSizeVertical!),
        margin: EdgeInsets.symmetric(vertical: SizeConfig.blockSizeVertical!),
        constraints: BoxConstraints(
          maxWidth: SizeConfig.screenWidth! * 0.7,
        ),
        decoration: BoxDecoration(
            color: userId != message.senderId
                ? const Color.fromRGBO(0, 0, 0, 0.06)
                : null,
            gradient: (userId == message.senderId) ? senderGradient : null,
            borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(10),
                topRight: const Radius.circular(10),
                bottomLeft: userId == message.senderId
                    ? const Radius.circular(10)
                    : const Radius.circular(3),
                bottomRight: userId == message.senderId
                    ? const Radius.circular(3)
                    : const Radius.circular(10))),
        child: Text(
          message.content,
          style: TextStyle(
              color:
                  (userId == message.senderId) ? Colors.white : Colors.black),
        ),
      ),
    );
  }
}

class _TextFieldView extends StatelessWidget {
  _TextFieldView({super.key});

  final FocusNode focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MessengerCubit, MessengerState>(
        buildWhen: (previous, current) =>
            current.canSend != previous.canSend ||
            current.emojiShowing != previous.emojiShowing,
        builder: (context, state) => JoyveeDefaultTextField(
              textInputAction: TextInputAction.newline,
              textInputType: TextInputType.multiline,
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  fontSize: 17 * MediaQuery.textScaleFactorOf(context),
                  fontWeight: FontWeight.w400),
              controller: context.read<MessengerCubit>().textEditingController,
              hintText: 'Aa',
              borderRadius: 30,
              autofocus: true,
              focusNode: focusNode,
              onTap: null,
              onChanged: (val) =>
                  context.read<MessengerCubit>().onMessengerTextFieldChanged(),
              prefixIcon: (state.emojiShowing)
                  ? IconButton(
                      onPressed: () {
                        FocusManager.instance.primaryFocus?.unfocus();
                        context
                            .read<MessengerCubit>()
                            .onMessengerEmojiPickerShowed();
                      },
                      icon: const Icon(Icons.emoji_emotions),
                    )
                  : IconButton(
                      onPressed: () {
                        FocusScope.of(context).requestFocus(focusNode);
                        context
                            .read<MessengerCubit>()
                            .onMessengerEmojiPickerShowed();
                      },
                      icon: const Icon(Icons.keyboard),
                    ),
              showSuffix: true,
              suffixIcon: AnimatedSwitcher(
                  duration: const Duration(seconds: 2),
                  child: state.canSend
                      ? IconButton(
                          onPressed: () => context
                              .read<MessengerCubit>()
                              .onMessageSended(MessageType.message),
                          icon: const Icon(Icons.send))
                      : IconButton(
                          onPressed: () => null,
                          icon: const Icon(Icons.file_present))),
            ));
  }
}

class _EmojiPickerView extends StatelessWidget {
  const _EmojiPickerView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MessengerCubit, MessengerState>(
      buildWhen: (previous, current) =>
          previous.emojiShowing != current.emojiShowing,
      builder: (context, state) => Offstage(
        offstage: state.emojiShowing,
        child: SizedBox(
          height: SizeConfig.screenHeight! * 0.5,
          child: JoyveeEmojiPicker(
            key: const Key("emojiPicker"),
            controller: context.read<MessengerCubit>().textEditingController,
          ),
        ),
      ),
    );
  }
}
