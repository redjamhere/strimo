// описание логики стрима для ios

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:haishin_kit/audio_settings.dart';
import 'package:haishin_kit/audio_source.dart';
import 'package:haishin_kit/rtmp_connection.dart';
import 'package:haishin_kit/rtmp_stream.dart';
import 'package:haishin_kit/video_settings.dart';
import 'package:haishin_kit/video_source.dart';
import 'package:joyvee/src/repository/respository.dart';
import 'package:camera/camera.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:audio_session/audio_session.dart';

import 'package:joyvee/src/models/models.dart';
import 'package:joyvee/src/utils/utils.dart';

part 'ios_camera_event.dart';
part 'ios_camera_state.dart';

class IosCameraBloc extends Bloc<IosCameraEvent, IosCameraState> {
  IosCameraBloc(JStream streamInfo, {
    required UserRepository userRepository,
    required IosStreamRepository iosStreamRepository
  }) :
    _userRepository = userRepository,
    _iosStreamRepository = iosStreamRepository,
    super(IosCameraStateInit()) {
    on<IosCameraInitPlatformEvent>(_onIosCameraInitPlatformEvent);
    on<IosCameraStreamStoppedEvent>(_onIosCameraStreamStoppedEvent);
    on<IosCameraStreamStartedEvent>(_onIosCameraStreamStartedEvent);
  }

  final UserRepository _userRepository;
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
    _iosStreamRepository.startStream(LiveAPI.rtmpURL, _userRepository.user.streamKey!);
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