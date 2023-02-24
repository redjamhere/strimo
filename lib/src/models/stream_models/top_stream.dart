//описание модели для топовых стримов
import 'package:joyvee/src/models/models.dart';
import 'package:joyvee/src/utils/utils.dart';

import '../../interfaces/interfaces.dart';

class TopStream extends Stream {
  TopStream({
    required int id,
    required double cost,
    required String title,
    required String preview,
    required bool isLive,
    required String key,
    required StreamOwner owner,
    required bool isPrivate,
    DateTime? planningDate,
  }) : super(
      id: id,
      cost: cost,
      title: title,
      preview: preview,
      isLive: isLive,
      key: key,
      owner: owner,
      isPrivate: isPrivate,
      planningDate: planningDate);

  factory TopStream.fromJson(Map<String, dynamic> data) => TopStream(
    id: data['id'],
    title: data['name'],
    cost: data['cost'],
    preview: data['preview'],
    isLive: data['is_live'],
    key: data['stream_id'],
    isPrivate: data['is_private'],
    owner: StreamOwner.fromJson(data['owner']),
    planningDate: data['planning_date'] != null ? DateTime.parse(data['planning_date']) : null,
  );

  @override
  Map<String, dynamic> toJson() => {};

  @override
  String toString() => 'ID: $id KEY: $title';
}