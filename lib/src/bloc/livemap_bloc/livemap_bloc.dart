// описание логики карты с трансляциями
import 'dart:async';
import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:geolocator/geolocator.dart';
import 'package:joyvee/src/models/models.dart';
import 'package:joyvee/src/repository/map_repository.dart';
import 'package:collection/collection.dart';

//repositories
import 'package:joyvee/src/repository/respository.dart';

part 'livemap_state.dart';
part 'livemap_event.dart';

class LivemapBloc extends Bloc<LivemapEvent, LivemapState> {
  LivemapBloc({
    required UserRepository userRepository,
    required MapRepository mapRepository
  }) 
  : _userRepository = userRepository,
    _mapRepository = mapRepository,
    super(const LivemapState()) {
      on<LivemapFetchMarkersRequested>(_onLivemapFetchMarkersRequested);
      on<LivemapFetchMarkers>(_onLivemapFetchMarkers);
      on<LivemapMarkerTapped>(_onLivemapMarkerTapped);
      on<LivemapGetUserCurrentPositionRequested>(_onLivemapGetUserCurrentPositionRequested);
    }

  final UserRepository _userRepository;
  final MapRepository _mapRepository;

  StreamSubscription? _periodicSubscription;

  @override
  Future<void> close() async {
    await _periodicSubscription?.cancel();
    _periodicSubscription = null;
    return super.close();
  }

  void _onLivemapFetchMarkersRequested(
    LivemapFetchMarkersRequested event,
    Emitter<LivemapState> emit,
  ) async {
    add(LivemapFetchMarkers());
    _periodicSubscription ??=
      Stream.periodic(const Duration(seconds: 60), (x) => x)
        .listen((_) => add(LivemapFetchMarkers()),
        onError: (e) => emit(state.copyWith(errorMessage: e.toString(), mapContentStatus: FormzStatus.submissionFailure))
      );
  } 

  void _onLivemapFetchMarkers(
    LivemapFetchMarkers event,
    Emitter<LivemapState> emit
  ) async {
      emit(state.copyWith(mapContentStatus: FormzStatus.submissionInProgress));
     try {
      MapContent result = await _mapRepository.getMarkersForMap(_userRepository.user, state.contentFilter);
      return emit(state.copyWith(mapContent: result, mapContentStatus: FormzStatus.submissionSuccess));
    } catch (e) {
      return emit(state.copyWith(errorMessage: e.toString(), mapContentStatus: FormzStatus.submissionFailure));
    }
  }

  void _onLivemapMarkerTapped(
    LivemapMarkerTapped event,
    Emitter<LivemapState> emit
  ) async {
    emit(state.copyWith(streamInfoLoadingStatus: FormzStatus.submissionInProgress));
    await Future.delayed(const Duration(seconds: 2));
    try {
      JStream streamInfo = await _mapRepository.getStreamInfo(_userRepository.user, event.id);
      emit(state.copyWith(streamInfo: streamInfo, streamInfoLoadingStatus: FormzStatus.submissionSuccess));
    } catch (e) {
      emit(state.copyWith(errorMessage: e.toString(), streamInfoLoadingStatus: FormzStatus.submissionFailure));
    }
  }

  void _onLivemapGetUserCurrentPositionRequested(
    LivemapGetUserCurrentPositionRequested event,
    Emitter<LivemapState> emit
  ) async {
    Position p = await _userRepository.getCurrentPosition();
    return emit(state.copyWith(userCurrentPosition: p));
  }
  

}