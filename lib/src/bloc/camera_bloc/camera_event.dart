part of 'camera_bloc.dart';

abstract class CameraEvent extends Equatable {}

class CameraFlashLightChanged extends CameraEvent {
  CameraFlashLightChanged(this.isEnabled);
  final bool isEnabled;
  @override
  List<Object> get props => [];
}

class CameraFlashLightPressed extends CameraEvent {
  @override
  List<Object> get props => [];
}

class CameraSwitchPressed extends CameraEvent {
  @override
  List<Object> get props => [];
}

class CameraConnectionStatusChanged extends CameraEvent {
  CameraConnectionStatusChanged(this.status);
  final StreamStatus status;

  @override
  List<Object> get props => [status];
}

class CameraStreamStarted extends CameraEvent {
  @override
  List<Object> get props => [];
}

class CameraStreamStopped extends CameraEvent {
  @override
  List<Object> get props => [];
}