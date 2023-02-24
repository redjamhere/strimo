import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:formz/formz.dart';

//blocs
import 'package:joyvee/src/bloc/bloc.dart';
import 'package:joyvee/src/views/profile_view/row_edit_view.dart';
//widgets
import 'package:joyvee/src/widgets/widgets.dart';
//utils
import 'package:joyvee/src/utils/utils.dart';

class ProfileEditView extends StatelessWidget {
  ProfileEditView({super.key});

  final ImagePicker _picker = ImagePicker();

  Widget _buildAvatarPicker() {
    return BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) => JoyveeAvatarPicker(
              avatar: (state.profile.sourceAvatar != null)
                  ? FileImage(state.profile.sourceAvatar!)
                  : null,
              networkAvatar: state.profile.avatar,
              onTap: () async {
                XFile? avatar =
                    await _picker.pickImage(source: ImageSource.gallery);
                if (avatar != null) {
                  // ignore: use_build_context_synchronously
                  context
                      .read<ProfileBloc>()
                      .add(ProfileAvatarChanged(File(avatar.path)));
                }
              },
              child: SvgPicture.asset("assets/svg/empty_avatar.svg"),
            ));
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Редактирование профиля"),
        foregroundColor: Colors.black,
        centerTitle: true,
      ),
      body: BlocConsumer<ProfileBloc, ProfileState>(
        listenWhen: (previous, current) => previous.profileUpdatingStatus != current.profileUpdatingStatus,
        listener: (context, state) {
          if (state.profileUpdatingStatus.isSubmissionFailure) {
            JoyveeFlushbars.showErrorFlushbar(context, title: "Error", message: state.errorMessage!);
          }
        },
        builder: (context, state) {
          return Stack(
            children: [
              Container(
                height: SizeConfig.screenHeight,
                width: SizeConfig.screenWidth,
                padding: const EdgeInsets.symmetric(
                    horizontal: JoyveePaddings.kScreenDefaultPadding),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        alignment: Alignment.center,
                        width: double.infinity,
                        child: _buildAvatarPicker()),
                    const Center(child: Text("Change avatar")),
                    SizedBox(height: SizeConfig.blockSizeVertical! * 2),
                    // personal data
                    Text("Personal data",
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge!
                            .copyWith(color: JoyveeColors.jvGreySecondary)),
                    ProfileEditRow(
                        title: "Firstname",
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (ctx) => RowEditView(
                                callback: (data) => 
                                  context.read<ProfileBloc>()
                                    .add(ProfileDataChanged(state.profile.copyWith(firstname: data))),
                                rowData: state.profile.firstname!,
                                rowName: "Firstname",
                              ))),
                        currentData: Text(state.profile.firstname!,
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold))),
                    ProfileEditRow(
                        title: "Lastname",
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (ctx) => RowEditView(
                                callback: (data) => 
                                  context.read<ProfileBloc>()
                                    .add(ProfileDataChanged(state.profile.copyWith(lastname: data))),
                                rowData: state.profile.lastname!,
                                rowName: "Lastname",
                              ))),
                        currentData: Text(state.profile.lastname!,
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold))),
                    ProfileEditRow(
                        title: "Username",
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (ctx) => RowEditView(
                              callback: (data) => 
                                context.read<ProfileBloc>()
                                  .add(ProfileDataChanged(state.profile.copyWith(username: data))),
                              rowData: state.profile.username!,
                              rowName: "Username",
                            ))),
                        currentData: Text(state.profile.username!,
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold))),
                    ProfileEditRow(
                        title: "About",
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (ctx) => RowEditView(
                              maxLines: 5,
                              maxLength: 80,
                              callback: (data) => 
                                context.read<ProfileBloc>()
                                  .add(ProfileDataChanged(state.profile.copyWith(about: data))),
                              rowData: state.profile.about!,
                              rowName: "About",
                            ))),
                        currentData: Flexible(
                            child: Text(state.profile.about!,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(fontSize: 16)))),
                    SizedBox(
                      height: SizeConfig.blockSizeVertical! * 5,
                      child: InkWell(
                        onTap: () {},
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              "joyvee.live/${state.profile.username}",
                              style: const TextStyle(fontSize: 16),
                            ),
                            SizedBox(
                              width: SizeConfig.blockSizeHorizontal,
                            ),
                            const Icon(
                              Icons.copy_rounded,
                              color: JoyveeColors.jvGreyHeadLine,
                            ),
                          ],
                        ),
                      ),
                    ),
                    // social links
                    Text("Social",
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge!
                            .copyWith(color: JoyveeColors.jvGreySecondary)),
                    ProfileEditRow(
                        title: "Instagram",
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (ctx) => RowEditView(
                              maxLength: 300,
                              callback: (data) => 
                                context.read<ProfileBloc>()
                                  .add(ProfileDataChanged(state.profile.copyWith(instagramUrl: data))),
                              rowData: state.profile.instagramUrl!,
                              rowName: "Instagram link",
                            ))),
                        currentData: Flexible(
                          child: Text(
                            (state.profile.instagramUrl!.isEmpty) ? "Add link to profile" : state.profile.instagramUrl!,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                fontSize: 16,
                                color: JoyveeColors.jvGreyHeadLine)),
                        )),
                    ProfileEditRow(
                        title: "YouTube",
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (ctx) => RowEditView(
                              maxLength: 300,
                              callback: (data) => 
                                context.read<ProfileBloc>()
                                  .add(ProfileDataChanged(state.profile.copyWith(youtubeUrl: data))),
                              rowData: state.profile.youtubeUrl!,
                              rowName: "YouTube link",
                            ))),
                        currentData: Flexible(
                          child: Text(
                            (state.profile.youtubeUrl!.isEmpty) ? "Add link to profile" : state.profile.youtubeUrl!,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                fontSize: 16,
                                color: JoyveeColors.jvGreyHeadLine)),
                        )),
                    ProfileEditRow(
                        title: "TikTok",
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (ctx) => RowEditView(
                              maxLength: 300,
                              callback: (data) => 
                                context.read<ProfileBloc>()
                                  .add(ProfileDataChanged(state.profile.copyWith(tiktokUrl: data))),
                              rowData: state.profile.tiktokUrl!,
                              rowName: "TikTok link",
                            ))),
                        currentData: Flexible(
                          child: Text(
                            (state.profile.tiktokUrl!.isEmpty) ? "Add link to profile" : state.profile.tiktokUrl!,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                fontSize: 16,
                                color: JoyveeColors.jvGreyHeadLine)),
                        )),
                  ],
                ),
              ),
              Visibility(
                visible: state.profileUpdatingStatus.isSubmissionInProgress,
                child: const FullScreenProgressIndicator(),
              )
            ],
          );
        },
      ),
    );
  }
}
