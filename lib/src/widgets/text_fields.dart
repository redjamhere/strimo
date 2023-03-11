import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:hashtagable/hashtagable.dart';
import 'package:http/http.dart';
//utils
import '../utils/utils.dart';

abstract class _JoyveeTextField extends StatelessWidget {
  final TextEditingController? controller;
  final TextStyle style;
  final ValueChanged<String>? onChanged;
  final bool autofocus;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final TextInputAction textInputAction;
  final TextInputType textInputType;
  final TextCapitalization textCapitalization;
  final Color cursorColor;
  final double borderRadius;
  final String? hintText;
  final int maxLines;
  final bool showSuffix;
  final bool obscureText;
  final bool readOnly;
  final GestureTapCallback? onTap;
  final String? errorText;
  final Widget? suffixWidget;
  final void Function(String)? onSubmit;
  final int? maxLength;
  final bool showMaxLength;
  final FocusNode? focudNode;

  const _JoyveeTextField({
    this.controller,
    required this.style,
    this.onChanged,
    this.autofocus = false,
    this.suffixIcon,
    this.prefixIcon,
    this.textInputAction = TextInputAction.done,
    this.textInputType = TextInputType.text,
    this.textCapitalization = TextCapitalization.sentences,
    this.cursorColor = JoyveeColors.jvOrange,
    this.borderRadius = 4,
    this.maxLines = 1,
    this.hintText,
    this.showSuffix = false,
    this.obscureText = false,
    this.readOnly = false,
    this.onTap,
    this.errorText,
    this.suffixWidget,
    this.onSubmit,
    this.maxLength,
    this.showMaxLength = false,
    this.focudNode
  });

  @override
  Widget build(BuildContext context) {
    return const TextField();
  }
}

class JoyveeDefaultTextField extends _JoyveeTextField {
  final List<TextInputFormatter>? inputFormatters;

  const JoyveeDefaultTextField({
      required TextStyle style,
      TextEditingController? controller,
      ValueChanged<String>? onChanged,
      Widget? suffixIcon,
      Widget? suffixWidget,
      int maxLines = 1,
      bool autofocus = false,
      double borderRadius = 4,
      String? hintText,
      bool showSuffix = false,
      TextInputAction textInputAction = TextInputAction.done,
      TextInputType textInputType = TextInputType.text,
      bool readOnly = false,
      GestureTapCallback? onTap,
      String? errorText,
      this.inputFormatters,
      int? maxLength,
      bool showMaxLength = false,
      Widget? prefixIcon,
      FocusNode? focusNode
  }) : super(
      style: style,
      controller: controller,
      onChanged: onChanged,
      suffixIcon: suffixIcon,
      maxLines: maxLines,
      autofocus: autofocus,
      hintText: hintText,
      borderRadius: borderRadius,
      showSuffix: showSuffix,
      readOnly: readOnly,
      textInputType: textInputType,
      onTap: onTap,
      errorText: errorText,
      suffixWidget: suffixWidget,
      maxLength: maxLength,
      showMaxLength: showMaxLength,
      prefixIcon: prefixIcon,
      textInputAction: textInputAction,
      focudNode: focusNode
  );

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return TextField(
      style: style,
      onChanged: onChanged,
      controller: controller,
      focusNode: focudNode,
      maxLines: maxLines,
      inputFormatters: inputFormatters,
      keyboardType: textInputType,
      textCapitalization: textCapitalization,
      textInputAction: textInputAction,
      cursorColor: cursorColor,
      readOnly: readOnly,
      maxLength: maxLength,
      onTap: onTap,
      decoration: InputDecoration(
        errorText: errorText,
        contentPadding: const EdgeInsets.only(
            top: 12,
            bottom: 12,
            left: 18),
        hintText: hintText,
        counterStyle: const TextStyle(fontSize: 14),
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        suffixIcon: showSuffix ? suffixIcon : null,
        prefixIcon: prefixIcon,
        suffix: suffixWidget
      ),
    );
  }
}

class JoyveeDescriptionTextField extends _JoyveeTextField {
    const JoyveeDescriptionTextField({
      required TextStyle style,
      TextEditingController? controller,
      ValueChanged<String>? onChanged,
      Widget? suffixIcon,
      int maxLines = 1,
      bool autofocus = false,
      double borderRadius = 4,
      String? hintText,
      bool showSuffix = false,
      TextInputAction textInputAction = TextInputAction.done,
      TextInputType textInputType = TextInputType.text,
      String? errorText
  }) : super(
      style: style,
      controller: controller,
      onChanged: onChanged,
      suffixIcon: suffixIcon,
      maxLines: maxLines,
      autofocus: autofocus,
      hintText: hintText,
      borderRadius: borderRadius,
      showSuffix: showSuffix,
      errorText: errorText
  );

  @override
  Widget build(BuildContext context) {
    return HashTagTextField(
      basicStyle: style,
      decoratedStyle: style.copyWith(
        color: JoyveeColors.jvGold
      ),
      onChanged: onChanged,
      controller: controller,
      maxLines: maxLines,
      keyboardType: textInputType,
      textCapitalization: textCapitalization,
      textInputAction: textInputAction,
      cursorColor: cursorColor,
      decoration: InputDecoration(
        errorText: errorText,
        contentPadding: const EdgeInsets.only(
            top: 12,
            bottom: 12,
            left: 18),
        hintText: hintText,
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        suffixIcon: showSuffix ? suffixIcon : null,
      ),
    );
  }
}

