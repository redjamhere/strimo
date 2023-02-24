// описание кнопок
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../utils/utils.dart';

abstract class _JoyveeButton extends StatelessWidget {
  final Function? func;
  final GestureTapCallback? onTap;
  final Widget child;
  final ButtonStyle? style;

  const _JoyveeButton({
    required this.child,
    this.style,
    this.func,
    this.onTap,
  });

  @override
  Widget build (BuildContext context) {
    return ElevatedButton(
        onPressed: (func != null) ? () => func!.call() : null,
        child: child);
  }
}

class JoyveeLikeButton extends _JoyveeButton{
  const JoyveeLikeButton({
    required Icon icon,
    required GestureTapCallback onTap
  }) : super(child: icon, onTap: onTap);

  @override
  Widget build(BuildContext context) {
    return Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(9),
        child: InkWell(
          borderRadius: BorderRadius.circular(9),
          onTap: onTap,
          // overlayColor: MaterialStateProperty.all<Color>(JoyveeColors.jvOrange.withOpacity(.2)),
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(9),
                border: Border.all(color: Colors.white.withOpacity(.5), width: 1)
            ),
            padding: const EdgeInsets.all(14),
            child: child,
          ),
        ));
  }
}

class JoyveeAppbarActionButton extends _JoyveeButton {
  const JoyveeAppbarActionButton({
    required Icon icon,
    required GestureTapCallback onTap,
    this.withShadow = true
  }) : super(child: icon, onTap: onTap);
  final bool withShadow;
  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: (withShadow) ? 5 : 0,
      color: (withShadow) ? Colors.white : Colors.transparent,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(14),
          child: child,
        )));
  }
}

class JoyveeElevatedButton extends _JoyveeButton {
  const JoyveeElevatedButton({
    required Widget child,
    Function? func,
    required ButtonStyle style,
  }): super(child: child, func: func, style: style);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return ElevatedButton(
        style: style!.copyWith(
          padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
              EdgeInsets.symmetric(horizontal: 16, vertical: SizeConfig.blockSizeVertical! * 2,)
          )
        ),
        onPressed: (func != null) ? () => func!.call() : null,
        child: child);
  }
}

class JoyveeOutlinedButton extends _JoyveeButton {
  final Gradient? gradient;
  final double strokeWidth;

  const JoyveeOutlinedButton({
    required Widget child,
    Function? func,
    GestureTapCallback? onTap,
    ButtonStyle? style,
    this.gradient,
    this.strokeWidth = 2.0,
  }) : super(child: child, func: func, onTap: onTap, style: style);

  @override
  Widget build(BuildContext context) {
    if (gradient != null) {
      return _JoyveeGradientOutlineButton(
          strokeWidth: strokeWidth,
          gradient: gradient!,
          onTap: onTap,
          inkWell: true,
          child: child);
    }
    return OutlinedButton(
      onPressed: (func != null) ? () => func!.call() : null,
      style: style,
      child: child,
    );
  }
}

class JoyveeTextButton extends _JoyveeButton {

  const JoyveeTextButton({
    required Widget child,
    Function? func,
    ButtonStyle? style
  }) : super(child: child, func: func, style: style);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: style,
      onPressed: (func != null) ? () => func!.call() : null,
      child: child,
    );
  }
}

class JoyveeSocialButton extends _JoyveeButton {
  const JoyveeSocialButton({
    required GestureTapCallback onTap,
    required Widget child
  }) : super(child: child, onTap: onTap);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: JoyveeColors.jvGreyBackground,
      shape: const CircleBorder(),
      elevation: 0,
      child: InkWell(
        borderRadius: BorderRadius.circular(360),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(11),
          child: SizedBox(height: 20, width: 20, child: child),
        ),
      ),
    );
  }
}

class JoyveeRadioButton<T> extends StatelessWidget {
  final T value;
  final T groupValue;
  final String leading;
  final ValueChanged<T> onChanged;

  const JoyveeRadioButton({
    Key? key,
    required this.value,
    required this.groupValue,
    required this.leading,
    required this.onChanged
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: (value == groupValue) ? 7 : 0,
      borderRadius: BorderRadius.circular(10),
      child: InkWell(
        onTap: () => onChanged(value),
        borderRadius: BorderRadius.circular(10),
        child: Container(
          height: 40,
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: 28),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: value == groupValue ? JoyveeColors.jvDarkBlue : Colors.transparent,
          ),
          child: Text(leading,
              style: (value == groupValue)
                  ? Theme.of(context).textTheme.titleLarge!.copyWith(
                  fontSize: 17,
                  color: Colors.white)
                  : Theme.of(context).textTheme.bodyLarge!.copyWith(
                  fontSize: 17,
                  color: Colors.black)
          ),
        ),
      ),
    );
  }
}

