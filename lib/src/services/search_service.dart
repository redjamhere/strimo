import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:joyvee/src/utils/utils.dart';

class SearchService {
  Future<Map<String, dynamic>> fetchUsers(String param, {String? url}) async {
    url = url?? '${UserAPI.searchUsersURL}$param';
    http.Response response = await http.get(Uri.parse(url));
    return json.decode(response.body);
  }

  Future<Map> getNextUsers(String url) async {
    http.Response response = await http.get(Uri.parse(url));
    return json.decode(response.body);
  }

  Future<Map> searchStreams(String param) async {
    http.Response response = await http.get(Uri.parse('${BroadcastAPI.searchStreamsURL}${param}'));
    return json.decode(response.body);
  }
}