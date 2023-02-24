// описание всех цветов в приложении

import 'package:flutter/material.dart';

class JoyveeColors {
  static const Color jvOrange = Color.fromRGBO(227, 121, 91, 1);
  static const Color jvDarkBlue = Color.fromRGBO(47, 40, 78, 1);
  static const Color jvDarkBlueLighter = Color.fromRGBO(95, 88, 129, 1);
  static const Color jvLightBlueLink = Color.fromRGBO(0, 122, 255, 1);
  static const Color jvGreyEmptyImage = Color.fromRGBO(216, 216, 216, 1);
  static const Color jvGreyDisabledButton = Color.fromRGBO(189, 189, 189, 1);
  static const Color jvGreyHintText = Color.fromRGBO(60, 60, 67, 0.3);
  static const Color jvGreySecondary = Color.fromRGBO(60, 60, 67, 0.6);
  static const Color jvGreyIcon = Color.fromRGBO(47, 40, 78, 1);
  static const Color jvGreyBackground = Color.fromRGBO(241, 241, 241, 1);
  static const Color jvGreyBackground_2 = Color.fromRGBO(209, 209, 209, 1);
  static const Color jvRed = Color.fromRGBO(243, 45, 57, 1);
  static const Color jvGreen = Color.fromRGBO(39, 174, 96, 1);
  static const Color jvLightBlueMarker = Color.fromRGBO(43, 152, 252, 1);
  static const Color jvGold = Color.fromRGBO(249, 189, 35, 1);
  static const Color jvGreenSwitcher = Color.fromRGBO(52, 199, 89, 1);
  static const Color jvGreyHeadLine = Color.fromRGBO(0, 0, 0, 0.54);
  static const Color jvGreyTextField = Color.fromRGBO(245, 245, 245, 1);
  static const Color jvGreyBorder = Color.fromRGBO(147, 147, 147, 1);
  static const Color darkPurple = Color.fromRGBO(76, 68, 108, 1);
  static const Color jvShadow = Color.fromRGBO(61, 64, 92, 0.2);
  static const Color jvLightGreyBackground = Color.fromRGBO(229, 229, 229, 1);
}

class JoyveeGradients {
  static const Gradient kDarkBlueGradient = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [JoyveeColors.jvDarkBlue, JoyveeColors.jvDarkBlueLighter]);
  
  static const Gradient kLightGreyGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color.fromRGBO(216, 216, 216, 1), Color.fromRGBO(209, 209, 209, 1)]
  );

  static const LinearGradient kShimmerGradient = LinearGradient(
    colors: [
      Color(0xFFEBEBF4),
      Color(0xFFF4F4F4),
      Color(0xFFEBEBF4),
    ],
    stops: [
      0.1,
      0.3,
      0.4,
    ],
    begin: Alignment(-1.0, -0.3),
    end: Alignment(1.0, 0.3),
    tileMode: TileMode.clamp,
  );
}

class JoyveePaddings {
  static const double kModalBottomSheetPadding = 20.0;
  static const double kScreenDefaultPadding = 16.0;
}