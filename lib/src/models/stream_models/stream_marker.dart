import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:joyvee/src/utils/utils.dart';

import '../../interfaces/interfaces.dart';


class StreamMarker extends Stream implements Equatable {
  File? loadedPreview;

  StreamMarker({
    required int id,
    required double cost,
    required String preview,
    required bool isLive,
    required LatLng position,
    DateTime? planningDate,
    required bool isPrivate,
    this.loadedPreview
  }) : super (
      id: id,
      cost: cost,
      position: position,
      preview: preview,
      isLive: isLive,
      planningDate: planningDate,
      isPrivate: isPrivate,
  );

  StreamMarker.empty() : super();

  factory StreamMarker.fromJson(Map<String, dynamic> data) => StreamMarker(
    id: data['id'],
    cost: data['cost'],
    position: LatLng(data['latitude'], data['longitude']),
    preview: '${ImageAPI.previewURL}${data['preview']}.jpg',
    isLive: data['is_live'],
    planningDate: data['planning_date'] != null ? DateTime.parse(data['planning_date']) : null,
    isPrivate: data['is_private']
  );

  @override
  List<Object> get props => [id!];

  @override
  bool? get stringify => null;

  @override
  Map<String, dynamic> toJson() => {};
}