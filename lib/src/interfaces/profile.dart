import 'dart:io';
import 'package:joyvee/src/utils/utils.dart';

import '../models/models.dart';

abstract class Profile {
  final int? profileId;
  final int? userId;
  final String? firstname;
  final String? lastname;
  final String? username;
  final Sex? gender;
  final String? avatar;
  final String? about;
  final int? followers;
  final int? subscribers;
  final double? rating;
  final int? videos;
  final bool? isOnline;
  final String? instagramUrl;
  final String? tiktokUrl;
  final String? youtubeUrl;
  final bool? isStreaming;
  final JStream? stream;
  final File? sourceAvatar;

  const Profile({
    this.profileId,
    this.userId,
    this.firstname,
    this.lastname,
    this.username,
    this.gender,
    this.avatar,
    this.about,
    this.followers,
    this.subscribers,
    this.rating,
    this.videos,
    this.isOnline,
    this.instagramUrl,
    this.tiktokUrl,
    this.youtubeUrl,
    this.isStreaming,
    this.stream,
    this.sourceAvatar
  });

  String genderToString() {
    switch(gender) {
      case Sex.male:
        return 'male';
      case Sex.female:
        return 'female';
      default:
        return 'other';
    }
  }

  Map<String, dynamic> toJson();
}