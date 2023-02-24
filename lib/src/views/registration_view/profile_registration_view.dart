// описание экрана заполнения данных профиля
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:joyvee/src/repository/respository.dart';
import 'package:joyvee/src/utils/utils.dart';
import 'package:joyvee/src/widgets/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:formz/formz.dart';

//bloc
import '../../bloc/bloc.dart';

import './credentials_registration_view.dart';

class ProfileRegistrationView extends StatelessWidget {
  ProfileRegistrationView({Key? key}) : super(key: key);

  final ImagePicker _picker = ImagePicker();

  FileImage? avatar;

  Widget _buildFirstnameField() {
    return BlocBuilder<RegistrationBloc, RegistrationState>(
      buildWhen: (previous, current) => previous.firstname != current.firstname,
      builder: (context, state) => JoyveeAuthTextField(
          style: Theme.of(context)
              .textTheme
              .bodyLarge!
              .copyWith(fontSize: 17, fontWeight: FontWeight.w400),
          onChanged: (firstname) => context
              .read<RegistrationBloc>()
              .add(RegFirstnameChanged(firstname)),
          hintText: 'Firstname'),
    );
  }

  Widget _buildLastnameField() {
    return BlocBuilder<RegistrationBloc, RegistrationState>(
      buildWhen: (previous, current) => previous.lastname != current.lastname,
      builder: (context, state) => JoyveeAuthTextField(
          style: Theme.of(context)
              .textTheme
              .bodyLarge!
              .copyWith(fontSize: 17, fontWeight: FontWeight.w400),
          onChanged: (lastname) => context
              .read<RegistrationBloc>()
              .add(RegLastnameChanged(lastname)),
          hintText: 'Lastname'),
    );
  }

  Widget _buildSexPicker() {
    return BlocBuilder<RegistrationBloc, RegistrationState>(
        buildWhen: (previous, current) => previous.sex != current.sex,
        builder: (context, state) => Row(
              children: [
                Expanded(
                    child: JoyveeRadioButton<Sex>(
                        value: Sex.female,
                        groupValue: state.sex,
                        leading: '👩 Female',
                        onChanged: (sex) => context
                            .read<RegistrationBloc>()
                            .add(RegSexChanged(sex)))),
                Expanded(
                    child: JoyveeRadioButton<Sex>(
                        value: Sex.male,
                        groupValue: state.sex,
                        leading: '🧑 Male',
                        onChanged: (sex) => context
                            .read<RegistrationBloc>()
                            .add(RegSexChanged(sex))))
              ],
            ));
  }

  Widget _buildSubmitButton() {
    return BlocBuilder<RegistrationBloc, RegistrationState>(
        buildWhen: (previous, current) =>
            previous.profileStatus != current.profileStatus,
        builder: (context, state) => JoyveeElevatedButton(
              style: Theme.of(context).elevatedButtonTheme.style!.copyWith(
                  minimumSize:
                      MaterialStateProperty.all<Size>(const Size(200, 0))),
              func: state.profileStatus.isValidated
                  ? () => context
                      .read<RegistrationBloc>()
                      .add(const RegProfileSubmitted())
                  : null,
              child: const Text('Create'),
            ));
  }

  Widget _buildAvatarPicker() {
    return BlocBuilder<RegistrationBloc, RegistrationState>(
      builder: (context, state) => JoyveeAvatarPicker(
        avatar: (state.profile.sourceAvatar != null) ? FileImage(state.profile.sourceAvatar!) : null,
        onTap: () async {
          XFile? avatar = await _picker.pickImage(source: ImageSource.gallery);
          if (avatar != null) {
            // ignore: use_build_context_synchronously
            context.read<RegistrationBloc>().add(RegAvatarPicked(File(avatar.path)));
          }
        },
        child: SvgPicture.asset("assets/svg/empty_avatar.svg"),
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return BlocProvider(
      create: (context) => RegistrationBloc(
          profileRepository: context.read<ProfileRepository>(),
          authorizationRepository: context.read<AuthorizationRepository>(),
          userRepository: context.read<UserRepository>()),
      child: BlocListener<RegistrationBloc, RegistrationState>(
        listenWhen: (previous, current) => previous.profileStatus != current.profileStatus,
        listener: (context, state) {
          if (state.profileStatus.isSubmissionSuccess) {
            Navigator.push(context, MaterialPageRoute(
              builder: (ctx) => BlocProvider.value(
                value: context.read<RegistrationBloc>(), 
                child: const CredentialsRegistration(),)));
          } 
          if (state.profileStatus.isSubmissionFailure) {
            JoyveeFlushbars.showErrorFlushbar(context, title: "Ошибка", message: state.errorMessage!);
          }
        },
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(),
          body: Container(
            height: SizeConfig.screenHeight,
            width: SizeConfig.screenWidth,
            padding: const EdgeInsets.symmetric(
                horizontal: JoyveePaddings.kScreenDefaultPadding),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "New Account!",
                    style: Theme.of(context)
                        .textTheme
                        .headlineLarge!
                        .copyWith(fontSize: 34),
                  ),
                ),
                SizedBox(height: SizeConfig.blockSizeVertical! * 2),
                _buildAvatarPicker(),
                // const SizedBox(height: 30),
                SizedBox(height: SizeConfig.blockSizeVertical! * 2),
                _buildFirstnameField(),
                _buildLastnameField(),
                SizedBox(height: SizeConfig.blockSizeVertical! * 2),
                Align(
                    alignment: Alignment.centerLeft,
                    child: Text("Sex",
                        style: Theme.of(context).textTheme.titleLarge)),
                SizedBox(height: SizeConfig.blockSizeVertical! * 2),
                _buildSexPicker(),
                // SizedBox(height: s.height * 0.05),
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
        ),
      ),
    );
  }
}
