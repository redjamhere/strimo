part of 'camera_bloc.dart';

class CameraEvent extends Equatable {
  const CameraEvent();
  @override
  List<Object> get props => [];
}

class CameraFlashLightChanged extends CameraEvent {
  const CameraFlashLightChanged(this.isEnabled);
  final bool isEnabled;
  @override
  List<Object> get props => [];
}

class CameraFlashLightPressed extends CameraEvent {}

class CameraSwitchPressed extends CameraEvent {}

class CameraConnectionStatusChanged extends CameraEvent {
  const CameraConnectionStatusChanged(this.status);
  final StreamStatus status;

  @override
  List<Object> get props => [status];
}

class CameraStreamStarted extends CameraEvent {}

class CameraStreamStopped extends CameraEvent {}