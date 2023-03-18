// описанией моделей регистрации
import 'dart:io';

import 'package:joyvee/src/interfaces/interfaces.dart';
import 'package:joyvee/src/utils/utils.dart';

class RegistrationProfile extends Profile {
  final File? sourceAvatar;

  const RegistrationProfile({
    String? firstname = "",
    String? lastname = "",
    Sex? gender = Sex.male,
    this.sourceAvatar,
  }) : super(
    firstname: firstname,
    lastname: lastname,
    gender: gender,
  );

  const RegistrationProfile._({this.sourceAvatar}) : super();

  @override
  Map<String, dynamic> toJson() => {
    "firstname": firstname,
    "lastname": lastname,
    "gender": genderToString(),
  };

  RegistrationProfile copyWith({
    String? firstname,
    String? lastname,
    Sex? gender,
    File? sourceAvatar
  }) => RegistrationProfile(
    firstname: firstname?? this.firstname,
    lastname: lastname?? this.lastname,
    gender: gender?? this.gender,
    sourceAvatar: sourceAvatar?? this.sourceAvatar
  );

  @override
  String toString() => "$firstname $lastname";

  static const empty = RegistrationProfile._();

  @override
  List<Object> get props => [];
}