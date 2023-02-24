//libs
import 'package:flutter/material.dart';
import 'package:another_flushbar/flushbar.dart';
//utils
import './utils.dart';

class JoyveeFlushbars {

  static Flushbar showErrorFlushbar(BuildContext context, {
    required String title,
    required String message,
  }) => Flushbar(
    title: title,
    duration: const Duration(seconds: 3),
    message: message,
    icon: const Icon(Icons.close, color: Colors.white,),
    margin: const EdgeInsets.all(18),
    borderRadius: const BorderRadius.all(Radius.circular(20)),
    animationDuration: const Duration(seconds: 1),
    dismissDirection: FlushbarDismissDirection.HORIZONTAL,
    boxShadows: const [BoxShadow(color: Colors.black26, offset: Offset(0.0, 2.0), blurRadius: 3.0)],
    backgroundColor: JoyveeColors.jvRed,
  )..show(context);

  static Flushbar showSuccessFlushbar(BuildContext context, {
    required String title,
    required String message
  }) => Flushbar(
    title: title,
    boxShadows: const [BoxShadow(color: Colors.black26, offset: Offset(0.0, 2.0), blurRadius: 3.0)],
    duration: const Duration(seconds: 3),
    message: message,
    icon: const Icon(Icons.done, color: Colors.white,),
    margin: const EdgeInsets.all(18),
    dismissDirection: FlushbarDismissDirection.HORIZONTAL,
    borderRadius: const BorderRadius.all(Radius.circular(20)),
    backgroundColor: JoyveeColors.jvGreen,
  )..show(context);

  static Flushbar showInfoFlushbar(BuildContext context, {
    required String title,
    required String message
  }) => Flushbar(
    title: title,
    boxShadows: const [BoxShadow(color: Colors.black26, offset: Offset(0.0, 2.0), blurRadius: 3.0)],
    duration: const Duration(seconds: 3),
    message: message,
    dismissDirection: FlushbarDismissDirection.HORIZONTAL,
    icon: const Icon(Icons.info, color: Colors.white,),
    margin: const EdgeInsets.all(18),
    borderRadius: const BorderRadius.all(Radius.circular(20)),
    backgroundColor: JoyveeColors.jvGreyHeadLine,
  )..show(context);
}