part of 'livemap_bloc.dart';

abstract class LivemapEvent extends Equatable {
  const LivemapEvent();

  @override
  List<Object> get props => [];
}

class LivemapFetchMarkersRequested extends LivemapEvent {}

class LivemapFetchMarkers extends LivemapEvent {}

class LivemapMarkerTapped extends LivemapEvent {
  const LivemapMarkerTapped(this.id);
  final int id;
}

class LivemapGetUserCurrentPositionRequested extends LivemapEvent {}