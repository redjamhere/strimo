
import 'package:joyvee/src/utils/utils.dart';
import '../../interfaces/interfaces.dart';

class UserScheduledBroadcast extends Stream {
  UserScheduledBroadcast({
    required int id,
    required String title,
    required String description,
    required String preview
  }) : super(id: id, title: title, description: description, preview: preview);

  factory UserScheduledBroadcast.fromJson(Map<String, dynamic> data) => UserScheduledBroadcast(
      id: data['id'],
      title: data['name'],
      description: data['description'],
      preview: data['preview']);

  @override
  Map<String, dynamic> toJson() => {};

  @override
  String toString() => 'ID: $id TITLE: $title';
}