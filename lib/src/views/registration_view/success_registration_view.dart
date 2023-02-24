// описание экрана успешной регистрации

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:joyvee/src/repository/authorization_repository.dart';
import 'package:joyvee/src/widgets/widgets.dart';
import 'package:joyvee/src/utils/utils.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

//bloc
import '../../bloc/bloc.dart';

class SuccessRegistrationView extends StatelessWidget {
  const SuccessRegistrationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      body: SizedBox(
        height: SizeConfig.screenHeight,
        width: SizeConfig.screenWidth,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset("assets/svg/rocket.svg"),
            SizedBox(height: SizeConfig.blockSizeVertical! * 3),
            Text("Account created!", style: Theme.of(context).textTheme.headlineMedium),
            SizedBox(height: SizeConfig.blockSizeVertical! * 1),
            Text("it's time to start",
              style: Theme.of(context).textTheme.bodyLarge!
                  .copyWith(fontSize: 17)),
            SizedBox(height: SizeConfig.blockSizeVertical! * 3),
            JoyveeElevatedButton(
                style: Theme.of(context).elevatedButtonTheme.style!.copyWith(
                    minimumSize: MaterialStateProperty.all<Size>(const Size(200, 0))),
                func: () => context.read<AuthorizationBloc>().add(
                  const AuthorizationStatusChanged(AuthorizationStatus.authenticated)),
                child: const Text('Proceed')),
          ],
        ),
      ),
    );
  }
}
