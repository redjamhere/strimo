// описание чата
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:joyvee/src/utils/utils.dart';
import 'package:joyvee/src/widgets/widgets.dart';

class ChatView extends StatelessWidget {
  ChatView({Key? key}) : super(key: key);
  final TextEditingController _messengerController = TextEditingController();

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
            child: ListView.builder(
              itemCount: 20,
              itemBuilder: (ctx, index) => Text('sjsj'),
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
                GestureDetector(
                    onTap: () => "",
                    child: const Icon(Icons.photo_camera_outlined, size: 25,)),
                SizedBox(width: SizeConfig.blockSizeHorizontal! * 3),
                GestureDetector(
                    child: const Icon(Icons.photo_outlined, size: 25,)),
                SizedBox(width: SizeConfig.blockSizeHorizontal! * 3),
                GestureDetector(
                    child: const Icon(Icons.mic_none_outlined, size: 25,)),
                SizedBox(width: SizeConfig.blockSizeHorizontal! * 3),
                GestureDetector(child: const Icon(Icons.location_on_outlined, size: 25)),
                SizedBox(width: SizeConfig.blockSizeHorizontal! * 5),
                Expanded(
                  child: JoyveeDefaultTextField(
                    textInputAction: TextInputAction.send,
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 17 * MediaQuery.textScaleFactorOf(context), fontWeight: FontWeight.w400),
                    controller: _messengerController,
                    hintText: 'Aa',
                    borderRadius: 30,
                    showSuffix: true,
                    suffixIcon: IconButton(
                      onPressed: () => null,
                      icon: const Icon(Icons.emoji_emotions_outlined, color: Colors.black, size: 30,),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      )
    );
  }
}
