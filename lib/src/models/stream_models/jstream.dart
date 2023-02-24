// модель стрима
import 'dart:io';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../profile_models/stream_owner.dart';
import '../../utils/utils.dart';
import '../../interfaces/interfaces.dart';

class JStream extends Stream {
  JStream({
    int? id,
    String? title,
    String? description,
    LatLng? position,
    double? cost,
    String? locationName,
    String? preview,
    bool isPrivate = false,
    bool? isLive,
    StreamType? streamType,
    List<String> tags = const [],
    StreamOwner? owner = StreamOwner.empty,
    DateTime? planningDate,
    String? key,
    bool isChatEnabled = true,
    bool isInstagramShared = false,
    bool isYouTubeShared = false,
    bool isTikTokShared = false,
    this.sourcePreview
  }) : super(
      id: id,
      title: title,
      description: description,
      position: position,
      cost: cost,
      locationName: locationName,
      preview: preview,
      isPrivate: isPrivate,
      isLive: isLive,
      streamType: streamType,
      tags: tags,
      owner: owner,
      planningDate: planningDate,
      key: key,
      isChatEnabled: isChatEnabled,
      isInstagramShared: isInstagramShared,
      isYouTubeShared: isYouTubeShared,
      isTikTokShared: isTikTokShared,
  );  

  final File? sourcePreview;

  JStream.standardStream({
    String? title,
    String? description,
    LatLng? position,
    bool isPrivate = false,
    StreamType? streamType,
    double cost = 0,
    List<String> tags = const [],
    DateTime? planningData,
    StreamOwner? owner,
    String? locatinName,
    bool isChatEnabled = true,
    bool isInstagramShared = false,
    bool isYouTubeShared = false,
    bool isTikTokShared = false,
    this.sourcePreview
  }) : super(
    title: title,
    description: description,
    position: position,
    isPrivate: isPrivate,
    streamType: streamType,
    cost: cost,
    tags: tags,
    planningDate: planningData,
    owner: owner,
    locationName: locatinName,
    isChatEnabled: isChatEnabled,
    isInstagramShared: isInstagramShared,
    isYouTubeShared: isYouTubeShared,
    isTikTokShared: isTikTokShared,
  );

  const JStream.emptyConstructor({this.sourcePreview}) : super();

  factory JStream.fromJson(Map<String, dynamic> data) => JStream(
      id: data['id'],
      title: data['name'],
      description: data['description'],
      position: LatLng(data['latitude'], data['longitude']),
      cost: data['cost'],
      locationName: data['location_name'],
      preview: "${ImageAPI.previewURL}${data['preview']}.jpg",
      isPrivate: data['is_private'],
      isLive: data['is_live'],
      planningDate: data['planning_date'] != null ? DateTime.parse(data['planning_date']) : null,
      key: data['stream_id'],
      streamType: JoyveeFunctions.streamTypeFromInt(data['kind_id']),
      tags: data['tags'] != null ? data['tags'].map<String>((e) => e.toString()).toList() : [],
      owner: StreamOwner(userId: data['user_id']));

  Map<String, dynamic> standardStreamToJson() => {
    "name": title,
    "description": description,
    "latitude": position!.latitude,
    "longitude": position!.longitude,
    "user_id": owner!.userId,
    "cost": cost,
    "tags": tags,
    "kind": JoyveeFunctions.streamTypeToInt(streamType!),
    "location_name": locationName,
    "is_private": isPrivate,
    "is_chat_enabled": isChatEnabled,
  };

  
  Map<String, dynamic> toJson() {
    if (streamType == StreamType.standard) {
      return standardStreamToJson();
    } else if (streamType == StreamType.planning) {
      return {};
    } else {
      return {};
    }
  }

  JStream copyWith({
    int? id,
    String? title,
    String? description,
    LatLng? position,
    double? cost,
    String? locationName,
    String? preview,
    bool? isPrivate,
    bool? isLive,
    StreamType? streamType,
    List<String>? tags,
    StreamOwner? owner,
    DateTime? planningDate,
    String? key,
    bool? isChatEnabled,
    bool? isInstagramShared,
    bool? isTikTokShared,
    bool? isYouTubeShared,
    File? sourcePreview,
  }) => JStream(
    id: id?? this.id,
    title: title?? this.title,
    description: description?? this.description,
    position: position?? this.position,
    cost: cost?? this.cost,
    locationName: locationName?? this.locationName,
    preview: preview?? this.preview,
    isPrivate: isPrivate?? this.isPrivate,
    isLive: isLive?? this.isLive,
    streamType: streamType?? this.streamType,
    tags: tags?? this.tags,
    owner: owner?? this.owner,
    planningDate: planningDate?? this.planningDate,
    key: key?? this.key,
    sourcePreview: sourcePreview?? this.sourcePreview,
    isChatEnabled: isChatEnabled?? this.isChatEnabled,
    isInstagramShared: isInstagramShared?? this.isInstagramShared,
    isTikTokShared: isTikTokShared?? this.isTikTokShared,
    isYouTubeShared: isYouTubeShared?? this.isYouTubeShared
  );

  @override
  String toString() => 'ID: $id KEY: $key';

  static const empty = JStream.emptyConstructor();
}