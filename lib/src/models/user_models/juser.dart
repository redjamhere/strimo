// описание модели пользователя

import 'package:hive_flutter/hive_flutter.dart';

part 'juser.g.dart';

@HiveType(typeId: 0)
class JUser extends HiveObject{
  JUser({
   this.id,
   this.email,
   this.token,
   this.isDeleted,
   this.sysLang,
   this.deviceName,
   this.deviceId,
   this.registrationId,
   this.idToken,
   this.socialUID,
   this.currency,
   this.streamKey
  });

  @HiveField(0)
  final int? id;

  @HiveField(1)
  final String? email;

  @HiveField(2)
  final String? token;

  @HiveField(3)
  final bool? isDeleted;

  @HiveField(4)
  final String? sysLang;// язык приложения
  
  @HiveField(5)
  final String? deviceName;

  @HiveField(6)
  final String? deviceId;

  @HiveField(7)
  final String? registrationId;

  @HiveField(8)
  final String? idToken;

  @HiveField(9)
  final String? socialUID;

  @HiveField(10)
  final String? currency;

  @HiveField(11)
  final String? streamKey;

  JUser copyWith({
    int? id,
    String? email,
    String? token,
    bool? isDeleted,
    String? sysLang,
    String? registrationId,
    String? deviceName,
    String? deviceId,
    String? idToken,
    String? socialUID,
    String? currency,
    String? streamKey,
  }) {
    return JUser(
      id: id ?? this.id,
      email: email ?? this.email,
      token: token ?? this.token,
      isDeleted: isDeleted ?? this.isDeleted,
      sysLang: sysLang ?? this.sysLang,
      registrationId: registrationId ?? this.registrationId,
      deviceName: deviceName ?? this.deviceName,
      deviceId: deviceId ?? this.deviceId,
      idToken: idToken ?? this.idToken,
      socialUID: socialUID ?? this.socialUID,
      currency: currency?? this.currency,
      streamKey: streamKey?? this.streamKey
    );
  }

  factory JUser.fromJson(Map<String, dynamic> data) => JUser(
      id: data["id"],
      email: data["email"],
      token: data["token"],
      isDeleted: data["is_deleted"],
      sysLang: data["sys_lang"],
      registrationId: data["registration_id"],
      deviceName: data['device_name'],
      deviceId: data['device_id'],
      idToken: data['id_token'],
      socialUID: data['uid'],
      currency: data['currency'],
      streamKey: data['stream_key']
  );

  @override
  Map<String, dynamic> toJson() => {
    "id": id,
    "email": email,
    "token": token,
    "is_deleted": isDeleted,
    "sys_lang": sysLang,
    "registration_id": registrationId,
    "device_name": deviceName,
    "device_id": deviceId,
    "id_token": idToken,
    "uid": socialUID,
    "currency": currency,
    "stream_key": streamKey
  };

  @override
  String toString() => "$deviceId $deviceName";

  static JUser empty = JUser();
}