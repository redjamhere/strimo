//описание экрана выбора типа контекта (новая трансляция или запрос)
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:joyvee/src/utils/utils.dart';
import 'stream_type_view.dart';
import 'package:joyvee/src/widgets/widgets.dart';

class NewStreamView extends StatelessWidget {
  const NewStreamView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: JoyveeElevatedButton(
          style: Theme.of(context).elevatedButtonTheme.style!.copyWith(
              elevation: MaterialStateProperty.all<double>(10),
              shadowColor: MaterialStateProperty.all<Color>(JoyveeColors.jvOrange),
              minimumSize: MaterialStateProperty.all<Size>(const Size(60, 60)),
              padding: MaterialStateProperty.all<EdgeInsetsGeometry>(const EdgeInsets.all(20)),
              shape: MaterialStateProperty.all<CircleBorder>(const CircleBorder())
          ),
          func: () => Navigator.pop(context),
          child: const Icon(Icons.close)),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: SizeConfig.blockSizeHorizontal! * 4),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            JoyveeChooseStreamButton(
                onTap: () => Navigator.push(context, CupertinoPageRoute(
                  builder: (ctx) =>  const StreamTypeView())),
                title: "New stream",
                subtitle: "Let create or schedule a new stream",
                iconAsset: "assets/svg/new_stream_icon.svg"),
            SizedBox(height: SizeConfig.blockSizeHorizontal! * 5,),
            JoyveeChooseStreamButton(
                onTap: () => print('shesh'),
                title: "Stream request",
                subtitle: "Do you see some special? \nPost your request",
                iconAsset: "assets/svg/request_stream_icon.svg")
          ],
        ),
      ),
    );
  }
}
