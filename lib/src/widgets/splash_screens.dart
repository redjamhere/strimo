// описание экранов загрузок
import 'package:flutter/material.dart';

class FullScreenSplash extends StatelessWidget {
  final String? splashText;

  const FullScreenSplash({Key? key, this.splashText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Text(
              splashText?? 'Loading'
          ),
        ),
      ),
    );
  }
}
