import 'dart:io';

import 'package:flutter/material.dart';
import 'package:joyvee/src/views/streamer_view/stream_watchers_panel.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:joyvee/src/views/views.dart';
import 'package:strimocamera/strimocamera.dart';
import 'package:we_slide/we_slide.dart';

//utils
import '../../utils/utils.dart';

//bloc
import '../../bloc/bloc.dart';

import '../../widgets/stream_chat_view.dart';

part 'stream_controls_panel.dart';

class CameraView extends StatelessWidget {
  CameraView({Key? key}) : super(key: key);

  final _controller = WeSlideController();
  Widget _buildStreamInfoPanel() {
    return BlocBuilder<CameraBloc, CameraState>(
        buildWhen: (previous, current) =>
            previous.streamStatus != current.streamStatus,
        builder: (context, state) {
          switch (state.streamStatus) {
            case StreamStatus.rtmp_connected:
              return Container(
                  alignment: Alignment.center,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 7, vertical: 6),
                  decoration: BoxDecoration(
                      color: JoyveeColors.jvGreen,
                      borderRadius: BorderRadius.circular(7)),
                  child: Text("Connected",
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          fontSize: 12 * MediaQuery.of(context).textScaleFactor,
                          color: Theme.of(context).colorScheme.background)));
            case StreamStatus.rtmp_connecting:
              return Container(
                  alignment: Alignment.center,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 7, vertical: 6),
                  decoration: BoxDecoration(
                      color: JoyveeColors.jvGold,
                      borderRadius: BorderRadius.circular(7)),
                  child: Text("Connecting...",
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          fontSize: 12 * MediaQuery.of(context).textScaleFactor,
                          color: Theme.of(context).colorScheme.background)));
            case StreamStatus.rtmp_connection_failed:
              return Container(
                  alignment: Alignment.center,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 7, vertical: 6),
                  decoration: BoxDecoration(
                      color: JoyveeColors.jvRed,
                      borderRadius: BorderRadius.circular(7)),
                  child: Text("Connection failed",
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          fontSize: 12 * MediaQuery.of(context).textScaleFactor,
                          color: Theme.of(context).colorScheme.background)));
            case StreamStatus.rtmp_disconnected:
              return Container(
                  alignment: Alignment.center,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 7, vertical: 6),
                  decoration: BoxDecoration(
                      color: JoyveeColors.jvGreyDisabledButton,
                      borderRadius: BorderRadius.circular(7)),
                  child: Text("Disconnected",
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          fontSize: 12 * MediaQuery.of(context).textScaleFactor,
                          color: Theme.of(context).colorScheme.background)));
            case StreamStatus.initial:
              return Container(
                  alignment: Alignment.center,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 7, vertical: 6),
                  decoration: BoxDecoration(
                      color: JoyveeColors.jvGreen,
                      borderRadius: BorderRadius.circular(7)),
                  child: Text("Waiting...",
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          fontSize: 12 * MediaQuery.of(context).textScaleFactor,
                          color: Theme.of(context).colorScheme.background)));
            case StreamStatus.error:
              return Container(
                  alignment: Alignment.center,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 7, vertical: 6),
                  decoration: BoxDecoration(
                      color: JoyveeColors.jvRed,
                      borderRadius: BorderRadius.circular(7)),
                  child: Text("Error",
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          fontSize: 12 * MediaQuery.of(context).textScaleFactor,
                          color: Theme.of(context).colorScheme.background)));
          }
        });
  }

  Widget _buildAndroidBody(BuildContext context) {
    return BlocListener<CameraBloc, CameraState>(
      listener: (context, state) async {
        // не работает
        if (state.isStreamStopped) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const Wrapper()),
            (route) => false);
        }
      },
      child: SafeArea(
        child: WeSlide(
          controller: _controller,
          panelMaxSize: SizeConfig.blockSizeVertical! * 50,
          panelMinSize: SizeConfig.blockSizeVertical! * 5,
          panel: StreamChatView(
            onTap: () => _controller.hide(),
          ),
          body: Stack(
            children: [
              Center(
                child: Transform.scale(
                  scale: 1.2,
                  child: JoyveeCameraPreview(
                      controller: context.read<CameraBloc>().controller),
                ),
              ),
              Positioned(
                top: SizeConfig.blockSizeVertical!,
                left: SizeConfig.blockSizeVertical!,
                right: SizeConfig.blockSizeVertical!,
                child: const StreamWatchersPanel(),
              ),
              Positioned(
                bottom: SizeConfig.blockSizeVertical!,
                left: SizeConfig.blockSizeVertical!,
                right: SizeConfig.blockSizeVertical!,
                child: _buildStreamInfoPanel(),
              ),
              Positioned(
                top: 0,
                right: SizeConfig.blockSizeVertical,
                bottom: 0,
                child: StreamControlsPanel(
                    openChat: () => _controller.show(),
                    switchCamera: () =>
                        context.read<CameraBloc>().add(CameraSwitchPressed()),
                    turnOnOffFlashlight: () => context
                        .read<CameraBloc>()
                        .add(CameraFlashLightPressed())),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildIosBody() {
    return SafeArea(
        child: Center(
      child: Text("IOS camera"),
    ));
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    if (Platform.isAndroid) {
      Future.delayed(const Duration(seconds: 5),
          () => context.read<CameraBloc>().add(CameraStreamStarted()));
    }
    return Scaffold(
        backgroundColor: Colors.black,
        body: _buildAndroidBody(context));
  }
}
