// описания логики выбора локации
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:geolocator/geolocator.dart';
import 'package:joyvee/src/models/formz_models/formz.dart';

//models
import '../../models/picked_place.dart';

//repositories
import '../../repository/map_repository.dart';

part 'place_picker_state.dart';
part 'place_picker_event.dart';

class PlacePickerBloc extends Bloc<PlacePickerEvent, PlacePickerState> {
  PlacePickerBloc({
    required MapRepository mapRepository
  }) : _mapRepository = mapRepository,
     super(const PlacePickerState()) {

     }

  final MapRepository _mapRepository;


  void _onPlacePickerDeterminePositon(
    PlacePickerDeterminePosition event,
    Emitter<PlacePickerState> emit
  ) async {
    emit(state.copyWith(determinePositionStatus: DeterminePositionStatus.during));
    try {
      Position position = await _mapRepository.getUserPosition();
      emit(state.copyWith(
        determinePositionStatus: DeterminePositionStatus.success,
        currentPosition: position
      ));
    } catch (e) {
      emit(state.copyWith(
        determinePositionStatus: DeterminePositionStatus.failure,
        errorMessage: "Не удалось установить вашу локацию"
      ));
    }
  }

}