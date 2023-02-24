part of 'stream_type_view.dart';

class SetupStreamStepTwo extends StatelessWidget {
  const SetupStreamStepTwo({Key? key}) : super(key: key);

  Widget _buildLocationPickerField() {
    return BlocBuilder<StreamSetupBloc, StreamSetupState>(
      buildWhen: (previous, current) =>
          previous.pickedPlace != current.pickedPlace,
      builder: (context, state) {
        return JoyveeDefaultTextField(
          style: Theme.of(context)
              .textTheme
              .bodyLarge!
              .copyWith(fontSize: 17, fontWeight: FontWeight.w600),
          controller: TextEditingController(),
          hintText: state.pickedPlace.value.position == null
              ? 'Pick your location'
              : state.pickedPlace.value.toString(),
          readOnly: true,
          errorText: (state.pickedPlace.invalid)
              ? "Город и страна не могут быть пустыми"
              : null,
          onTap: () async => await Navigator.push(
              context,
              CupertinoPageRoute(
                  builder: (ctx) => BlocProvider.value(
                    value: context.read<PickLocationCubit>(),
                    child: PickLocationView()))));
      },
    );
  }

  Widget _buildCostField() {
    return BlocBuilder<StreamSetupBloc, StreamSetupState>(
      buildWhen: (previous, current) => previous.cost != current.cost,
      builder: (context, state) {
        return JoyveeDefaultTextField(
          style: Theme.of(context)
              .textTheme
              .bodyLarge!
              .copyWith(fontSize: 17, fontWeight: FontWeight.w600),
          hintText: 'Stream cost',
          suffixWidget: Padding(
            padding: const EdgeInsets.only(right: 18),
            child: Text(
              state.currency.toUpperCase(),
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ),
          showSuffix: true,
          controller: state.costController,
          onChanged: (cost) => context.read<StreamSetupBloc>().add(
              StreamSetupCostChanged(cost.isNotEmpty ? double.parse(cost) : 0)),
          textInputType: TextInputType.number,
        );
      },
    );
  }

  Widget _buildIsPrivateSwitcher() {
    return BlocBuilder<StreamSetupBloc, StreamSetupState>(
      buildWhen: (previous, current) =>
          previous.setupedStream.isPrivate != current.setupedStream.isPrivate,
      builder: (context, state) {
        return StreamSettingCheckbox(
          label: Text(
            "Private stream",
            style:
                Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 17),
          ),
          value: state.setupedStream.isPrivate,
          onChanged: (isPrivate) => context
              .read<StreamSetupBloc>()
              .add(StreamSetupIsPrivateChanged(isPrivate)),
        );
      },
    );
  }

