import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';
import 'package:google_place/google_place.dart';
import 'package:joyvee/src/utils/functions.dart';
import 'package:joyvee/src/utils/urls.dart';

//utils
import '../utils/config.dart';

//models
import '../models/models.dart';

class MapService {
  var googlePlace = GooglePlace(ProjectConfig.GOOGLE_MAP_API_KEY);


  Future<Position> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }
    
    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately. 
      return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.');
    } 

    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }

  Future<List<SearchResult>?> getPlacesBySearch(String q, String lang) async {
    var result = await googlePlace.search.getTextSearch(q, language: lang);
    if (result != null) {
      return result.results;
    } else {
      return null;
    }
  }

  Future<MapContent> getMarkersForMap(JUser user, FilterModel filter) async {
    http.Response response = await http.post(Uri.parse('${BroadcastAPI.allBroadcastsURL}'),
      headers: <String, String> {
        'Content-Type': 'application/json; charset=utf-8',
        'Authorization': 'Bearer ${user.token}'
      },
      body: json.encode(filter.toJson())
    );

    Map<String, dynamic> result = json.decode(response.body);
    HttpError status = JoyveeFunctions.generateHttpException(result);
    if (status.result) {
      List streams = result['streams'];
      List active = result['active'];
      List rStreams = result['requested'];

      List<StreamMarker> p = streams.map((e) => StreamMarker.fromJson(e)).toList();
      List<ActiveUserModel> a = active.map((e) => ActiveUserModel.fromJson(e)).toList();
      List<StreamMarker> rp = rStreams.map((e) => StreamMarker.fromJson(e)).toList();
      return MapContent(streams: p, actives: a, rStreams: rp);
    } else {
      throw status;
    }

  }
}