part of 'place_picker_bloc.dart';

class PlacePickerEvent extends Equatable {
  const PlacePickerEvent();
  @override
  List<Object> get props => [];
}

class PlacePickerDeterminePosition extends PlacePickerEvent {}

class PlacePickerSubmitted extends PlacePickerEvent {}