import 'dart:convert';

import 'package:http/http.dart' as http;
// ignore: depend_on_referenced_packages
import 'package:http_parser/http_parser.dart';
import 'package:joyvee/src/interfaces/social_auth_interface.dart';
import 'package:joyvee/src/models/models.dart';
import 'package:joyvee/src/utils/utils.dart';

class AuthorizationService extends SocialAuthInterface {
  Future<bool> checkToken(JUser u) async {
    http.Response response = await http.get(
      Uri.parse('${UserAPI.checkTokenURL}${u.id}'),
      headers: <String, String> {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ${u.token}'
      }
    );
    HttpError status = JoyveeFunctions.generateExceptionByHttpCode(response.statusCode);
    if(status.result) {
      return true;
    } else if (response.statusCode == 401 || response.statusCode == 404) {
      return false;
    } else {
      throw status;
    }
  }
  
  Future<JUser> logIn(AuthorizationCredentials c) async {
    http.Response response = await http.post(Uri.parse(UserAPI.userURL),
      headers: <String, String> {
        'Content-Type': 'application/json; charset=UTF-8'
      },
      body: json.encode(c.toJson()),
    );
    HttpError status = JoyveeFunctions.generateExceptionByHttpCode(response.statusCode);
    if (status.result) {
      return JUser.fromJson(json.decode(response.body)['data']);
    } else if (response.statusCode == 401) {
      var usr = JUser.fromJson(json.decode(response.body)['data']);
      return usr.copyWith(isDeleted: true);
    } else {
      throw status;
    }
  }

  Future<JUser> loginWithSocial(String idToken) async {
    http.Response response = await http.post(Uri.parse(UserAPI.authWithSocialURL),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $idToken'
      },
    );
    HttpError status = JoyveeFunctions.generateExceptionByHttpCode(response.statusCode);
      if (status.result) {
        return JUser.fromJson(json.decode(response.body)['data']);
      } else {
        throw status;
      }
  }

  Future<int> sendCredentials(AuthorizationCredentials c, {String? currency}) async {
    Map<String, dynamic> data = c.toJson();
    data.addAll({"currency" : currency});

    http.Response response = await http.post(Uri.parse(UserAPI.registerURL),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: json.encode(data)
    );

    HttpError status = JoyveeFunctions.generateExceptionByHttpCode(response.statusCode);
    json.decode(response.body);
    if (status.result) {
      Map<String, dynamic> data = json.decode(response.body);
      return data['id'];
    } else {
      throw status;
    }
  }

  Future<JUser> sendVerificationCode(JUser u, String code) async {
    Map<String, dynamic> data = u.toJson();
    data['code'] = code;
    
    http.Response response = await http.post(Uri.parse(UserAPI.activateURL),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: json.encode(data)
    );
    HttpError status = JoyveeFunctions.generateExceptionByHttpCode(response.statusCode);
    json.decode(response.body);
    if (status.result) {
      Map<String, dynamic> data = json.decode(response.body);
      return JUser.fromJson(data['data']);
    } else if (response.statusCode == 400){
      throw "Invalid verification code";
    } else {
      throw status;
    }
  }
  
 Future<JUser> sendProfileWithSocialAuth(RegistrationProfile p, JUser user) async {
    var request = http.MultipartRequest("POST", Uri.parse(UserAPI.registerURL));
    request.headers['Authorization'] = 'Bearer ${user.idToken}';
    request.fields['data_profile'] = json.encode(p.toJson());
    request.fields['device_id'] = user.deviceId!;
    request.fields['registration_id'] = user.registrationId!;
    request.fields['device_name'] = user.deviceName!;
    request.fields['currency'] = user.currency!;
    if (p.sourceAvatar != null) {
      request.files.add(http.MultipartFile.fromBytes(
          'file', await p.sourceAvatar!.readAsBytes(),
          filename: 'file',
          contentType: MediaType('image', 'jpeg')
      ));
    }

    http.Response res = await http.Response.fromStream(await request.send());
    HttpError status = JoyveeFunctions.generateExceptionByHttpCode(res.statusCode);
    json.decode(res.body);
    if (status.result) {
      return JUser.fromJson(json.decode(res.body)['data']);
    } else {
      throw status;
    }
  }

}