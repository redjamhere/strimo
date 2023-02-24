// модель описывает все сущности на карте
import 'package:equatable/equatable.dart';
import 'package:joyvee/src/models/models.dart';


class MapContent extends Equatable{

  const MapContent({
    this.streams = const [],
    this.rStreams = const [],
    this.actives = const []
  });

  // обычные трансляции
  final List<StreamMarker> streams;
  // Запрошенные трансляции
  final List<StreamMarker> rStreams;
  // Активные пользователи
  final List<ActiveUserModel> actives;

  MapContent copyWith({
    List<StreamMarker>? streams,
    List<StreamMarker>? rStreams,
    List<ActiveUserModel>? actives
  }) => MapContent(
    streams: streams?? this.streams,
    rStreams: rStreams?? this.rStreams,
    actives: actives?? this.actives
  );

  List<Object> get props => [streams, rStreams, actives];
}