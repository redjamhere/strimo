part of 'place_picker_bloc.dart';

enum DeterminePositionStatus { during, success, failure, init }

class PlacePickerState extends Equatable {
  const PlacePickerState({
    this.determinePositionStatus = DeterminePositionStatus.init,
    this.pickedPlace = const PickedPlaceFormz.pure(),
    this.pickedPlaceStatus = FormzStatus.pure,
    this.currentPosition,
    this.errorMessage
  });

  final PickedPlaceFormz pickedPlace;
  final FormzStatus pickedPlaceStatus;
  
  final Position? currentPosition;
  final DeterminePositionStatus determinePositionStatus;

  final String? errorMessage;

  PlacePickerState copyWith({
    PickedPlaceFormz? pickedPlace,
    DeterminePositionStatus? determinePositionStatus,
    FormzStatus? pickedPlaceStatus,
    String? errorMessage,
    Position? currentPosition,
  }) => PlacePickerState(
    pickedPlace: pickedPlace?? this.pickedPlace,
    determinePositionStatus: determinePositionStatus?? this.determinePositionStatus,
    pickedPlaceStatus: pickedPlaceStatus?? this.pickedPlaceStatus,
    errorMessage: errorMessage?? this.errorMessage,
    currentPosition: currentPosition
  );

  @override
  List<Object> get props => [pickedPlace, determinePositionStatus, pickedPlaceStatus];
}