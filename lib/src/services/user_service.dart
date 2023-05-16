import 'dart:convert';
import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:geolocator/geolocator.dart';
import 'package:joyvee/src/models/models.dart';
import 'package:joyvee/src/utils/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart' as http;

class UserService {

  Future<String> getFirebaseIdToken() async {
    return await FirebaseAuth.instance.currentUser!.getIdToken();
  }

  Future<String?> getRegistrationId() async {
    return await FirebaseMessaging.instance.getToken();
  }

  String getUserLocalLanguage()  {
    int index = Platform.localeName.indexOf('_');
    return 'ru';
    return Platform.localeName.substring(0, index);
  }

  Future<DeviceInfo> getDeviceInfo() async {
    late String deviceId;
    late String deviceName;
    if (Platform.isAndroid) {
      AndroidDeviceInfo deviceInfo = await DeviceInfoPlugin().androidInfo;
      deviceId = deviceInfo.androidId!;
      deviceName = "ANDROID";
    } else if (Platform.isIOS || Platform.isMacOS) {
      IosDeviceInfo deviceInfo = await DeviceInfoPlugin().iosInfo;
      deviceId = deviceInfo.identifierForVendor!;
      deviceName = "IOS";
    }

    return DeviceInfo(deviceId, deviceName);
  }

  Future<Position> getCurrentPosition() async {
    return await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  }

}