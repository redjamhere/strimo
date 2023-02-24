part of 'pick_location_cubit.dart';

class PickLocationState extends Equatable {
  const PickLocationState({
    this.userCurrentPosition,
    this.currentPositionStatus = FormzStatus.pure,
    this.pickedPosition = const CameraPosition(target: LatLng(0.0, 0.0)),
    this.pickLocationStatus = FormzStatus.pure,
    this.pickedPlace
  });

  final Position? userCurrentPosition;
  final FormzStatus currentPositionStatus;
  final CameraPosition pickedPosition;
  final FormzStatus pickLocationStatus;
  final PickedPlace? pickedPlace;

  PickLocationState copyWith({
    Position? userCurrentPosition,
    FormzStatus? currentPositionStatus,
    CameraPosition? pickedPosition,
    FormzStatus? pickLocationStatus,
    PickedPlace? pickedPlace
  }) => PickLocationState(
    userCurrentPosition: userCurrentPosition?? this.userCurrentPosition,
    currentPositionStatus: currentPositionStatus?? this.currentPositionStatus,
    pickedPosition: pickedPosition?? this.pickedPosition,
    pickLocationStatus: pickLocationStatus?? this.pickLocationStatus,
    pickedPlace: pickedPlace?? this.pickedPlace
  );

  @override
  List<Object> get props => [currentPositionStatus, pickedPosition, pickLocationStatus];
}