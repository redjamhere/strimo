// описание модели пользователя

import 'package:joyvee/src/interfaces/interfaces.dart';

class JUser extends User {
  JUser({
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
    String? streamKey
  }) : super(
    id: id,
    email: email,
    token: token,
    isDeleted: isDeleted,
    sysLang: sysLang,
    deviceName: deviceName,
    deviceId: deviceId,
    registrationId: registrationId,
    idToken: idToken,
    socialUID: socialUID,
    currency: currency,
    streamKey: streamKey
  );

  const JUser.emptyConst() : super();

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

  static const empty = JUser.emptyConst();
}