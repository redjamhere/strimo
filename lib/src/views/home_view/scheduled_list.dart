// описание списка запланнированных трансляций пользователя
import 'package:flutter/material.dart';
import 'package:joyvee/src/models/models.dart';
import 'package:joyvee/src/utils/utils.dart';
import 'package:joyvee/src/widgets/widgets.dart';

class UserScheduledBroadcastList extends StatefulWidget {
  UserScheduledBroadcastList({Key? key}) : super(key: key);

  @override
  State<UserScheduledBroadcastList> createState() => _UserScheduledBroadcastListState();
}

class _UserScheduledBroadcastListState extends State<UserScheduledBroadcastList> {
  final List<UserScheduledBroadcast> _list = [
    UserScheduledBroadcast(
        id: 0,
        title: 'Hello world',
        description: 'My scheduled broadcast today',
        preview: "https://picsum.photos/300")
  ];

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Container(
      color: Theme.of(context).colorScheme.background,
      child: (true) ?
        RefreshIndicator(
          child: ListView(
            children: List.generate(_list.length, (index) => Card(
                child: Column(
                  children: [
                    ListTile(
                      leading: Image.network(_list[index].preview!),
                      title: Text(_list[index].title!),
                      subtitle: Text(_list[index].description!),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        JoyveeTextButton(
                          func: () => print('text button'),
                          style: Theme.of(context).textButtonTheme.style!.copyWith(
                              textStyle: MaterialStateProperty.all<TextStyle>(const TextStyle(fontSize: 14))),
                          child: const Text('Edit', style: TextStyle(color: JoyveeColors.jvGreen)),
                        ),
                        JoyveeTextButton(
                          func: () => print('text button'),
                          style: Theme.of(context).textButtonTheme.style!.copyWith(
                              textStyle: MaterialStateProperty.all<TextStyle>(const TextStyle(fontSize: 14))),
                          child: const Text('Start now', style: TextStyle(color: JoyveeColors.jvRed)),
                        ),
                      ],
                    )
                  ],
                )
            ))
          ),
          onRefresh: () async => await Future.delayed(const Duration(seconds: 3), () => setState(() => _list.add(
              UserScheduledBroadcast(
                  id: 1,
                  title: "Moment of live",
                  description: "Kazan live",
                  preview: "https://img.youscreen.ru/wall/14977701385297/14977701385297_1920x1200.jpg")))))
          : EmptyList()
    );
  }
}

// child: SingleChildScrollView(
//   physics: const AlwaysScrollableScrollPhysics(),
//   child: Container(
//     padding: const EdgeInsets.only(bottom: 80),
//     color: Colors.white,
//     height: SizeConfig.safeBlockVertical! * 100,
//     width: SizeConfig.blockSizeHorizontal! * 100,
//     alignment: Alignment.center,
//     child: Text("sheshn"),),
// ),

class EmptyList extends StatelessWidget {
  const EmptyList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      child: Container(
        alignment: Alignment.center,
        height: MediaQuery.of(context).size.height * 0.7,
        child: const Text(
          'You have no scheduled broadcasts 😞',
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 18,
              color: Colors.black12
          ),
        ),
      ),
    );
  }
}