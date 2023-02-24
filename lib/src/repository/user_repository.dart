import 'package:geolocator/geolocator.dart';

import '../services/services.dart';
import '../models/models.dart';

class UserRepository {
  JUser _user = JUser.empty;

  JUser get user => _user;

  final UserService _api = UserService();

  Future<String> getFirebaseIdToken() async {
    return await _api.getFirebaseIdToken();
  }

  Future<String?> getRegistrationId() async {
    return await _api.getRegistrationId();
  }

  Future saveUserToLocalStorage(JUser u) async {
    _user = u;
    await _api.saveUserToLocalStorage(u);
  }

  Future<JUser> getUserFromLocalStorage() async {
    _user = await _api.getUserFromLocalStorage();
    return _user;
  }

  String getUserLocalLanguage() {
    return _api.getUserLocalLanguage();
  }

  Future<DeviceInfo> getDeviceInfo() async {
    return await _api.getDeviceInfo();
  }

  Future removeUserFromLocalStorage() async {
    await _api.removeUserFromLocalStorage();
  }

  Future<Position> getCurrentPosition() async {
    return await _api.getCurrentPosition();
  }

}