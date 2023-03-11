// описания модели общедоступной информации о пользователе
import 'dart:io';

import 'package:joyvee/src/models/stream_models/jstream.dart';
import 'package:joyvee/src/utils/utils.dart';

import '../../interfaces/interfaces.dart';

class JProfile extends Profile {
  
  const JProfile({
    int? profileId,
    int? userId,
    String? firstname,
    String? lastname,
    String? username,
    Sex? gender,
    String? avatar,
    String? about,
    int? followers,
    int? subscribers,
    double? rating,
    int? videos,
    bool? isOnline,
    String? instagramUrl,
    String? tiktokUrl,
    String? youtubeUrl,
    bool? isStreaming,
    JStream? stream,
    File? sourceAvatar,
  }) : super(
    profileId: profileId,
    userId: userId,
    firstname: firstname,
    lastname: lastname,
    username: username,
    gender: gender,
    avatar: avatar,
    about: about,
    followers: followers,
    subscribers: subscribers,
    rating: rating,
    videos: videos,
    isOnline: isOnline,
    instagramUrl: instagramUrl,
    tiktokUrl: tiktokUrl,
    youtubeUrl: youtubeUrl,
    isStreaming: isStreaming,
    stream: stream,
    sourceAvatar: sourceAvatar
  );

  factory JProfile.fromJson(Map<String, dynamic> data) => JProfile(
    profileId: data['data']['id'],
    userId: data['data']['user_id'],
    firstname: data['data']['firstname'],
    lastname: data['data']['lastname'],
    username: data['data']['tagname'],
    gender: parseStringToSex(data['data']['gender']),
    avatar: "${ImageAPI.avatarsURL}${data['data']['avatar']}.jpg",
    about: data['data']['about'],
    followers: data['data']['followers'],
    subscribers: data['data']['subcribed'],
    rating: data['data']['rating'],
    videos: data['data']['videos'],
    isOnline: data['data']['is_online'],
    instagramUrl: data['data']['instagram_url'],
    tiktokUrl: data['data']['tiktok_url'],
    youtubeUrl: data['data']['youtube_url'],
    isStreaming: data['is_streaming'],
    stream: data['stream'] != null ? JStream.fromJson(data['stream']) : null
  );
  factory JProfile.fromJsonOnSearch(Map<String, dynamic> data) => JProfile(
    profileId: data['id'],
    userId: data['user_id'],
    firstname: data['firstname'],
    lastname: data['lastname'],
    username: data['tagname'],
    gender: parseStringToSex(data['gender']),
    avatar: "${ImageAPI.avatarsURL}${data['avatar']}.jpg",
    about: data['about'],
    followers: data['followers'],
    subscribers: data['subcribed'],
    rating: data['rating'],
    videos: data['videos'],
    isOnline: data['is_online'],
    instagramUrl: data['instagram_url'],
    tiktokUrl: data['tiktok_url'],
    youtubeUrl: data['youtube_url'],
  );

  JProfile copyWith({
    String? firstname,
    String? lastname,
    String? username,
    Sex? gender,
    String? avatar,
    String? about,
    String? instagramUrl,
    String? tiktokUrl,
    String? youtubeUrl,
    File? sourceAvatar,
  }) => JProfile(
    profileId: profileId,
    userId: userId,
    firstname: firstname?? this.firstname,
    lastname: lastname?? this.lastname,
    username: username?? this.username,
    gender: gender?? this.gender,
    avatar: avatar?? this.avatar,
    about: about?? this.about,
    followers: followers,
    subscribers: subscribers,
    rating: rating,
    isOnline: isOnline,
    isStreaming: isStreaming,
    stream: stream,
    instagramUrl: instagramUrl?? this.instagramUrl,
    tiktokUrl: tiktokUrl?? this.tiktokUrl,
    youtubeUrl: youtubeUrl?? this.youtubeUrl,
    sourceAvatar: sourceAvatar?? this.sourceAvatar
  );

  const JProfile.emptyConst() : super();

  @override
  Map<String, dynamic> toJson() => {
    'user_id': userId,
    'firstname': firstname,
    'lastname': lastname,
    'gender': genderToString(),
    'tagname': username,
    'about': about,
    'instagram_url': instagramUrl,
    'tiktok_url': tiktokUrl,
    'youtube_url': youtubeUrl,
  };

  @override
  String toString() => "ID: $userId USERNAME: $username";
  
  static Sex parseStringToSex(String gender) {
    switch(gender) {
      case "male":
        return Sex.male;
      case "female":
        return Sex.female;
      default:
        return Sex.other;
    }
  }

  static const empty = JProfile.emptyConst();
}