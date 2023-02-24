part of 'camera_bloc.dart';

class CameraState extends Equatable {
  const CameraState({
    required this.streamInfo,
    this.isFlashLightEnabled = false,
    this.isStreamStopped = false,
    this.streamStatus = StreamStatus.initial
  });
  
  final bool isFlashLightEnabled;
  final StreamStatus streamStatus;
  final JStream streamInfo;

  final bool isStreamStopped;

  CameraState copyWith({
    bool? isFlashLightEnabled,
    JStream? streamInfo,
    StreamStatus? streamStatus,
    bool? isStreamStopped
  }) => CameraState(
    isFlashLightEnabled: isFlashLightEnabled?? this.isFlashLightEnabled,
    streamInfo: streamInfo?? this.streamInfo,
    streamStatus: streamStatus?? this.streamStatus,
    isStreamStopped: isStreamStopped?? this.isStreamStopped
  );

  @override
  List<Object> get props => [isFlashLightEnabled, streamStatus, streamInfo, isStreamStopped];
}