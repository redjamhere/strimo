import 'package:geolocator/geolocator.dart';

import '../services/services.dart';
import '../models/models.dart';

class UserRepository {

  final UserService _api = UserService();

  Future<String> getFirebaseIdToken() async {
    return await _api.getFirebaseIdToken();
  }

  Future<String?> getRegistrationId() async {
    return await _api.getRegistrationId();
  }

  String getUserLocalLanguage() {
    return _api.getUserLocalLanguage();
  }

  Future<DeviceInfo> getDeviceInfo() async {
    return await _api.getDeviceInfo();
  }

  Future<Position> getCurrentPosition() async {
    return await _api.getCurrentPosition();
  }

}