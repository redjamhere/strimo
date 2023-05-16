// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'juser.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class JUserAdapter extends TypeAdapter<JUser> {
  @override
  final int typeId = 0;

  @override
  JUser read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return JUser(
      id: fields[0] as int?,
      email: fields[1] as String?,
      token: fields[2] as String?,
      isDeleted: fields[3] as bool?,
      sysLang: fields[4] as String?,
      deviceName: fields[5] as String?,
      deviceId: fields[6] as String?,
      registrationId: fields[7] as String?,
      idToken: fields[8] as String?,
      socialUID: fields[9] as String?,
      currency: fields[10] as String?,
      streamKey: fields[11] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, JUser obj) {
    writer
      ..writeByte(12)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.email)
      ..writeByte(2)
      ..write(obj.token)
      ..writeByte(3)
      ..write(obj.isDeleted)
      ..writeByte(4)
      ..write(obj.sysLang)
      ..writeByte(5)
      ..write(obj.deviceName)
      ..writeByte(6)
      ..write(obj.deviceId)
      ..writeByte(7)
      ..write(obj.registrationId)
      ..writeByte(8)
      ..write(obj.idToken)
      ..writeByte(9)
      ..write(obj.socialUID)
      ..writeByte(10)
      ..write(obj.currency)
      ..writeByte(11)
      ..write(obj.streamKey);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is JUserAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
