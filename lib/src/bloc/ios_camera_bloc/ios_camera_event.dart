part of 'ios_camera_bloc.dart';


abstract class IosCameraEvent extends Equatable {}

class IosCameraInitPlatformEvent extends IosCameraEvent {
  @override
  List<Object> get props => [];
}

class IosCameraStreamStoppedEvent extends IosCameraEvent {
  @override
  List<Object> get props => [];
}

class IosCameraStreamStartedEvent extends IosCameraEvent {
  @override
  List<Object> get props => [];
}