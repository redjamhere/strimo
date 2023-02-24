// описание диалоговых окон

import 'package:flutter/material.dart';

class JoyveeDialogs {
  static Future<void> showAlertDialog({
    required BuildContext context, 
    required String title, 
    required String content, 
    required VoidCallback onSubmit,
    required VoidCallback onCancel
  }) async {
    return showDialog(
    context: context,
    barrierDismissible: false, 
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        content: Container(
          child: Text(content),
        ),
        actions: [
          TextButton(
            onPressed: onSubmit, 
            child: const Text("Ok")),
          TextButton(
            onPressed: onCancel, 
            child: const Text("Cancel")),
        ],
      );
    });
  }
}