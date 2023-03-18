// описание экрана приветствия при авторизации
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:joyvee/src/utils/constants.dart';
import 'package:joyvee/src/utils/size_config.dart';
import 'package:joyvee/src/views/views.dart';
import 'package:joyvee/src/widgets/widgets.dart';

class WelcomeView extends StatelessWidget {
  const WelcomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(MediaQuery.of(context).size.height * 0.45),
          child: AppBar(
            flexibleSpace: const Image(
              image: AssetImage('assets/png/welcome_appbar.png'),
              fit: BoxFit.cover,
            ),
          ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Welcome!',
              style: Theme.of(context).textTheme.headlineLarge!
                  .copyWith(fontSize: 28.0),),
            SvgPicture.asset("assets/svg/logo.svg"),
            SizedBox(
              width: SizeConfig.blockSizeHorizontal! * 30,
              child: JoyveeElevatedButton(
                  style: Theme.of(context).elevatedButtonTheme.style!.copyWith(
                      minimumSize: MaterialStateProperty.all<Size>(const Size.fromHeight(0)),
                    ),
                  func: () => Navigator.push(context, MaterialPageRoute(builder: (context) => LoginView())),
                  child: const Text('SignIn')),
            ),
            JoyveeTextButton(
                style: Theme.of(context).textButtonTheme.style!.copyWith(
                    textStyle: MaterialStateProperty.all<TextStyle>(const TextStyle(fontSize: 15))),
                func: () => Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileRegistrationView())),
                child: Column(
                  children: [
                    Text(
                      'Not registered yet?',
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(fontSize: 15),
                    ),
                    const Text(
                      'Create account',
                      style: TextStyle(color: JoyveeColors.jvLightBlueLink)
                    )
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
