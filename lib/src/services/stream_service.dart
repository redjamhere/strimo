import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:joyvee/src/models/models.dart';
import 'package:joyvee/src/utils/utils.dart';
import 'package:http_parser/http_parser.dart';

class StreamService {
  Future<JStream> createBroadcast(JStream stream, String token) async {
    var request = http.MultipartRequest("POST", Uri.parse(BroadcastAPI.launchBroadcastURL));
    request.fields["data"] = json.encode(stream.toJson());
    request.headers['Authorization'] = 'Bearer $token';
    if (stream.sourcePreview != null) {
      request.files.add(
        http.MultipartFile.fromBytes(
          'preview', await stream.sourcePreview!.readAsBytes(),
          filename: 'file',
          contentType: MediaType('image', 'jpeg')
        ));        
    }
    http.Response response = await http.Response.fromStream(await request.send());
    Map<String, dynamic> result = json.decode(response.body);
    HttpError status = JoyveeFunctions.generateHttpException(result);  
    if (status.result) {
      return JStream.fromJson(json.decode(response.body)['stream']);
    } else {
      throw status;
    }
  }
  
  Future<JStream> getStreamInfo(JUser user, int id) async {
    http.Response response = await http.post(Uri.parse('${BroadcastAPI.broadcastInfoURL}$id'),
      headers: <String, String> {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization' : 'Bearer ${user.token}'
      },
    );  
    Map<String, dynamic> result = json.decode(response.body);
    HttpError status = JoyveeFunctions.generateHttpException(result);
    if (status.result) {
      return JStream.fromJson(result['streams']);
    } else {
      throw status;
    }
  }

}