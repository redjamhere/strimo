import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:joyvee/src/utils/utils.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class FullScreenProgressIndicator extends StatelessWidget {
  const FullScreenProgressIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return BackdropFilter(
      filter: ImageFilter.blur(
          sigmaY: 5,
          sigmaX: 5
      ),
      child: Center(
        child: LoadingAnimationWidget.stretchedDots(
          color: Theme.of(context).colorScheme.primary.withOpacity(.8),
          size: SizeConfig.blockSizeVertical! * 10,
        ),
      ),
    );
  }
}

class JoyveeProgressIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LoadingAnimationWidget.stretchedDots(
      color: Theme.of(context).colorScheme.primary.withOpacity(.8),
      size: SizeConfig.blockSizeVertical! * 10,
    );
  }
}