class JoyveeAvatarPicker extends _JoyveeButton {
  final FileImage? avatar;
  final String? networkAvatar;
  const JoyveeAvatarPicker({
    this.avatar,
    this.networkAvatar,
    required Widget child,
    required GestureTapCallback onTap
  }) : super(child: child, onTap: onTap);
  
  @override
  Widget build (BuildContext context) => Material(
    elevation: 1,
    shape: const CircleBorder(),
    color: JoyveeColors.jvGreyBackground_2,
    child: LayoutBuilder(
      builder: (context, constraints) {
        return Stack(
          children: [
            InkWell(
              onTap: onTap,
              borderRadius: BorderRadius.circular(360),
              child: CircleAvatar(
                radius: constraints.maxWidth * 0.18,
                // ignore: unnecessary_cast
                foregroundImage: 
                  (avatar != null) ? avatar
                  : (networkAvatar != null) 
                  ? NetworkImage(networkAvatar!) 
                  : Image.asset("assets/png/empty_avatar.png", fit: BoxFit.contain,).image,
                backgroundColor: Colors.transparent,
                child: SizedBox.shrink(),
              ),
            ),
            Positioned(
              right: 5,
              bottom: 5,
              child: Container(
                  decoration: BoxDecoration(
                    color: JoyveeColors.jvGreen,
                    border: Border.all(
                      width: 3,
                      color: Colors.white
                    ),
                    borderRadius: BorderRadius.circular(360)
                  ),
                  child: const Icon(Icons.add, color: Colors.white,size: 25,)),
            )
          ],
        );
      }
    ),
  );
}

class JoyveeChooseStreamButton extends StatelessWidget {
  final GestureTapCallback onTap;
  final String title;
  final String? subtitle;
  final String iconAsset;

  const JoyveeChooseStreamButton({
    required this.onTap,
    required this.title,
    this.subtitle,
    required this.iconAsset
  });

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return  Material(
      elevation: 10,
      color: Theme.of(context).colorScheme.background,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          height: SizeConfig.blockSizeVertical! * 13,
          width: SizeConfig.screenWidth,
          padding: EdgeInsets.all(SizeConfig.blockSizeVertical! * 2),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16)
          ),
          child: Row(
            children: [
              SvgPicture.asset(iconAsset,
                height: SizeConfig.blockSizeVertical! * 6,
              ),
              SizedBox(width: SizeConfig.blockSizeVertical! * 2),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AutoSizeText(title,
                      style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                          fontSize: SizeConfig.blockSizeVertical! * 3
                      ),
                      minFontSize: 14,
                      maxFontSize: 20,
                      maxLines: 1,
                    ),
                    AutoSizeText(subtitle?? "shesh",
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          fontSize: SizeConfig.blockSizeVertical! * 2
                      ),
                      maxLines: 2,
                      minFontSize: 12,
                      overflow: TextOverflow.ellipsis,
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class JoyveePreviewPicker extends StatelessWidget {
  const JoyveePreviewPicker({Key? key, this.preview, required this.onTap})
      : super(key: key);
  final FileImage? preview;
  final GestureTapCallback onTap;

  Widget _buildPlaceHolder(context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.camera_alt,
          size: SizeConfig.blockSizeVertical! * 4,
        ),
        Text("Add",
          style: Theme.of(context).textTheme.bodyLarge,
        )
      ],
    );
  }

  Widget _buildPreview() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: AspectRatio(
        aspectRatio: 16 / 9,
        child: Image.file(preview!.file, fit: BoxFit.cover,)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: JoyveeColors.jvGreyBackground,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: SizedBox(
          width: SizeConfig.blockSizeHorizontal! * 45,
          height: SizeConfig.blockSizeVertical! * 13,
          child: (preview != null)
            ? _buildPreview()
            : _buildPlaceHolder(context)
        ),
      ),
    );
  }
}


