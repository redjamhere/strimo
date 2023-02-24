//описание экрана выбора типа контекта (новая трансляция или запрос)
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:joyvee/src/bloc/stream_chat_bloc/stream_chat_bloc.dart';
import 'package:joyvee/src/cubit/cubit.dart';
import 'package:joyvee/src/repository/respository.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:joyvee/src/views/ios_streamer_view/ios_camera_view.dart';
import 'package:joyvee/src/views/streamer_view/camera_view.dart';

//utils
import '../../utils/utils.dart';

//widgets
import '../../widgets/widgets.dart';

//bloc
import '../../bloc/bloc.dart';

import './pick_location_view.dart';

part 'setup_stream_step_2.dart';
part 'setup_stream_step_1.dart';

class StreamTypeView extends StatelessWidget {
  const StreamTypeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: JoyveeElevatedButton(
          style: Theme.of(context).elevatedButtonTheme.style!.copyWith(
              elevation: MaterialStateProperty.all<double>(10),
              shadowColor:
                  MaterialStateProperty.all<Color>(JoyveeColors.jvOrange),
              minimumSize: MaterialStateProperty.all<Size>(const Size(60, 60)),
              padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                  const EdgeInsets.all(20)),
              shape: MaterialStateProperty.all<CircleBorder>(
                  const CircleBorder())),
          func: () => Navigator.pop(context),
          child: const Icon(Icons.arrow_back)),
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: SizeConfig.blockSizeHorizontal! * 4),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            JoyveeChooseStreamButton(
                onTap: () => Navigator.push(
                    context,
                    CupertinoPageRoute(
                        builder: (ctx) => BlocProvider<PickLocationCubit>(
                          create: (context) => PickLocationCubit(
                              userRepository: context.read<UserRepository>()..getCurrentPosition()),
                          child: BlocProvider(
                              create: (context) => StreamSetupBloc(
                                streamType: StreamType.standard,
                                streamRepository:
                                    context.read<StreamRepository>(),
                                userRepository:
                                    context.read<UserRepository>(),
                                pickLocationCubit: context.read<PickLocationCubit>()
                              ),
                              child: SetupStreamStepOne(
                                key: Key("stream_first_step_setup_screen"),
                              ),
                            ),
))),
                title: "Live stream",
                subtitle: "Start your stream right now",
                iconAsset: "assets/svg/live_stream_icon.svg"),
            SizedBox(
              height: SizeConfig.blockSizeHorizontal! * 5,
            ),
            JoyveeChooseStreamButton(
                onTap: () => print('shesh'),
                title: "Schedule",
                subtitle: "Schedule your broadcast at the time you want",
                iconAsset: "assets/svg/schedule_stream_icon.svg")
          ],
        ),
      ),
    );
  }
}
