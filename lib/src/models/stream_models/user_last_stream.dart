// модель последней трансляции пользователя
import 'package:joyvee/src/utils/urls.dart';

import '../../interfaces/interfaces.dart';

class UserLastStream extends Stream {
  UserLastStream({
    int? id,
    String? title,
    String? filename,
    String? preview,
  }) : super(
    id: id,
    title: title,
    filename: filename,
    preview: preview
  );

  factory UserLastStream.fromJson(Map<String, dynamic> data) => UserLastStream(
    id: data['pk'],
    title: data['name'],
    filename: data['filename'],
    preview: "${ImageAPI.previewURL}${data['preview']}.jpg",
  );

  @override 
  Map<String, dynamic> toJson() => {};
}