class _JoyveeGradientOutlineButton extends StatelessWidget{
  final Widget child;
  final double strokeWidth;
  final Radius? radius;
  final Corners? corners;
  final Gradient gradient;
  final EdgeInsets padding;
  final Color backgroundColor;
  final double elevation;
  final bool inkWell;
  final GestureTapCallback? onTap;
  final GestureTapCallback? onDoubleTap;
  final GestureLongPressCallback? onLongPress;
  final GestureTapDownCallback? onTapDown;
  final GestureTapCancelCallback? onTapCancel;
  final ValueChanged<bool>? onHighlightChanged;
  final ValueChanged<bool>? onHover;
  final ValueChanged<bool>? onFocusChange;

  _JoyveeGradientOutlineButton({
    Key? key,
    required this.child,
    required this.strokeWidth,
    required this.gradient,
    this.corners,
    this.radius = const Radius.circular(15),
    this.padding = const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
    this.backgroundColor = Colors.transparent,
    this.elevation = 0,
    this.inkWell = false,
    this.onTap,
    this.onDoubleTap,
    this.onLongPress,
    this.onTapDown,
    this.onTapCancel,
    this.onHighlightChanged,
    this.onHover,
    this.onFocusChange,
  })  : assert(strokeWidth > 0),
        assert(padding.isNonNegative),
        assert(elevation >= 0),
        assert(radius == null || corners == null, 'Cannot provide both a radius and corners.'),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final BorderRadius br = corners != null ? _fromCorners(corners!, strokeWidth) : _fromRadius(radius ?? Radius.zero, strokeWidth);
    return Material(
      color: backgroundColor,
      elevation: elevation,
      borderRadius: br,
      child: InkWell(
        overlayColor: MaterialStateProperty.all<Color>(JoyveeColors.jvOrange.withOpacity(.2)),
        borderRadius: br,
        highlightColor: inkWell ? Theme.of(context).highlightColor : Colors.transparent,
        splashColor: inkWell ? Theme.of(context).splashColor : Colors.transparent,
        onTap: onTap,
        onLongPress: onLongPress,
        onDoubleTap: onDoubleTap,
        onTapDown: onTapDown,
        onTapCancel: onTapCancel,
        onHighlightChanged: onHighlightChanged,
        onHover: onHover,
        onFocusChange: onFocusChange,
        child: CustomPaint(
          painter: _Painter(gradient, radius, strokeWidth, corners),
          child: Padding(padding: padding, child: child),
        ),
      ),
    );
  }

  static BorderRadius _fromCorners(Corners corners, double strokeWidth) {
    return BorderRadius.only(
      topLeft: Radius.elliptical(corners.topLeft.x + strokeWidth, corners.topLeft.y + strokeWidth),
      topRight: Radius.elliptical(corners.topRight.x + strokeWidth, corners.topRight.y + strokeWidth),
      bottomLeft: Radius.elliptical(corners.bottomLeft.x + strokeWidth, corners.bottomLeft.y + strokeWidth),
      bottomRight: Radius.elliptical(corners.bottomRight.x + strokeWidth, corners.bottomRight.y + strokeWidth),
    );
  }

  static BorderRadius _fromRadius(Radius radius, double strokeWidth) {
    return BorderRadius.all(Radius.elliptical(radius.x + strokeWidth, radius.y + strokeWidth));
  }

}

class _Painter extends CustomPainter {
  final Gradient gradient;
  final Radius? radius;
  final double strokeWidth;
  final Corners? corners;

  _Painter(this.gradient, this.radius, this.strokeWidth, this.corners);

  @override
  void paint(Canvas canvas, Size size) {
    final Rect rect = Rect.fromLTWH(strokeWidth / 2, strokeWidth / 2, size.width - strokeWidth, size.height - strokeWidth);
    final RRect rRect = corners != null
        ? RRect.fromRectAndCorners(
      rect,
      topLeft: corners!.topLeft,
      topRight: corners!.topRight,
      bottomLeft: corners!.bottomLeft,
      bottomRight: corners!.bottomRight,
    )
        : RRect.fromRectAndRadius(rect, radius ?? Radius.zero);
    final Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..shader = gradient.createShader(rect);
    canvas.drawRRect(rRect, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => oldDelegate != this;
}

class Corners {
  final Radius topLeft;
  final Radius topRight;
  final Radius bottomLeft;
  final Radius bottomRight;

  const Corners({
    this.topLeft = Radius.zero,
    this.topRight = Radius.zero,
    this.bottomLeft = Radius.zero,
    this.bottomRight = Radius.zero,
  });
}