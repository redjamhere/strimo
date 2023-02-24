import 'dart:convert';

import 'package:http/http.dart' as http;
// ignore: depend_on_referenced_packages
import 'package:http_parser/http_parser.dart';

//models
import '../models/models.dart';

//utils
import '../utils/utils.dart';

class ProfileService {
  Future sendProfileData(RegistrationProfile p, JUser user) async {
    Map<String, dynamic> data = p.toJson();
    data['id'] = user.id;
    data['sys_lang'] = user.sysLang;
    var request = http.MultipartRequest("POST", Uri.parse(UserAPI.profileURL));
    request.headers['Authorization'] = 'Bearer ${user.token}';
    request.fields['data'] = json.encode(data);
    if (p.sourceAvatar != null) {
      request.files.add(http.MultipartFile.fromBytes(
          'file', await p.sourceAvatar!.readAsBytes(),
          filename: 'file',
          contentType: MediaType('image', 'jpeg')
      ));
    }
    http.Response response = await http.Response.fromStream(await request.send());
    json.decode(response.body);
    HttpError status = JoyveeFunctions.generateExceptionByHttpCode(response.statusCode);
    if (!status.result) {
      throw status;
    }
  }
  
  Future updateProfileData(JProfile p, JUser user) async {
    Map<String, dynamic> data = p.toJson();
    var request = http.MultipartRequest("PUT", Uri.parse('${UserAPI.profileURL}${user.id}'));
    request.fields['data'] = json.encode(data);
    request.headers['Authorization'] = 'Bearer ${user.token}';
    request.headers['Content-Type'] = 'application/json; charset=utf-8';
    if(p.sourceAvatar != null) {
      request.files.add(
        http.MultipartFile.fromBytes(
          'file', 
          await p.sourceAvatar!.readAsBytes(),
          filename: 'file',
          contentType: MediaType('image', 'jpeg')
      ));
    }
    http.Response response = await http.Response.fromStream(await request.send());
    json.decode(response.body);
    HttpError status = JoyveeFunctions.generateExceptionByHttpCode(response.statusCode);
    if (!status.result) {
      throw status;
    }
  }

  Future<JProfile> getProfile(JUser user ) async {
    http.Response response = await http.get(Uri.parse('${UserAPI.profileURL}${user.id}'),
      headers: <String, String> {
        'Content-Type': 'application/json; charset=utf-8',
        'Authorization': 'Bearer ${user.token}'
      }
    );
    
    Map<String, dynamic> result = json.decode(utf8.decode(response.bodyBytes));
    HttpError status = JoyveeFunctions.generateHttpException(result);
    if (status.result) {
      return JProfile.fromJson(result);
    } else {
      throw status;
    }
  }

  Future<List<UserLastStream>> getUserLastStreams(JUser user) async {
    http.Response response = await http.get(Uri.parse('${BroadcastAPI.userBroadcastsURL}${user.id}'),
      headers: <String, String> {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ${user.token}'
      }
    );
    Map<String, dynamic> result = json.decode(response.body);
    HttpError status = JoyveeFunctions.generateHttpException(result);
    if (status.result) {
      List streams = json.decode(result['data']);
      return streams.map((s) => UserLastStream.fromJson(s)).toList();
    } else {
      throw status;
    }
  }
}