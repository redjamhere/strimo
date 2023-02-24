// описание текстов
import 'package:flutter/material.dart';

class JoyveeTexts {
  static GradientText gradientText(String text,
      {required Gradient gradient, TextStyle? style, TextAlign? textAlign}) =>
      GradientText(text, gradient: gradient, style: style, textAlign: textAlign);
}

class GradientText extends StatelessWidget {
  const GradientText(
      this.text, {
        Key? key,
        required this.gradient,
        this.style,
        this.textAlign
      });

  final String text;
  final TextStyle? style;
  final Gradient gradient;
  final TextAlign? textAlign;
  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: (bounds) => gradient.createShader(
        Rect.fromLTWH(0, 0, bounds.width, bounds.height),
      ),
      child: Text(text, style: style, textAlign: textAlign,),
    );
  }
}