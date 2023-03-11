import 'package:joyvee/src/models/profile_models/profile.dart';
import 'package:joyvee/src/models/models.dart';
import 'package:joyvee/src/services/services.dart';

class SearchRepository {
  SearchService _api = SearchService();

  Future<UserSearch> fetchUsers(String param, {String? url}) async {
    Map<String, dynamic> result = await _api.fetchUsers(param, url: url);
    List<JProfile> profiles = [];
    for(Map<String, dynamic> u in result['results']) {
      profiles.add(JProfile.fromJsonOnSearch(u));
    }
    result['results'] = profiles;
    return UserSearch.fromJson(result);
  }
}