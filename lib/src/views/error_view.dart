import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:joyvee/src/utils/size_config.dart';
import 'package:joyvee/src/widgets/buttons.dart';

class ErrorView extends StatelessWidget {
  const ErrorView({Key? key, required this.errorText}) : super(key: key);
  final String errorText;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Text(errorText,
                style: Theme.of(context).textTheme.headlineMedium)
          ),
          SizedBox(height: SizeConfig.blockSizeVertical),
          JoyveeElevatedButton(
              style: Theme.of(context)
                  .elevatedButtonTheme
                  .style!
                  .copyWith(
                  minimumSize: MaterialStateProperty.all<Size>(
                      const Size(200, 0))),
              func: () => Phoenix.rebirth(context),
              child: const Text('Try again'))
        ],
      ),
    );
  }
}
