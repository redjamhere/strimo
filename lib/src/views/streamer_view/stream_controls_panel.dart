// Описание виджета с кнопка для управления трансляцией

part of 'camera_view.dart';

class StreamControlsPanel extends StatelessWidget {
  const StreamControlsPanel(
      {super.key,
      required this.openChat,
      required this.switchCamera,
      required this.turnOnOffFlashlight});

  final VoidCallback openChat;
  final VoidCallback switchCamera;
  final VoidCallback turnOnOffFlashlight;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    Color iconColor = Theme.of(context).colorScheme.background;
    double iconSize = SizeConfig.blockSizeVertical! * 4;
    return BlocBuilder<CameraBloc, CameraState>(
      builder: (context, state) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Material(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(360),
              child: InkWell(
                borderRadius: BorderRadius.circular(360),
                onTap: turnOnOffFlashlight,
                child: Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Icon(
                    (state.isFlashLightEnabled) ? Icons.flash_off : Icons.flash_on,
                    color: iconColor,
                    size: iconSize,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: SizeConfig.blockSizeVertical! * 5,
            ),
            Material(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(360),
              child: InkWell(
                borderRadius: BorderRadius.circular(360),
                onTap: switchCamera,
                child: Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Icon(
                    Icons.repeat,
                    color: iconColor,
                    size: iconSize,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: SizeConfig.blockSizeVertical! * 5,
            ),
            Material(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(360),
              child: InkWell(
                borderRadius: BorderRadius.circular(360),
                onTap: openChat,
                child: Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Icon(
                    Icons.message,
                    color: iconColor,
                    size: iconSize,
                  ),
                ),
              ),
            )
          ],
        );
      },
    );
  }
}
