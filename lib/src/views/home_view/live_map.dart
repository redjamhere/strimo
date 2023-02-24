// Описание виджета с картой прямых трансляций и онлайн пользователей
import 'package:flutter/material.dart';
import 'package:joyvee/src/bloc/bloc.dart';
import 'package:joyvee/src/widgets/map_with_custom_marker.dart';
import 'package:joyvee/src/widgets/widgets.dart';
import 'package:joyvee/src/utils/utils.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LiveMap extends StatefulWidget {
  const LiveMap({Key? key}) : super(key: key);

  @override
  State<LiveMap> createState() => _LiveMapState();
}

class _LiveMapState extends State<LiveMap> {
  late bool isOnlinePanelOpened;

  @override
  void initState() {
    isOnlinePanelOpened = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return ClipRRect(
      borderRadius: const BorderRadius.only(
          topRight: Radius.circular(16),
          topLeft: Radius.circular(16)),
      child: Stack(
        children: [
          const Map(),
          (isOnlinePanelOpened)
            ? Positioned(
                top: SizeConfig.blockSizeVertical! * 2,
                left: SizeConfig.blockSizeHorizontal! * 2,
                right: SizeConfig.blockSizeHorizontal! * 2,
                child: ImOnline(
                  onClose: () => print('shesh')
                ))
            : SizedBox.shrink()
        ],
      ));
  }
}
