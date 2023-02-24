
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:joyvee/src/repository/respository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/models.dart';
part 'pick_location_state.dart';

class PickLocationCubit extends Cubit<PickLocationState> {
  PickLocationCubit({
    required UserRepository userRepository,
  }) : _userRepository = userRepository, super(const PickLocationState());

  final UserRepository _userRepository;

  void getUserCurrentLocation() async {
    emit(state.copyWith(currentPositionStatus: FormzStatus.submissionInProgress));
    try {
      Position? pos = await _userRepository.getCurrentPosition();
      emit(state.copyWith(pickedPosition: CameraPosition(
        target: LatLng(pos.latitude, pos.longitude),
        zoom: 12
      ), currentPositionStatus: FormzStatus.submissionSuccess));
    } catch (e) {
      emit(state.copyWith(currentPositionStatus: FormzStatus.submissionFailure));
    }
  }

  void pickLocation() async {
    emit(state.copyWith(pickLocationStatus: FormzStatus.submissionInProgress));
    try {
      List<Placemark> pls = await placemarkFromCoordinates(
          state.pickedPosition.target.latitude,
          state.pickedPosition.target.longitude, localeIdentifier: "en");
      Placemark mark = pls[0];
      emit(state.copyWith(pickLocationStatus: FormzStatus.submissionSuccess, pickedPlace: PickedPlace(
        position: LatLng(
            state.pickedPosition.target.latitude,
            state.pickedPosition.target.longitude),
        country: mark.country,
        city: mark.subAdministrativeArea
      )));
    } catch (e) {
      emit(state.copyWith(pickLocationStatus: FormzStatus.submissionFailure));
    }
  }

  void onCameraMove(CameraPosition pos) {
    emit(state.copyWith(pickedPosition: pos));
    print(state.pickedPosition);
  }
}