// описание чата
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:joyvee/src/models/models.dart';
import 'package:joyvee/src/utils/utils.dart';
import 'package:joyvee/src/widgets/widgets.dart';
import 'package:joyvee/src/cubit/cubit.dart';

class ChatView extends StatelessWidget {
  const ChatView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
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
          const Expanded(
            child: _MessageListViewNew(key: ValueKey('message_list'))      
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
            child: Row(
              children: [
                Expanded(child: _TextFieldView()),
              ],
            ),
          ),
          const _EmojiPickerView()
        ],
      ),
    );
  }
}

class _MessengerAppbarContentView extends StatelessWidget {
  const _MessengerAppbarContentView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MessengerBloc, MessengerState>(
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

class _MessageListViewNew extends StatelessWidget {
  const _MessageListViewNew({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MessengerBloc, MessengerState>(
      buildWhen: (previous, current) =>
          previous.messages.length != current.messages.length ||
          previous.chatLoadingStatus != current.chatLoadingStatus,
      builder: (context, state) {
        return ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          reverse: true,
          itemCount: state.messages.length,
          itemBuilder: (context, index) => _MessageView(
              key: ValueKey('message_$index'), message: state.messages[index]),
        );
      },
    );
  }
}

class _MessageView extends StatelessWidget {
  _MessageView({required this.message, super.key});
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
    var userId = context.read<MessengerBloc>().state.userId;
    return Align(
      key: key,
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
    return BlocBuilder<MessengerBloc, MessengerState>(
        buildWhen: (previous, current) =>
            current.canSend != previous.canSend ||
            current.emojiShowing != previous.emojiShowing,
        builder: (context, state) => JoyveeDefaultTextField(
              textInputAction: TextInputAction.newline,
              textInputType: TextInputType.multiline,
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  fontSize: 17 * MediaQuery.textScaleFactorOf(context),
                  fontWeight: FontWeight.w400),
              controller: context.read<MessengerBloc>().textEditingController,
              hintText: 'Aa',
              borderRadius: 30,
              autofocus: true,
              focusNode: focusNode,
              onTap: null,
              onChanged: (val) =>
                  context.read<MessengerBloc>().add(MessengerTextFieldChanged()),
              prefixIcon: (state.emojiShowing)
                  ? IconButton(
                      onPressed: () {
                        FocusManager.instance.primaryFocus?.unfocus();
                        context
                            .read<MessengerBloc>().add(MessengerEmojiPickerShowed());
                      },
                      icon: const Icon(Icons.emoji_emotions),
                    )
                  : IconButton(
                      onPressed: () {
                        FocusScope.of(context).requestFocus(focusNode);
                        context
                            .read<MessengerBloc>().add(MessengerEmojiPickerShowed());
                      },
                      icon: const Icon(Icons.keyboard),
                    ),
              showSuffix: true,
              suffixIcon: AnimatedSwitcher(
                  duration: const Duration(seconds: 2),
                  child: state.canSend
                      ? IconButton(
                          onPressed: () => context
                              .read<MessengerBloc>().add(
                                const MessageSended(MessageType.message)),
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
    return BlocBuilder<MessengerBloc, MessengerState>(
      buildWhen: (previous, current) =>
          previous.emojiShowing != current.emojiShowing,
      builder: (context, state) => Offstage(
        offstage: state.emojiShowing,
        child: SizedBox(
          height: SizeConfig.screenHeight! * 0.5,
          child: JoyveeEmojiPicker(
            key: const Key("emojiPicker"),
            controller: context.read<MessengerBloc>().textEditingController,
          ),
        ),
      ),
    );
  }
}
