// описание экрана ввода OTP кода
import 'package:flutter/material.dart';
import 'package:joyvee/src/utils/utils.dart';
import 'package:joyvee/src/widgets/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

//blocs
import '../bloc/bloc.dart';

import './registration_view/success_registration_view.dart';

class CodeVerifyView extends StatelessWidget {
  const CodeVerifyView({Key? key}) : super(key: key);

  Widget _buildOtpField() {
    return BlocBuilder<RegistrationBloc, RegistrationState>(
      buildWhen: (previous, current) => previous.otpCode != current.otpCode,
      builder: (context, state) => JoyveeOtpTextField(
        onSubmit: (code) => context.read<RegistrationBloc>().add(RegOtpCodeChanged(code)),
      )
    );
  }

  Widget _buildSubmitButton() {
    return BlocBuilder<RegistrationBloc, RegistrationState>(
      buildWhen: (previous, current) => previous.codeStatus != current.codeStatus,
      builder: (context, state) =>  JoyveeElevatedButton(
        style: Theme.of(context)
            .elevatedButtonTheme
            .style!
            .copyWith(
                minimumSize: MaterialStateProperty.all<Size>(
                    const Size(200, 0))),
        func: () => (state.codeStatus.isValidated)
          ? context.read<RegistrationBloc>().add(const RegOtpCodeSubmitted())
          : null,
        child: const Text('Next'))
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegistrationBloc, RegistrationState>(
      listener: (context, state) {
        if (state.codeStatus.isSubmissionSuccess) {
          Navigator.push(context, MaterialPageRoute(builder: (ctx) => const SuccessRegistrationView()));
        }

        if (state.codeStatus.isSubmissionFailure) {
          JoyveeFlushbars.showErrorFlushbar(context, title: "Ошибка", message: state.errorMessage!);
        }
      },
      builder: (context, state) {
        return Scaffold(
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
                        "Enter the code",
                        style: Theme.of(context)
                            .textTheme
                            .headlineLarge!
                            .copyWith(fontSize: 34),
                      ),
                    ),
                    SizedBox(height: SizeConfig.blockSizeVertical! * 3),
                    _buildOtpField(),
                    SizedBox(height: SizeConfig.blockSizeVertical! * 3),
                    Text(
                      "Code can be send after 60 sec.",
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    SizedBox(height: SizeConfig.blockSizeVertical! * 3),
                    _buildSubmitButton(),
                    const Spacer(),
                    JoyveeTextButton(
                        style: Theme.of(context).textButtonTheme.style!,
                        func: () => print('text button'),
                        child: Text("Need help?",
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .copyWith(fontSize: 15))),
                  ],
                ),
              ),
              Visibility(
                  visible: state.codeStatus.isSubmissionInProgress,
                  child: const FullScreenProgressIndicator())
            ],
          ),
        );
      },
    );
  }
}
