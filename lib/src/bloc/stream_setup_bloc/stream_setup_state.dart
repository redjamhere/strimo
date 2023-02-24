part of 'stream_setup_bloc.dart';

class StreamSetupState extends Equatable {
  StreamSetupState({
    this.streamSetupFirstStepStatus = FormzStatus.pure,
    this.streamSetupSecondStepStatus = FormzStatus.pure,
    this.name = const StreamName.pure(),
    this.description = const StreamDescription.pure(),
    this.pickedPlace = const PickedPlaceFormz.pure(),
    this.cost = const Cost.pure(),
    required this.streamType,
    required this.currency,
    this.setupedStream = const JStream.emptyConstructor(),
    this.isFree = true,
    this.errorMessage,
    this.streamStartKey = "",
    TextEditingController? costController,
  }) : costController = costController?? TextEditingController();

  final StreamType streamType;
  final FormzStatus streamSetupFirstStepStatus;

  final StreamName name;
  final StreamDescription description;
  
  final PickedPlaceFormz pickedPlace;
  final Cost cost;
  final TextEditingController costController;
  final bool isFree;
  final FormzStatus streamSetupSecondStepStatus;

  final JStream setupedStream;

  final String? errorMessage;
  final String streamStartKey;
  final String currency;

  StreamSetupState copyWith({
    StreamType? streamType,
    FormzStatus? streamSetupFirstStepStatus,
    FormzStatus? streamSetupSecondStepStatus,
    StreamName? streamName,
    StreamDescription? streamDescription,
    PickedPlaceFormz? pickedPlace,
    Cost? cost,
    JStream? setupedStream,
    String? errorMessage,
    bool? isFree,
    String? currency,
    TextEditingController? costController,
    String? streamStartKey
  }) => StreamSetupState(
    streamStartKey: streamStartKey?? this.streamStartKey,
    streamType: streamType?? this.streamType,
    streamSetupFirstStepStatus: streamSetupFirstStepStatus?? this.streamSetupFirstStepStatus,
    streamSetupSecondStepStatus: streamSetupSecondStepStatus?? this.streamSetupSecondStepStatus,
    name: streamName?? name,
    description: streamDescription?? description,
    pickedPlace: pickedPlace?? this.pickedPlace,
    cost: cost?? this.cost,
    setupedStream: setupedStream?? this.setupedStream,
    errorMessage: errorMessage?? this.errorMessage,
    isFree: isFree?? this.isFree,
    currency: currency?? this.currency,
    costController: costController?? this.costController
  );

  @override
  List<Object> get props => [
    streamStartKey,
    streamType, 
    streamSetupFirstStepStatus, 
    streamSetupSecondStepStatus, 
    name,  
    description, 
    pickedPlace, 
    cost, 
    setupedStream, 
    isFree, 
    currency,
    costController
  ];
}