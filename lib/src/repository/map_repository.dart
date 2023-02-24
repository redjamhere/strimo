// отвечает за работы с данными связанаыми с геолокацией и картами
import 'package:google_place/google_place.dart';
import 'package:joyvee/src/models/models.dart';
import 'package:joyvee/src/utils/utils.dart';

import '../services/services.dart';
import 'package:geolocator/geolocator.dart';

class MapRepository {
  final MapService _api = MapService();
  final StreamService _broadcastApi = StreamService();

  Future<Position> getUserPosition() async {
    return await _api.determinePosition();
  }

  Future<List<SearchResult>?> getPlacesBySearch(String q, String lang) async {
    return await _api.getPlacesBySearch(q, lang);
  } 

  Future<MapContent> getMarkersForMap(JUser user, FilterModel filter) async {
    return await _api.getMarkersForMap(user, filter);
  }

  Future<JStream> getStreamInfo(JUser user, int id) async {
    return await _broadcastApi.getStreamInfo(user, id);
  }
}