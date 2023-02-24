part of 'ios_camera_bloc.dart';

abstract class IosCameraState extends Equatable {}

class IosCameraStateInit extends IosCameraState {
  @override
  List<Object> get props => [];
}

class IosCameraStateReady extends IosCameraState {
  IosCameraStateReady({
    this.stream,
    required this.cameraPosition,
  });

  final RtmpStream? stream;
  final CameraPosition cameraPosition;

  IosCameraStateReady copyWith({
    RtmpStream? stream,
    CameraPosition? cameraPosition
  }) => IosCameraStateReady(
    stream: stream?? this.stream,
    cameraPosition: cameraPosition?? this.cameraPosition
  );

  @override
  List<Object> get props => [cameraPosition];
}

class IosCameraStateFailure extends IosCameraState {
  IosCameraStateFailure({
    this.errorMessage = ""
  });
  final String errorMessage;

  IosCameraStateFailure copyWith({
    String? errorMessage
  }) => IosCameraStateFailure(
    errorMessage: errorMessage?? this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}

class IosCameraStateStopped extends IosCameraState {
  IosCameraStateStopped();
  @override
  List<Object> get props => [];
}
