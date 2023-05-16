import 'package:hive_flutter/hive_flutter.dart';

abstract class User extends HiveObject{
  final int? id;

  final String? email;

  final String? token;

  final bool? isDeleted;

  final String? sysLang;// язык приложения

  final String? deviceName;

  final String? deviceId;

  final String? registrationId;

  final String? idToken;

  final String? socialUID;

  final String? currency;

  final String? streamKey;

  User({
    this.id,
    this.email,
    this.isDeleted = false,
    this.sysLang,
    this.token,
    this.deviceId,
    this.deviceName,
    this.registrationId,
    this.idToken,
    this.socialUID,
    this.currency,
    this.streamKey
  });

   Map<String, dynamic> toJson();
}