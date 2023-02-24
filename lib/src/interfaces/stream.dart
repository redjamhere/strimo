import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../models/models.dart';
import '../utils/enums.dart';

abstract class Stream {
  final int? id;
  final String? title;
  final String? description;
  final LatLng? position;
  final double? cost;
  final String? locationName;
  final String? preview;
  final bool isPrivate;
  final bool? isLive;
  final DateTime? planningDate;
  final String? key;
  final StreamType? streamType;
  final List<String> tags;
  final StreamOwner? owner;
  final bool isChatEnabled;
  final bool isInstagramShared;
  final bool isYouTubeShared;
  final bool isTikTokShared;
  final String? filename;

  const Stream({
    this.id,
    this.title,
    this.description,
    this.position,
    this.cost,
    this.locationName,
    this.preview,
    this.isPrivate = false,
    this.isLive,
    this.planningDate,
    this.key,
    this.streamType,
    this.tags = const [],
    this.owner,
    this.isChatEnabled = true,
    this.isInstagramShared = false,
    this.isTikTokShared = false,
    this.isYouTubeShared = false,
    this.filename
  });

  Map<String, dynamic> toJson();
}
