// описание логики стрима для ios

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:haishin_kit/rtmp_stream.dart';
import 'package:haishin_kit/video_source.dart';
import 'package:joyvee/src/mixin/mixins.dart';
import 'package:joyvee/src/repository/respository.dart';

import 'package:joyvee/src/models/models.dart';
import 'package:joyvee/src/utils/utils.dart';

part 'ios_camera_event.dart';
part 'ios_camera_state.dart';

class IosCameraBloc extends Bloc<IosCameraEvent, IosCameraState> 
  with UserStorageMixin{
  IosCameraBloc(JStream streamInfo, {
    required IosStreamRepository iosStreamRepository
  }) :
    _iosStreamRepository = iosStreamRepository,
    super(IosCameraStateInit()) {
    on<IosCameraInitPlatformEvent>(_onIosCameraInitPlatformEvent);
    on<IosCameraStreamStoppedEvent>(_onIosCameraStreamStoppedEvent);
    on<IosCameraStreamStartedEvent>(_onIosCameraStreamStartedEvent);
  }

  final IosStreamRepository _iosStreamRepository;

  @override
  Future<void> close() {
    _iosStreamRepository.dispose();
    return super.close();
  }

  void _onIosCameraInitPlatformEvent(
    IosCameraInitPlatformEvent event,
    Emitter<IosCameraState> emit
  ) async {
    await _iosStreamRepository.initIosPlatform();
    add(IosCameraStreamStartedEvent());
    emit(IosCameraStateReady(stream: _iosStreamRepository.stream, cameraPosition: _iosStreamRepository.cameraPosition));
  }

  void _onIosCameraStreamStartedEvent(
    IosCameraStreamStartedEvent event,
    Emitter<IosCameraState> emit,
  ) {
    var user = getUserFromStorage();
    _iosStreamRepository.startStream(LiveAPI.rtmpURL, user!.streamKey!);
  }

  void _onIosCameraStreamStoppedEvent(
    IosCameraStreamStoppedEvent event,
    Emitter<IosCameraState> emit,
  ) async {
    _iosStreamRepository.stopStream();
    emit(IosCameraStateStopped());
    close();
  }

}