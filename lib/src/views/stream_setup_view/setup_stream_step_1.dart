// описания экрана первого этапа заполнения данных трансляции
part of 'stream_type_view.dart';

class SetupStreamStepOne extends StatelessWidget {
  SetupStreamStepOne({Key? key}) : super(key: key);

  final ImagePicker _picker = ImagePicker();
  FileImage? preview;

  Widget _buildNameField() {
    return BlocBuilder<StreamSetupBloc, StreamSetupState>(
      builder: (context, state) {
        return JoyveeDefaultTextField(
          style: Theme.of(context)
              .textTheme
              .bodyLarge!
              .copyWith(fontSize: 17, fontWeight: FontWeight.w600),
          hintText: "Stream name",
          onChanged: (name) =>
              context.read<StreamSetupBloc>().add(StreamSetupNameChanged(name)),
          autofocus: true,
          errorText: state.name.invalid ? "Имя не может быть пустым" : null,
        );
      },
    );
  }

  Widget _buildDescriptionField(BoxConstraints constraints) {
    return BlocBuilder<StreamSetupBloc, StreamSetupState>(
      builder: (context, state) {
        return JoyveeDescriptionTextField(
          style: Theme.of(context)
              .textTheme
              .bodyLarge!
              .copyWith(fontSize: 17, fontWeight: FontWeight.w600),
          hintText: 'Enter stream description',
          onChanged: (description) => context
              .read<StreamSetupBloc>()
              .add(StreamSetupDescriptionChanged(description)),
          maxLines: (constraints.maxHeight < 550) ? 5 : 7,
          errorText:
              state.name.invalid ? "Описание не может быть пустым" : null,
        );
      },
    );
  }

  Widget _buildPreviewPicker() {
    return BlocBuilder<StreamSetupBloc, StreamSetupState>(
      builder: (context, state) {
        return JoyveePreviewPicker(
          preview: (state.setupedStream.sourcePreview != null)
              ? FileImage(state.setupedStream.sourcePreview!)
              : null,
          onTap: () async {
            XFile? _preview =
                await _picker.pickImage(source: ImageSource.gallery);
            if (_preview != null) {
              // ignore: use_build_context_synchronously
              context
                  .read<StreamSetupBloc>()
                  .add(StreamSetupPreviewPicked(File(_preview.path)));
            }
          },
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
                minimumSize:
                    MaterialStateProperty.all<Size>(const Size(60, 60)),
                padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                    const EdgeInsets.all(20)),
                shape: MaterialStateProperty.all<CircleBorder>(
                    const CircleBorder())),
            func: state.streamSetupFirstStepStatus.isValidated
                ? () => Navigator.push(
                    context,
                    CupertinoPageRoute(
                        builder: (ctx) => MultiBlocProvider(
                            providers: [
                              BlocProvider.value(
                                value: context.read<StreamSetupBloc>(),
                              ),
                              BlocProvider.value(
                                value: context.read<PickLocationCubit>(),
                              )
                            ],
                            child: const SetupStreamStepTwo())))
                : null,
            child: const Icon(Icons.arrow_forward));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.black),
        ),
        floatingActionButtonLocation:
            FloatingActionButtonLocation.centerFloat,
        floatingActionButton: _buildFloatingActionButton(),
        body: LayoutBuilder(builder: (context, constraints) {
          return SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.symmetric(
                  horizontal: SizeConfig.blockSizeHorizontal! * 4),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text("Stream settings",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.headlineLarge),
                  ),
                  SizedBox(
                    height: SizeConfig.blockSizeHorizontal! * 4,
                  ),
                  _buildNameField(),
                  SizedBox(height: SizeConfig.blockSizeHorizontal! * 4),
                  Text("DESCRIPTION",
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          color: JoyveeColors.jvGreySecondary,
                          fontSize:
                              12 * MediaQuery.of(context).textScaleFactor)),
                  SizedBox(height: SizeConfig.blockSizeHorizontal! * 2),
                  _buildDescriptionField(constraints),
                  SizedBox(height: SizeConfig.blockSizeHorizontal!),
                  Text(
                    "Also include some hashtags to make it easier for other users to find you.",
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        fontSize: 12 * MediaQuery.textScaleFactorOf(context)),
                  ),
                  SizedBox(height: SizeConfig.blockSizeHorizontal! * 4),
                  Text("PREVIEW PHOTO",
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          color: JoyveeColors.jvGreySecondary,
                          fontSize:
                              12 * MediaQuery.of(context).textScaleFactor)),
                  SizedBox(height: SizeConfig.blockSizeHorizontal! * 2),
                  _buildPreviewPicker(),
                  SizedBox(height: SizeConfig.blockSizeHorizontal!),
                  Text(
                    "Take a photo of the location so that users how she looks like",
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        fontSize: 12 * MediaQuery.textScaleFactorOf(context)),
                  ),
                  SizedBox(
                    height: (constraints.maxHeight < 500)
                        ? SizeConfig.blockSizeVertical! * 17
                        : 0,
                  )
                ],
              ),
            ),
          );
        }));
  }
}
