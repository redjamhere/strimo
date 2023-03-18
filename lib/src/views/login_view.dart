// описание экрана авторизации
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:joyvee/src/repository/respository.dart';
import 'package:joyvee/src/utils/utils.dart';
import 'package:joyvee/src/views/home_view/home_view.dart';
import 'package:joyvee/src/views/views.dart';
import 'package:joyvee/src/widgets/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
//bloc
import '../bloc/bloc.dart';

class LoginView extends StatefulWidget {
  LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  void _handleLoginWithSocial(SocialAuthType s) {

  }

  Widget _buildMailField() {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) => previous.mail != current.mail,
      builder: (context, state) {
        return JoyveeAuthTextField(
            style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(fontSize: 17, fontWeight: FontWeight.w400),
            onChanged: (mail) =>
                context.read<LoginBloc>().add(LoginMailChanged(mail)),
            textInputType: TextInputType.emailAddress,
            hintText: 'Email');
      },
    );
  }

  Widget _buildPasswordField() {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) => previous.mail != current.mail,
      builder: (context, state) {
        return Visibility(
          visible: state.mail.valid,
          child: JoyveeAuthTextField(
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(fontSize: 17, fontWeight: FontWeight.w400),
              onChanged: (password) =>
                  context.read<LoginBloc>().add(LoginPasswordChanged(password)),
              hintText: '***',
              obscureText: true),
        );
      },
    );
  }

  Widget _buildSubmitButton() {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return SizedBox(
          width: SizeConfig.blockSizeHorizontal! * 30,
          child: JoyveeElevatedButton(
              style: Theme.of(context).elevatedButtonTheme.style!.copyWith(
                  minimumSize:
                      MaterialStateProperty.all<Size>(const Size(200, 0))),
              func: state.status.isValidated
                  ? () => context.read<LoginBloc>().add(const LoginSubmitted())
                  : null,
              child: const Text('LogIn')),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return BlocProvider(
      create: (context) => LoginBloc(
        userRepository: context.read<UserRepository>(),
        authorizationRepository: context.read<AuthorizationRepository>(),
        messengerRepository: context.read<MessengerRepository>()
      ),
      child: BlocConsumer<LoginBloc, LoginState>(
        listenWhen: (previous, current) => previous.status != current.status,
        listener: (context, state) {
          if (state.status.isSubmissionFailure) {
            JoyveeFlushbars.showErrorFlushbar(context,
                title: "Error", message: state.errorMessage!);
          }
          if (state.status.isSubmissionSuccess) {
            context.read<AuthorizationBloc>().add(const AuthorizationStatusChanged(AuthorizationStatus.authenticated));
          }
        },
        builder: (context, state) {
          List<Widget> _buildSocialButton() {
            var btns = [
              JoyveeSocialButton(
                  child: JoyveeIcons.google,
                  onTap: () => context.read<LoginBloc>().add(
                    const LoginWithSocialSubmitted(SocialAuthType.google))),
              JoyveeSocialButton(
                  child: JoyveeIcons.facebook,
                  onTap: () => context.read<LoginBloc>().add(
                    const LoginWithSocialSubmitted(SocialAuthType.facebook))),
            ];
            if (Platform.isIOS) {
              btns.add(JoyveeSocialButton(
                  child: JoyveeIcons.apple,
                  onTap: () => context.read<LoginBloc>().add(
                    const LoginWithSocialSubmitted(SocialAuthType.apple))));
            }
            return btns;
          }
          return Scaffold(
              resizeToAvoidBottomInset: false,
              appBar: AppBar(),
              body: Stack(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.only(
                      left: JoyveePaddings.kScreenDefaultPadding,
                      right: JoyveePaddings.kScreenDefaultPadding,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Welcome back!",
                            style: Theme.of(context)
                                .textTheme
                                .headlineLarge!
                                .copyWith(fontSize: 34),
                          ),
                        ),
                        const SizedBox(height: 30),
                        _buildMailField(),
                        _buildPasswordField(),
                        const SizedBox(height: 20),
                        Text(
                          "Enter your email or sign in with social",
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        const SizedBox(height: 30),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: _buildSocialButton()
                        ),
                        const SizedBox(height: 30),
                        _buildSubmitButton(),
                        const Spacer(),
                        JoyveeTextButton(
                            style: Theme.of(context).textButtonTheme.style!,
                            func: null,
                            child: Text("Need help?",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(fontSize: 15))),
                      ],
                    ),
                  ),
                  Visibility(
                      visible: state.status.isSubmissionInProgress,
                      child: const FullScreenProgressIndicator())
                ],
              ));
        },
      ),
    );
  }
}
