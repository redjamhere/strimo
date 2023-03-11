import 'package:flutter/material.dart';
import 'package:joyvee/src/utils/utils.dart';

class AppThemes {
  static ThemeData baseTheme(BuildContext context) {
    return ThemeData(
      fontFamily: "SFProText",
      useMaterial3: false,
      appBarTheme: const AppBarTheme(
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: JoyveeColors.jvOrange,
        ),
        // actionsIconTheme: IconThemeData(
        //   color: JoyveeColors.jvOrange
        // )
      ),
      backgroundColor: Colors.white,
      colorScheme: const ColorScheme(
        background: Colors.white,
        onBackground: Colors.white,
        brightness: Brightness.light,
        error: JoyveeColors.jvRed,
        onError: JoyveeColors.jvRed,
        onPrimary: JoyveeColors.jvOrange,
        primary: JoyveeColors.jvOrange,
        onSecondary: JoyveeColors.jvGreySecondary,
        secondary: JoyveeColors.jvOrange,
        surface: Colors.white,
        onSurface: Colors.white
      ),
      scaffoldBackgroundColor: Colors.white,
      textTheme: TextTheme(
        headlineLarge: TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 24 * MediaQuery.textScaleFactorOf(context),
          color: Colors.black,
        ),
        headlineMedium: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 22 * MediaQuery.textScaleFactorOf(context),
          color: Colors.black
        ),
        headlineSmall: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 12 * MediaQuery.textScaleFactorOf(context),
          color: JoyveeColors.jvGreyHeadLine
        ),
        bodySmall: TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 17 * MediaQuery.textScaleFactorOf(context),
          color: JoyveeColors.jvGreySecondary
        ),
        titleLarge: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 15 * MediaQuery.textScaleFactorOf(context)
        ),
        bodyLarge: TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 14 * MediaQuery.textScaleFactorOf(context),
          color: JoyveeColors.jvGreySecondary
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          textStyle: MaterialStateProperty.all<TextStyle>(
              const TextStyle(
                // fontSize: 17 * MediaQuery.textScaleFactorOf(context),
                // fontWeight: FontWeight.w600,
                color: Colors.white
          )),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15)
            )
          ),
          overlayColor: MaterialStateProperty.all<Color>(Colors.white.withOpacity(.2)),
          foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
          elevation: MaterialStateProperty.all<double>(1),
          shadowColor: MaterialStateProperty.all<Color>(JoyveeColors.jvOrange),
          backgroundColor: MaterialStateProperty.resolveWith<Color>(
                  (Set<MaterialState> states) {
                    if (states.contains(MaterialState.disabled)) {
                      return JoyveeColors.jvGreyDisabledButton;
                    }
                    return JoyveeColors.jvOrange;
                  }),
          // visualDensity: const VisualDensity(horizontal: VisualDensity.maximumDensity, vertical: VisualDensity.maximumDensity)
        )
      ),
      textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
          overlayColor: MaterialStateProperty.all<Color>(JoyveeColors.jvOrange.withOpacity(.2)),
          textStyle: MaterialStateProperty.all<TextStyle>(Theme.of(context).textTheme.titleLarge!.copyWith(color: JoyveeColors.jvLightBlueLink)),
        )
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
            primary: JoyveeColors.jvOrange,
            side: const BorderSide(width: 2, color: JoyveeColors.jvGreyIcon),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          )
        )

      ),
      iconTheme: const IconThemeData(size: 20, color: Colors.black),
      splashColor: JoyveeColors.jvOrange,
      inputDecorationTheme: InputDecorationTheme(
        hintStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
          color: Colors.black.withOpacity(.54),
          fontSize: 17
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: const BorderSide(
            width: 0,
            style: BorderStyle.none,
          ),
        ),
        fillColor: JoyveeColors.jvGreyTextField,
      ),
      checkboxTheme: CheckboxThemeData(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
        ),
        side: const BorderSide(
            color: JoyveeColors.jvGreyBorder,
            width: 2,
            style: BorderStyle.solid
        ),
        overlayColor: MaterialStateProperty.all<Color>(JoyveeColors.jvOrange.withOpacity(.2)),
        checkColor: MaterialStateProperty.all<Color>(Colors.white),
        fillColor:  MaterialStateProperty.all<Color>(Colors.transparent)
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        foregroundColor: Colors.white,
        backgroundColor: JoyveeColors.jvOrange,
        elevation: 0,
        sizeConstraints: BoxConstraints(minHeight: 60, minWidth: 60)
      ),
      switchTheme: SwitchThemeData(
        thumbColor: MaterialStateProperty.all<Color>(JoyveeColors.jvOrange),
        trackColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
              if (states.contains(MaterialState.selected)) {
                return JoyveeColors.jvOrange.withOpacity(.5);
              }
              return JoyveeColors.jvGreyDisabledButton.withOpacity(.5);
            }),
      ),
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: Colors.white,
      )
    );
  }

  static ThemeData darkTheme(BuildContext context) => ThemeData(
    brightness: Brightness.dark,
    fontFamily: "SFProText",
    // colorScheme: ColorScheme(
    //   primary: JoyveeColors.jvOrange,
    //   onSecondary: JoyveeColors.jvGreySecondary,
    //
    // ),
    textTheme: const TextTheme(
      headlineLarge: TextStyle(
        fontWeight: FontWeight.w700,
        fontSize: 24,
        color: Colors.white,
      ),
      headlineMedium: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 22,
          color: Colors.white
      ),
      headlineSmall: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 12,
          color: Colors.white
      ),
      bodySmall: TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 17,
          color: JoyveeColors.jvGreySecondary
      ),
      titleLarge: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 15
      ),
      bodyLarge: TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 14
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
            textStyle: MaterialStateProperty.all<TextStyle>(
                const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                    color: Colors.white
                )),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)
                )
            ),
            foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
            elevation: MaterialStateProperty.all<double>(5),
            shadowColor: MaterialStateProperty.all<Color>(JoyveeColors.jvOrange),
            backgroundColor: MaterialStateProperty.resolveWith<Color>(
                    (Set<MaterialState> states) {
                  if (states.contains(MaterialState.disabled)) {
                    return JoyveeColors.jvGreyDisabledButton;
                  }
                  return JoyveeColors.jvOrange;
                }),
            padding: MaterialStateProperty.all<EdgeInsetsGeometry>(const EdgeInsets.symmetric(horizontal: 16, vertical: 16))
          // visualDensity: const VisualDensity(horizontal: VisualDensity.maximumDensity, vertical: VisualDensity.maximumDensity)
        )
    ),
    textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
          textStyle: MaterialStateProperty.all<TextStyle>(Theme.of(context).textTheme.titleLarge!.copyWith(color: JoyveeColors.jvLightBlueLink)),
        )
    ),
  );
}