class JoyveeStreamTextField extends _JoyveeTextField {
  const JoyveeStreamTextField({
    required TextStyle style,
    TextEditingController? controller,
    required Widget suffixIcon,
    String? hintText,
    Function(String)? onSubmit
  }) : super(style: style, controller: controller, suffixIcon: suffixIcon, hintText: hintText, onSubmit: onSubmit);

  @override
  Widget build (BuildContext context) {
    return TextField(
      style: style,
      controller: controller,
      onSubmitted: onSubmit,
      textInputAction: TextInputAction.send,
      cursorColor: cursorColor,
      decoration: InputDecoration(
        filled: false,
        contentPadding: const EdgeInsets.only(left: 14),
        hintText: hintText,
        hintStyle: style,
        suffixIcon: suffixIcon,
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(9),
            borderSide: BorderSide(
                width: 1,
                color: Colors.white.withOpacity(.5),
                style: BorderStyle.solid
            )
        ),
        enabledBorder:  OutlineInputBorder(
          borderRadius: BorderRadius.circular(9),
          borderSide: BorderSide(
              width: 1,
              color: Colors.white.withOpacity(.5),
              style: BorderStyle.solid
          ),
        ),
      ),
    );
  }
}

class JoyveeAuthTextField extends _JoyveeTextField {
  const JoyveeAuthTextField({
    required TextStyle style,
    TextEditingController? controller,
    String? hintText,
    ValueChanged<String>? onChanged,
    bool autofocus = false,
    TextInputType textInputType = TextInputType.text,
    bool obscureText = false,

  }) : super(
    style: style,
    controller: controller,
    hintText: hintText,
    onChanged: onChanged,
    autofocus: autofocus,
    textInputType: textInputType,
    obscureText: obscureText
  );

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return TextField(
    style: style,
    controller: controller,
    cursorColor: cursorColor,
    obscureText: obscureText,
    keyboardType: textInputType,
    onChanged: onChanged,
    decoration: InputDecoration(
      isDense: true,
      filled: false,
      hintStyle: style.copyWith(color: JoyveeColors.jvGreyHintText),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(
            width: .5,
            color: JoyveeColors.jvOrange.withOpacity(.2),
            style: BorderStyle.solid
        ),
      ),
      enabledBorder:  UnderlineInputBorder(
        borderSide: BorderSide(
            width: 1,
            color: Colors.black.withOpacity(.2),
            style: BorderStyle.solid
        ),
      ),
      contentPadding: EdgeInsets.only(
          top: SizeConfig.blockSizeVertical! * 2,
          bottom: SizeConfig.blockSizeVertical! * 2,
          left: 0, right: 0),
      hintText: hintText,
    ),
  );
  }
}

class JoyveeSearchTextField extends _JoyveeTextField {
  const JoyveeSearchTextField({
    required TextStyle style,
    TextEditingController? controller,
    String? hintText,
    ValueChanged<String>? onChanged,
    bool autofocus = false,
    bool showSuffix = false,
    TextInputAction textInputAction = TextInputAction.search,
    Widget? suffixIcon,
    Widget? prefixIcon,
    bool readOnly = false,
    GestureTapCallback? onTap,
  }) : super(
    style: style,
    controller: controller,
    hintText: hintText,
    onChanged: onChanged,
    autofocus: autofocus,
    showSuffix: showSuffix,
    textInputAction: textInputAction,
    suffixIcon: suffixIcon,
    prefixIcon: prefixIcon,
    readOnly: readOnly,
    onTap: onTap
  );

  Widget build (BuildContext context) {
    SizeConfig().init(context);
    return Material(
    elevation: 7,
    borderRadius: BorderRadius.circular(12),
    child: TextField(
      controller: controller,
      onChanged: onChanged,
      cursorColor: cursorColor,
      readOnly: readOnly,
      style: style,
      onTap: onTap,
      textInputAction: textInputAction,
      decoration: InputDecoration(
        fillColor: Colors.white,
        isDense: true,
        focusColor: JoyveeColors.jvGreyHintText,
        hintText: hintText,
        hintStyle: style.copyWith(color: JoyveeColors.jvGreyHintText, fontSize: 14),
        // contentPadding: EdgeInsets.symmetric(vertical: SizeConfig.blockSizeVertical! * 1),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(
                width: 0,
                color: Colors.transparent
            )
        ),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(
                width: 0,
                color: Colors.transparent
            )
        ),
        suffixIcon: showSuffix ? suffixIcon : null,
        prefixIcon: prefixIcon
      )
    )
  );
  }
}


class JoyveeOtpTextField extends StatelessWidget {
  const JoyveeOtpTextField({Key? key, required this.onSubmit}) : super(key: key);
  final void Function(String) onSubmit;

  @override
  Widget build(BuildContext context) {
    return  OtpTextField(
      onSubmit: onSubmit,
      numberOfFields: 4,
      borderColor: Color(0xFF512DA8),
      fieldWidth: 60.0,
      styles: [
        Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 36),
        Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 36),
        Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 36),
        Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 36),
      ],
      //set to true to show as box or false to show as dash
      showFieldAsBox: true,
      focusedBorderColor: JoyveeColors.jvOrange,
      //runs when a code is typed in
      //runs when every textfield is filled
    );
  }
}


