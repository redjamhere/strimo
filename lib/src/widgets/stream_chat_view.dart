// Описание виджета чата стримера

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:joyvee/src/bloc/stream_chat_bloc/stream_chat_bloc.dart';
import 'package:joyvee/src/widgets/widgets.dart';


//models
import '../models/models.dart';

//utils
import '../utils/utils.dart';

class StreamChatView extends StatefulWidget {
  StreamChatView({super.key, required this.onTap});
  final VoidCallback onTap;

  @override
  State<StreamChatView> createState() => _StreamChatViewState();
}

class _StreamChatViewState extends State<StreamChatView> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _chatFieldController = TextEditingController();
  bool emojiShowing = false;

  void _scrollDown() {
    _scrollController.animateTo(_scrollController.position.maxScrollExtent,
        duration: const Duration(seconds: 2), curve: Curves.fastOutSlowIn);
  }

  @override
  void initState() {
    context.read<StreamChatBloc>().add(const StreamChatConnect());
    super.initState();
  }

  @override
  void dispose() {
    _chatFieldController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Container(
      margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical! * 5),
      color: Colors.black.withOpacity(.8),
      width: double.infinity,
      height: SizeConfig.blockSizeVertical! * 50,
      child: Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: SizeConfig.blockSizeVertical! * 8),
            child: BlocBuilder<StreamChatBloc, StreamChatState>(
              builder: (context, state) {
                return ListView.builder(
                  controller: _scrollController,
                  itemCount: state.messages.length,
                  reverse: true,
                  shrinkWrap: true,
                  itemBuilder: (context, index) => ListTile(
                    title: Text(
                      "${state.messages[index].firstname!} ${state.messages[index].lastname!}",
                      style: const TextStyle(color: JoyveeColors.jvGreyBorder),
                    ),
                    subtitle: Text(
                      state.messages[index].message,
                      style: const TextStyle(color: Colors.white),
                    ),
                    leading: CircleAvatar(
                        foregroundImage: CachedNetworkImageProvider(
                          state.messages[index].avatar!),
                        backgroundImage: const AssetImage("assets/jpg/appicon-bw.jpg"),
                        ),
                  ),
                );
              },
            ),
          ),
          Positioned(
            bottom: SizeConfig.blockSizeVertical! * 2,
            left: SizeConfig.blockSizeHorizontal! * 5,
            right: SizeConfig.blockSizeHorizontal! * 5,
            child: JoyveeStreamTextField(
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 15, fontWeight: FontWeight.w400, color: Colors.white),
              suffixIcon: IconButton(
                icon: const Icon(Icons.emoji_emotions_outlined, color: Colors.white),
                onPressed: () => setState(() {
                  emojiShowing = !emojiShowing;  
                }),
              ),
              hintText: 'Message...',
              controller: _chatFieldController,
              onSubmit: (msg) {
                context.read<StreamChatBloc>().add(StreamChatSendMessage(msg));
                _chatFieldController.clear();
              },
            ),
          ),
          Positioned(
            top: 0,
            left: SizeConfig.blockSizeHorizontal! * 20,
            right: SizeConfig.blockSizeHorizontal! * 20,
            child: Container(
              width: SizeConfig.screenWidth,
              height: 1,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          Positioned(
            right: 0,
            top: 0,
            child: IconButton(
                onPressed: widget.onTap,
                color: Theme.of(context).colorScheme.primary,
                icon: const Icon(Icons.clear)),
          ),
        ],
      ),
    );
  }
}
