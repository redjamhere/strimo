part of 'livemap_bloc.dart';

class LivemapState extends Equatable {
  const LivemapState({
    this.errorMessage,
    this.mapContent = const MapContent(),
    this.contentFilter = const FilterModel(),
    this.mapContentStatus = FormzStatus.pure,
    this.streams = const [],
    this.streamInfoLoadingStatus = FormzStatus.pure,
    this.streamInfo = JStream.empty,
    this.userCurrentPosition
  });

  final String? errorMessage;
  final MapContent mapContent;
  final FilterModel contentFilter;
  final FormzStatus mapContentStatus;
  final FormzStatus streamInfoLoadingStatus;
  final JStream streamInfo;
  final Position? userCurrentPosition;

  //test
  final List<StreamMarker> streams;

  LivemapState copyWith({
    MapContent? mapContent,
    FilterModel? contentFilter,
    String? errorMessage,
    FormzStatus? mapContentStatus,
    List<StreamMarker>? streams,
    FormzStatus? streamInfoLoadingStatus,
    JStream? streamInfo,
    Position? userCurrentPosition
  }) => LivemapState(
    mapContent: mapContent?? this.mapContent,
    contentFilter: contentFilter?? this.contentFilter,
    mapContentStatus: mapContentStatus?? this.mapContentStatus,
    streams: streams?? this.streams,
    streamInfoLoadingStatus: streamInfoLoadingStatus?? this.streamInfoLoadingStatus,
    streamInfo: streamInfo?? this.streamInfo,
    userCurrentPosition: userCurrentPosition?? this.userCurrentPosition
  );

  @override
  List<Object> get props => [mapContent, contentFilter, mapContentStatus, streams, streamInfo, streamInfoLoadingStatus];
}