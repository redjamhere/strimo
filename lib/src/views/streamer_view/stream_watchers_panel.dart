// описания плашки с счетчиком просмотров
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:joyvee/src/views/views.dart';
import 'package:strimocamera/strimocamera.dart';

//bloc
import '../../bloc/bloc.dart';

//utils
import '../../utils/utils.dart';

//widget
import '../../widgets/widgets.dart';

class StreamWatchersPanel extends StatelessWidget {
  const StreamWatchersPanel({super.key});

  Widget _buildStreamWatchersPanel() {
    return BlocBuilder<StreamChatBloc, StreamChatState>(
      builder: (context, state) {
        return Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 6),
          decoration: BoxDecoration(
              color: JoyveeColors.jvRed,
              borderRadius: BorderRadius.circular(7)),
          child: Text("Live 👀 1000000",
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  fontSize: 12 * MediaQuery.of(context).textScaleFactor,
                  color: Theme.of(context).colorScheme.background)));
      });
  }

  Widget _buildCloseButton() {
    return Builder(
      builder: (context) => Material(
        borderRadius: BorderRadius.circular(360),
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(360),
          onTap: () => JoyveeDialogs.showAlertDialog(
            context: context,
            title: "Stream closing",
            content: "Once confirmed, your stream will end. Are you sure?",
            onSubmit: () {
              if (Platform.isIOS) {
                context.read<IosCameraBloc>().add(IosCameraStreamStoppedEvent());
              }
              if (Platform.isAndroid) {
                context.read<CameraBloc>().add(CameraStreamStopped());
              }
            },
            onCancel: () =>
                Navigator.pop(context)),
          child: Padding(
            padding: const EdgeInsets.all(6),
            child: Icon(
              Icons.clear,
              color: Theme.of(context).colorScheme.background,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Row(
      children: [
        _buildStreamWatchersPanel(),
        const Spacer(),
        _buildCloseButton()
      ],
    );
  }
}
