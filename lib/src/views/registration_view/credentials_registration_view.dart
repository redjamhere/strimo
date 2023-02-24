// описание экрана регистрации почты
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:joyvee/src/views/code_verify_view.dart';
import 'package:joyvee/src/views/registration_view/registration.dart';
import 'package:joyvee/src/widgets/widgets.dart';
import 'package:joyvee/src/utils/utils.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

//blocs
import '../../bloc/bloc.dart';

class CredentialsRegistration extends StatelessWidget {
  const CredentialsRegistration({Key? key}) : super(key: key);

  Widget _buildMailField() {
    return BlocBuilder<RegistrationBloc, RegistrationState>(
      buildWhen: (previous, current) => previous.mail != current.mail,
      builder: (context, staste) =>   JoyveeAuthTextField(
        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
            fontSize: 17, fontWeight: FontWeight.w400),
        onChanged: (mail) => context.read<RegistrationBloc>().add(RegMailChanged(mail)),
        textInputType: TextInputType.emailAddress,
        hintText: 'Email')
    );
  }

  Widget _buildPasswordField() {
    return BlocBuilder<RegistrationBloc, RegistrationState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) =>    JoyveeAuthTextField(
        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
            fontSize: 17, fontWeight: FontWeight.w400),
        hintText: 'Password',
        onChanged: (password) => context.read<RegistrationBloc>().add(RegPasswordChanged(password)),
        obscureText: true)
    );
  }

  Widget _buildRepatPasswordField() {
    return BlocBuilder<RegistrationBloc, RegistrationState>(
      buildWhen: (previous, current) => previous.repeatPassword != current.repeatPassword,
      builder: (context, state) => JoyveeAuthTextField(
        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
            fontSize: 17, fontWeight: FontWeight.w400),
        hintText: 'Repeat password',
        onChanged: (password) => context.read<RegistrationBloc>().add(RegRepeatPasswordChanged(password)),
        obscureText: true)
    );
  }

  Widget _buildSubmitButton() {
    return BlocBuilder<RegistrationBloc, RegistrationState>(
      buildWhen: (previous, current) => previous.credentialStatus != current.credentialStatus,
      builder: (context, state) => JoyveeElevatedButton(
        style: Theme.of(context)
            .elevatedButtonTheme
            .style!
            .copyWith(
                minimumSize: MaterialStateProperty.all<Size>(
                    const Size(200, 0))),
        func: state.credentialStatus.isValidated 
          ? () => context.read<RegistrationBloc>().add(const RegCredentialSubmitted())
          : null,
        child: const Text('Next')),
    );
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    List<Widget> _buildSocialButton() {
      var btns = [
        JoyveeSocialButton(
            child: JoyveeIcons.google,
            onTap: () => context.read<RegistrationBloc>().add(
              const RegWithSocialSubmitted(SocialAuthType.google))),
        JoyveeSocialButton(
            child: JoyveeIcons.facebook,
            onTap: () => context.read<RegistrationBloc>().add(
              const RegWithSocialSubmitted(SocialAuthType.facebook))),
      ];
      if (Platform.isIOS) {
        btns.add(JoyveeSocialButton(
            child: JoyveeIcons.apple,
            onTap: () => context.read<RegistrationBloc>().add(
              const RegWithSocialSubmitted(SocialAuthType.apple))));
      }
      return btns;
    }
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(),
      body: BlocConsumer<RegistrationBloc, RegistrationState>(
        listenWhen: (previous, current) => 
          previous.credentialStatus != current.credentialStatus
          || previous.socialAuthStatus != current.socialAuthStatus,
        listener: (context, state) {
          if (state.credentialStatus.isSubmissionSuccess) {
            Navigator.push(context, MaterialPageRoute(
              builder: (ctx) => BlocProvider.value(
                value: context.read<RegistrationBloc>(), 
                child: const CodeVerifyView(),)));
          }
          if (state.credentialStatus.isSubmissionFailure || state.socialAuthStatus.isSubmissionFailure) {
            JoyveeFlushbars.showErrorFlushbar(context, title: "Ошибка", message: state.errorMessage!);
          }
          if (state.socialAuthStatus.isSubmissionSuccess) {
            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (ctx) => const SuccessRegistrationView()), (route) => false);
          }
        },
        builder: (context, state) {
          return Stack(
            children: [
              Container(
                height: SizeConfig.screenHeight,
                width: SizeConfig.screenWidth,
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
                        "New account!",
                        style: Theme.of(context)
                            .textTheme
                            .headlineLarge!
                            .copyWith(fontSize: 34),
                      ),
                    ),
                    SizedBox(height: SizeConfig.blockSizeVertical! * 3),
                    _buildMailField(),
                    _buildPasswordField(),
                    _buildRepatPasswordField(),
                    SizedBox(height: SizeConfig.blockSizeVertical! * 3),
                    _buildSubmitButton(),
                    SizedBox(height: SizeConfig.blockSizeVertical! * 3),
                    Text(
                      "or sign up with",
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    SizedBox(height: SizeConfig.blockSizeVertical! * 3),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: _buildSocialButton(),
                    ),
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
                  visible: state.credentialStatus.isSubmissionInProgress || state.socialAuthStatus.isSubmissionInProgress,
                  child: const FullScreenProgressIndicator())
            ],
          );
        },
      ),
    );
  }
}
