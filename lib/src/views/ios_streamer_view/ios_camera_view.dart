import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:haishin_kit/net_stream_drawable_texture.dart';
import 'package:joyvee/src/app.dart';
import 'package:joyvee/src/bloc/bloc.dart';
import 'package:joyvee/src/utils/progress_indicator.dart';
import 'package:joyvee/src/utils/size_config.dart';
import 'package:joyvee/src/views/streamer_view/camera_view.dart';
import 'package:joyvee/src/views/streamer_view/stream_watchers_panel.dart';
import 'package:joyvee/src/widgets/stream_chat_view.dart';
import 'package:we_slide/we_slide.dart';

import '../views.dart';

class IosCameraView extends StatelessWidget {
  final _controller = WeSlideController();

  Widget _buildIosBody() {
    return BlocConsumer<IosCameraBloc, IosCameraState>(
      listener: (context, state) {
        if (state is IosCameraStateStopped) {
          Navigator.pushAndRemoveUntil(
            context,
            CupertinoPageRoute(builder: (context) => const JoyveeAppView()),
                (route) => false);
        }
      },
      builder: (context, state) {
        if (state is IosCameraStateReady) {
          return SafeArea(
            child: WeSlide(
              controller: _controller,
              panelMaxSize: SizeConfig.blockSizeVertical! * 50,
              panelMinSize: SizeConfig.blockSizeVertical! * 5,
              panel: StreamChatView(
                onTap: () => _controller.hide(),
              ),
              body: Stack(
                children: [
                  Center(child: NetStreamDrawableTexture(state.stream)),
                  Positioned(
                    top: SizeConfig.blockSizeVertical!,
                    left: SizeConfig.blockSizeVertical!,
                    right: SizeConfig.blockSizeVertical!,
                    child: const StreamWatchersPanel(),
                  ),
                  // Positioned(
                  //   top: 0,
                  //   right: SizeConfig.blockSizeVertical,
                  //   bottom: 0,
                  //   bottom: 0,
                  //   child: StreamControlsPanel(
                  //     openChat: () => _controller.show(),
                  //     switchCamera: () => print("SWITCH CAMERA"),
                  //     turnOnOffFlashlight: () => print("FLASHLIGHT"),
                  //   ),
                  // )
                ],
              ),
            ),
          );
        } else if (state is IosCameraStateInit) {
          return const FullScreenProgressIndicator();
        } else if (state is IosCameraStateFailure){
          return Center(
            child: Text(state.errorMessage),
          );
        }
        return const Center(
          child: Text("unknow error", style: TextStyle(color: Colors.black),),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: _buildIosBody(),
    );
  }
}