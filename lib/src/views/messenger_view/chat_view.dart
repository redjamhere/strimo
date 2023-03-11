// описание чата
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:joyvee/src/models/models.dart';
import 'package:joyvee/src/repository/respository.dart';
import 'package:joyvee/src/utils/utils.dart';
import 'package:joyvee/src/widgets/widgets.dart';

import 'package:joyvee/src/bloc/bloc.dart';

class ChatView extends StatelessWidget {
  ChatView({Key? key}) : super(key: key);
  final LinearGradient senderGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      JoyveeColors.darkPurple,
      JoyveeColors.darkPurple.withOpacity(.7),
    ],
  );
  FocusNode focusNode = FocusNode();

  Widget _buildMessage(Message m) {
    return Builder(
      key: ValueKey(m.id),
      builder: (context) {
        int userId = context.read<UserRepository>().user.id!;
        return Align(
          alignment: userId == m.senderId ? Alignment.centerRight : Alignment.centerLeft,
          child: Container(
            padding: EdgeInsets.all(SizeConfig.blockSizeVertical!),
            margin: EdgeInsets.symmetric(vertical: SizeConfig.blockSizeVertical!),
            constraints: BoxConstraints(
              maxWidth: SizeConfig.screenWidth! * 0.7,
            ),
            decoration: BoxDecoration(
              color: userId != m.senderId 
                ? const Color.fromRGBO(0, 0, 0, 0.06) 
                : null,
              gradient: (userId == m.senderId) ? senderGradient : null,
              borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(10),
                topRight: const Radius.circular(10),
                bottomLeft: userId == m.senderId
                    ? const Radius.circular(10)
                    : const Radius.circular(3),
                bottomRight: userId == m.senderId
                    ? const Radius.circular(3)
                    : const Radius.circular(10)
              )
            ),
            child: Text(m.content, 
              style: TextStyle(
                color: (userId == m.senderId) 
                  ? Colors.white
                  : Colors.black),),
          ),
        );
      }
    );
  }
  Widget _buildMessageList() {
    return BlocBuilder<MessengerBloc, MessengerState>(
      buildWhen: (previous, current) => previous.messages != current.messages,
      builder: (context, state) => Column(
        children: [
          for (int index = 0; index < state.messages.length; index++)
            Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: SizeConfig.blockSizeVertical!),
                  child: Text(
                      JoyveeFunctions.formatDateToMessengerSeparator(
                          state.messages.keys.toList()[index]),
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        fontSize: 12 * MediaQuery.textScaleFactorOf(context)),
                  ),
                ),
                for(Message m in state.messages[state.messages.keys.toList()[index]]!) 
                  _buildMessage(m)
              ]),
        ],
      )
    );
  }

  Widget _buildTextField() {
    return BlocBuilder<MessengerBloc, MessengerState>(
      buildWhen: (previous, current) => current.canSend != previous.canSend 
        || current.emojiShowing != previous.emojiShowing,
      builder: (context, state) => JoyveeDefaultTextField(
        textInputAction: TextInputAction.newline,
        textInputType: TextInputType.multiline,
        style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 17 * MediaQuery.textScaleFactorOf(context), fontWeight: FontWeight.w400),
        controller: context.read<MessengerBloc>().textEditingController,
        hintText: 'Aa',
        borderRadius: 30,
        autofocus: true,
        focusNode: focusNode,
        onTap: null,  
        onChanged: (val) => context.read<MessengerBloc>().add(MessengerTextFieldChanged()),
        prefixIcon: (state.emojiShowing)
          ? IconButton(
            onPressed: () {
              FocusManager.instance.primaryFocus?.unfocus();
              context.read<MessengerBloc>().add(MessengerEmojiPickerShowed());
            } ,
            icon: const Icon(Icons.emoji_emotions),
          )
          : IconButton(
            onPressed: () {
              FocusScope.of(context).requestFocus(focusNode);
              context.read<MessengerBloc>().add(MessengerEmojiPickerShowed());
            },
            icon: const Icon(Icons.keyboard),
          ),
        showSuffix: true,
        suffixIcon: AnimatedSwitcher(
          duration: const Duration(seconds: 2),
          child: state.canSend
            ? IconButton(
                onPressed: () => null,
                icon: const Icon(Icons.send))
            : IconButton(
                onPressed: () => null,
                icon: const Icon(Icons.file_present))
        ),
      )
    );
  }

  Widget _buildEmojiPicker() {
    return BlocBuilder<MessengerBloc, MessengerState>(
      buildWhen: (previous, current) => previous.emojiShowing != current.emojiShowing,
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

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.black,
          size: 20
        ),
        titleSpacing: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const CircleAvatar(
              foregroundImage: CachedNetworkImageProvider("https://i.pravatar.cc/500"),
            ),
            SizedBox(width: SizeConfig.blockSizeHorizontal! * 2),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Тереза мэй",
                    style: Theme.of(context).textTheme.headlineLarge!
                        .copyWith(
                        fontSize: 17 * MediaQuery.textScaleFactorOf(context)),),
                  Text("Messages",
                    style: Theme.of(context).textTheme.bodySmall!.
                      copyWith(
                      fontSize: 13 * MediaQuery.textScaleFactorOf(context)
                    ))
                ],
              ),
            )
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(
                left: 10,
                right: 10,
              ),
              child: SingleChildScrollView(
                controller: context.read<MessengerBloc>().scrollController,
                child: _buildMessageList()
              )
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 10,
              right: 10,
              bottom: 10
            ),
            child: Row(
              children: [
                Expanded(
                  child: _buildTextField()
                ),
              ],
            ),
          ),
          _buildEmojiPicker()
        ],
      )
    );
  }
}
