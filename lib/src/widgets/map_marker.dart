// Описание кастомного маркера
import 'dart:math' as math;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:joyvee/src/utils/utils.dart';
import '../models/models.dart';

class JMarker extends StatelessWidget {
  final StreamMarker streamMarker;
  const JMarker({Key? key, required this.streamMarker}) : super(key: key);


  CustomPainter _setBackground() {
    if (streamMarker.cost == 0 && streamMarker.isLive!) {
      return LiveFreeBackground();
    }
    if (streamMarker.cost! > 0 && !streamMarker.isLive!) {
      return ScheduledBackground();
    }
    if (streamMarker.cost == 0 && !streamMarker.isLive!) {
      return ScheduledFreeBackground();
    }
    return LiveBackground();
  }

  Widget _setIcons(double iconSize) {
    Color bgc = JoyveeColors.jvRed;

    List<Icon> icons = [Icon(JoyveeIcons.profile_filled, color: Colors.white, size: iconSize,), Icon(JoyveeIcons.live_filled, color: Colors.white, size: iconSize,)];

    if (streamMarker.isPrivate && streamMarker.isLive!) {
      bgc = JoyveeColors.jvRed;
      icons = [
        Icon(JoyveeIcons.profile_filled, color: Colors.white, size: iconSize),
        Icon(JoyveeIcons.live_filled, color: Colors.white, size: iconSize,)];
    }
    if (streamMarker.isPrivate && !streamMarker.isLive!) {
      bgc = JoyveeColors.jvLightBlueMarker;
      icons = [
        Icon(JoyveeIcons.profile_filled, color: Colors.white, size: iconSize),
        Icon(JoyveeIcons.schedule_filled, color: Colors.white, size: iconSize)];
    }
    if (!streamMarker.isPrivate && streamMarker.isLive!) {
      bgc = JoyveeColors.jvRed;
      icons = [
        Icon(JoyveeIcons.group_filled, color: Colors.white, size: iconSize),
        Icon(JoyveeIcons.live_filled, color: Colors.white, size: iconSize)];
    }
    if (!streamMarker.isPrivate && !streamMarker.isLive!) {
      bgc = JoyveeColors.jvLightBlueMarker;
      icons = [
        Icon(JoyveeIcons.group_filled, color: Colors.white, size: iconSize),
        Icon(JoyveeIcons.schedule_filled, color: Colors.white, size: iconSize)];
    }

    return Container(
      decoration: BoxDecoration(
          color: bgc,
          borderRadius: BorderRadius.circular(4.0)
      ),
      alignment: Alignment.center,
      padding: (streamMarker.isLive!) ? const EdgeInsets.all(2) : const EdgeInsets.only(top: 2, bottom: 2, left: 2, right: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: icons,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final Size markerSize = Size(SizeConfig.blockSizeVertical! * 8, SizeConfig.blockSizeVertical! * 8);
    return Container(
      height: markerSize.height,
      width: markerSize.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(360),
      ),
      child: Stack(
        children: [
          Positioned(
            bottom: 4,
            right: 4,
            top: 4,
            left: 4,
            child: CustomPaint(
              painter: _setBackground(),
              size: Size(markerSize.height, markerSize.width),
            ),
          ),
          Positioned(
            bottom: 7,
            right: 7,
            top: 7,
            left: 7,
            child: CircleAvatar(
              foregroundImage: CachedNetworkImageProvider(streamMarker.preview!, scale: 0.5),
              backgroundImage: const AssetImage("assets/jpg/appicon-bw.jpg"),
            ),
          ),
          Positioned(
            top: 0,
            left: 20,
            right:  20,
            child: Container(
              decoration: BoxDecoration(
                color: (streamMarker.cost! > 0) ? JoyveeColors.jvGold: JoyveeColors.jvGreen,
                borderRadius: BorderRadius.circular(12.0)
              ),
              alignment: Alignment.center,
              padding: EdgeInsets.all(SizeConfig.blockSizeVertical! * 0.1),
              child: ((streamMarker.cost! > 0)) ?
                Text("\$\$\$",
                  style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                    fontSize: 16.0,
                    color: Colors.white
                  ))
                : Text("Free",
                  style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                      fontSize: 16.0,
                      color: Colors.white
                  ))
            ),
          ),
          const SizedBox(
            width: 40,
          ),
          Positioned(
            bottom: 0,
            left: 20,
            right: 20,
            child: _setIcons(20))
        ],
      ),
    );
  }
}

class LiveBackground extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = JoyveeColors.jvGold;
    canvas.drawArc(
      Rect.fromCenter(
        center: Offset(size.height / 2, size.width / 2),
        height: size.height,
        width: size.width,
      ),
      math.pi,
      math.pi,
      false,
      paint,
    );
   paint = Paint()..color = JoyveeColors.jvRed;
    canvas.drawArc(
      Rect.fromCenter(
        center: Offset(size.height / 2, size.width / 2),
        height: size.height,
        width: size.width,
      ),
      -math.pi,
      -math.pi,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class LiveFreeBackground extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = JoyveeColors.jvGreen;
    canvas.drawArc(
      Rect.fromCenter(
        center: Offset(size.height / 2, size.width / 2),
        height: size.height,
        width: size.width,
      ),
      math.pi,
      math.pi,
      false,
      paint,
    );
    paint = Paint()..color = JoyveeColors.jvRed;
    canvas.drawArc(
      Rect.fromCenter(
        center: Offset(size.height / 2, size.width / 2),
        height: size.height,
        width: size.width,
      ),
      -math.pi,
      -math.pi,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class ScheduledBackground extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = JoyveeColors.jvGold;
    canvas.drawArc(
      Rect.fromCenter(
        center: Offset(size.height / 2, size.width / 2),
        height: size.height,
        width: size.width,
      ),
      math.pi,
      math.pi,
      false,
      paint,
    );
    paint = Paint()..color = JoyveeColors.jvLightBlueMarker;
    canvas.drawArc(
      Rect.fromCenter(
        center: Offset(size.height / 2, size.width / 2),
        height: size.height,
        width: size.width,
      ),
      -math.pi,
      -math.pi,
      false,
      paint,
    );
  }
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class ScheduledFreeBackground extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = JoyveeColors.jvGreen;
    canvas.drawArc(
      Rect.fromCenter(
        center: Offset(size.height / 2, size.width / 2),
        height: size.height,
        width: size.width,
      ),
      math.pi,
      math.pi,
      false,
      paint,
    );
    paint = Paint()..color = JoyveeColors.jvLightBlueMarker;
    canvas.drawArc(
      Rect.fromCenter(
        center: Offset(size.height / 2, size.width / 2),
        height: size.height,
        width: size.width,
      ),
      -math.pi,
      -math.pi,
      false,
      paint,
    );
  }
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