  Widget _buildIsFreeSwitcher() {
    return BlocBuilder<StreamSetupBloc, StreamSetupState>(
      buildWhen: (previous, current) => previous.isFree != current.isFree,
      builder: (context, state) {
        return StreamSettingCheckbox(
          label: Text(
            "Make it free",
            style:
                Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 17),
          ),
          value: state.isFree,
          onChanged: (isFree) => context
              .read<StreamSetupBloc>()
              .add(StreamSetupIsFreeChanged(isFree)),
        );
      },
    );
  }

  Widget _buildIsChatEnabledSwitcher() {
    return BlocBuilder<StreamSetupBloc, StreamSetupState>(
      buildWhen: (previous, current) =>
          previous.setupedStream.isChatEnabled !=
          current.setupedStream.isChatEnabled,
      builder: (context, state) {
        return StreamSettingCheckbox(
          label: Text(
            "Stream chat",
            style:
                Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 17),
          ),
          value: state.setupedStream.isChatEnabled,
          onChanged: (isChatEnabled) => context
              .read<StreamSetupBloc>()
              .add(StreamSetupChatEnabledChanged(isChatEnabled)),
        );
      },
    );
  }

  Widget _buildIsInstagramSharedSwitcher() {
    return BlocBuilder<StreamSetupBloc, StreamSetupState>(
      builder: (context, state) {
        return StreamSettingCheckbox(
          label: Row(
            children: [
              SvgPicture.asset("assets/svg/instagram_filled.svg"),
              SizedBox(
                width: SizeConfig.blockSizeHorizontal! * 2,
              ),
              Text(
                "Instagram",
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(fontSize: 17),
              )
            ],
          ),
          value: state.setupedStream.isInstagramShared,
          onChanged: (isInstagramShared) => context
              .read<StreamSetupBloc>()
              .add(StreamSetupInstagramShared(isInstagramShared)),
        );
      },
    );
  }

  Widget _buildIsTikTokSharedSwitcher() {
    return BlocBuilder<StreamSetupBloc, StreamSetupState>(
      builder: (context, state) {
        return StreamSettingCheckbox(
          label: Row(
            children: [
              SvgPicture.asset("assets/svg/tiktok_filled.svg"),
              SizedBox(
                width: SizeConfig.blockSizeHorizontal! * 2,
              ),
              Text(
                "TikTok",
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(fontSize: 17),
              )
            ],
          ),
          value: state.setupedStream.isTikTokShared,
          onChanged: (isTikTokShared) => context
              .read<StreamSetupBloc>()
              .add(StreamSetupInstagramShared(isTikTokShared)),
        );
      },
    );
  }

  Widget _buildIsYouTubeSharedSwitcher() {
    return BlocBuilder<StreamSetupBloc, StreamSetupState>(
      builder: (context, state) {
        return StreamSettingCheckbox(
          label: Row(
            children: [
              SvgPicture.asset("assets/svg/youtube_filled.svg"),
              SizedBox(
                width: SizeConfig.blockSizeHorizontal! * 2,
              ),
              Text(
                "YouTube",
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(fontSize: 17),
              )
            ],
          ),
          value: state.setupedStream.isYouTubeShared,
          onChanged: (isYouTubeShared) => context
              .read<StreamSetupBloc>()
              .add(StreamSetupInstagramShared(isYouTubeShared)),
        );
      },
    );
  }

  Widget _buildFloatingActionButton() {
    return BlocBuilder<StreamSetupBloc, StreamSetupState>(
      builder: (context, state) {
        return JoyveeElevatedButton(
            style: Theme.of(context).elevatedButtonTheme.style!.copyWith(
                elevation: MaterialStateProperty.all<double>(10),
                shadowColor: MaterialStateProperty.resolveWith<Color>(
                    (Set<MaterialState> states) {
                  if (states.contains(MaterialState.disabled)) {
                    return JoyveeColors.jvGreyDisabledButton;
                  }
                  return JoyveeColors.jvOrange;
                }),
                // minimumSize: MaterialStateProperty.all<Size>(const Size(60, 60)),
                padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                    const EdgeInsets.all(20)),
                minimumSize:
                    MaterialStateProperty.all<Size>(const Size.fromHeight(0))),
            func: state.streamSetupSecondStepStatus.isValidated
                ? () => context
                    .read<StreamSetupBloc>()
                    .add(StreamSetupSecondStepSubmitted())
                : null,
            child: const Text("Start stream"));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return BlocConsumer<StreamSetupBloc, StreamSetupState>(
      listenWhen: (previous, current) =>
          previous.streamSetupSecondStepStatus !=
          current.streamSetupSecondStepStatus,
      listener: (context, state) {
        if (state.streamSetupSecondStepStatus.isSubmissionSuccess) {
          if (Platform.isAndroid) {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                    builder: (ctx) => MultiBlocProvider(
                          providers: [
                            BlocProvider(
                              create: (context) => CameraBloc(
                                  state.setupedStream,
                                  userRepository:
                                      RepositoryProvider.of<UserRepository>(
                                          context)),
                            ),
                            BlocProvider(
                              create: (context) => StreamChatBloc(
                                streamInfo: state.setupedStream,
                                userRepository: context.read<UserRepository>(),
                                streamChatRepository: context.read<StreamChatRepository>()
                              ),
                            ),
                          ],
                          child: CameraView(),
                        )),
                (route) => false);
          }
          if (Platform.isIOS) {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (ctx) => MultiBlocProvider(
                      providers: [
                        BlocProvider(
                          create: (context) => IosCameraBloc(
                              state.setupedStream,
                              iosStreamRepository: RepositoryProvider.of<IosStreamRepository>(context),
                              userRepository: RepositoryProvider
                                  .of<UserRepository>(context))
                          ..add(IosCameraInitPlatformEvent()),
                        ),
                        BlocProvider(
                          create: (context) => StreamChatBloc(
                            streamInfo: state.setupedStream,
                            userRepository: context.read<UserRepository>(),
                            streamChatRepository: context.read<StreamChatRepository>()
                          ),
                        )
                      ],
                      child: IosCameraView())
                ), (route) => false);
          }
        }
        if (state.streamSetupSecondStepStatus.isSubmissionFailure) {
          JoyveeFlushbars.showErrorFlushbar(context,
              title: "Ошибка", message: state.errorMessage!);
        }
      },
      builder: (context, state) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            iconTheme: const IconThemeData(color: Colors.black),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          floatingActionButton: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: SizeConfig.blockSizeHorizontal! * 4),
            child: _buildFloatingActionButton(),
          ),
          body: Stack(
            children: [
              LayoutBuilder(builder: (context, constrains) {
                return SingleChildScrollView(
                  child: Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: SizeConfig.blockSizeHorizontal! * 4),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text("Stream settings",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context).textTheme.headlineLarge),
                        ),
                        SizedBox(height: SizeConfig.blockSizeHorizontal! * 4),
                        Text("Location",
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .copyWith(
                                    color: JoyveeColors.jvGreySecondary,
                                    fontSize: 12 *
                                        MediaQuery.of(context)
                                            .textScaleFactor)),
                        SizedBox(height: SizeConfig.blockSizeHorizontal! * 2),
                        _buildLocationPickerField(),
                        SizedBox(height: SizeConfig.blockSizeHorizontal!),
                        Text(
                            "Specify the location where you will broadcast, such as the country, city, address, or island on the map.",
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .copyWith(
                                    fontSize: 12 *
                                        MediaQuery.textScaleFactorOf(context))),
                        SizedBox(height: SizeConfig.blockSizeHorizontal! * 4),
                        Text("Cost",
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .copyWith(
                                    color: JoyveeColors.jvGreySecondary,
                                    fontSize: 12 *
                                        MediaQuery.of(context)
                                            .textScaleFactor)),
                        SizedBox(height: SizeConfig.blockSizeHorizontal! * 2),
                        _buildCostField(),
                        SizedBox(height: SizeConfig.blockSizeHorizontal! * 4),
                        _buildIsPrivateSwitcher(),
                        SizedBox(height: SizeConfig.blockSizeHorizontal!),
                        Text(
                            "You can limit the number of broadcast participants to one or allow an unlimited number of users to connect.",
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .copyWith(
                                    fontSize: 12 *
                                        MediaQuery.textScaleFactorOf(context))),
                        SizedBox(height: SizeConfig.blockSizeHorizontal! * 4),
                        _buildIsFreeSwitcher(),
                        _buildIsChatEnabledSwitcher(),
                        SizedBox(height: SizeConfig.blockSizeHorizontal! * 4),
                        Text("Share",
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .copyWith(
                                    color: JoyveeColors.jvGreySecondary,
                                    fontSize: 12 *
                                        MediaQuery.of(context)
                                            .textScaleFactor)),
                        SizedBox(height: SizeConfig.blockSizeHorizontal! * 2),
                        _buildIsInstagramSharedSwitcher(),
                        _buildIsYouTubeSharedSwitcher(),
                        _buildIsTikTokSharedSwitcher(),
                        SizedBox(
                          height: (constrains.maxHeight < 500)
                              ? SizeConfig.blockSizeVertical! * 15
                              : 0,
                        ),
                        SizedBox(
                          height: (constrains.maxHeight < 700)
                              ? SizeConfig.blockSizeVertical! * 10
                              : 0,
                        )
                      ],
                    ),
                  ),
                );
              }),
              Visibility(
                  visible:
                      state.streamSetupSecondStepStatus.isSubmissionInProgress,
                  child: const FullScreenProgressIndicator())
            ],
          ),
        );
      },
    );
  }
}
