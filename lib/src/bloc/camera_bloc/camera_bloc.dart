// описание логики стрима
import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:joyvee/src/mixin/mixins.dart';
import 'package:joyvee/src/models/models.dart';
import 'package:joyvee/src/repository/respository.dart';
import 'package:joyvee/src/utils/urls.dart';
import 'package:strimocamera/strimocamera.dart';

part 'camera_state.dart';
part 'camera_event.dart';

class CameraBloc extends Bloc<CameraEvent, CameraState> with UserStorageMixin {
  CameraBloc(JStream streamInfo) : super(CameraState(streamInfo: streamInfo)) {
      on<CameraFlashLightChanged>(_onCameraFlashLightStatusChanged);
      on<CameraFlashLightPressed>(_onCameraFlashLightPressed);
      on<CameraSwitchPressed>(_onCameraSwitchPressed);
      on<CameraConnectionStatusChanged>(_onCameraConnectionStatusChanged);
      on<CameraStreamStarted>(_onCameraStreamStarted);
      on<CameraStreamStopped>(_onCameraStreamStopped);
      _flashLightSubscription = _controller.isFlashLightEnabled.listen((event) {
        add(CameraFlashLightChanged(event));
      });
      _connectionStatusSubscription = _controller.eventStream.listen((event) { 
        add(CameraConnectionStatusChanged(event));
      });
  }


  final JoyveeCameraController _controller = JoyveeCameraController();
  JoyveeCameraController get controller => _controller;

  late StreamSubscription<bool> _flashLightSubscription;
  late StreamSubscription<StreamStatus> _connectionStatusSubscription;


  @override
  Future<void> close() {
    _connectionStatusSubscription.cancel();
    _flashLightSubscription.cancel();
    return super.close();
  }


  void _onCameraConnectionStatusChanged(
    CameraConnectionStatusChanged event,
    Emitter<CameraState> emit
  )  {
    emit(state.copyWith(streamStatus: event.status));
  }

  void _onCameraFlashLightStatusChanged(
    CameraFlashLightChanged event,
    Emitter<CameraState> emit
  ) {
    emit(state.copyWith(isFlashLightEnabled: event.isEnabled));
  }

  void _onCameraFlashLightPressed(
    CameraFlashLightPressed event,
    Emitter<CameraState> emit
  ) async {
    (state.isFlashLightEnabled)
      ? await _controller.disableFlashLight()
      : await _controller.enableFlashLight();
  }

  void _onCameraSwitchPressed(
    CameraSwitchPressed event,
    Emitter<CameraState> emit
  ) async {
    await _controller.switchCamera();
  }

  void _onCameraStreamStarted(
    CameraStreamStarted event,
    Emitter<CameraState> emit
  ) async {
    var user = getUserFromStorage();
    await controller.startStream('${LiveAPI.rtmpURL}${user!.streamKey}');
  }

  void _onCameraStreamStopped(
    CameraStreamStopped event,
    Emitter<CameraState> emit
  ) async {
    try {
      controller.stopStream();
      emit(state.copyWith(isStreamStopped: true));
    } catch (e) {
      rethrow;
    }
  }

}