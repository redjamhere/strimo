import 'config.dart';

class UserAPI {
  static const String userURL = '${ProjectConfig.REST}/api/user/users/';
  static const String profileURL =
      '${ProjectConfig.REST}/api/user/user-profile/';
  static const String followURL = '${ProjectConfig.REST}/api/user/user-follow/';
  static const String followCheckURL =
      '${ProjectConfig.REST}/api/user/user-follow-check/';
  static const String checkTokenURL =
      '${ProjectConfig.REST}/api/user/check-token/';
  static const String registerURL =
      '${ProjectConfig.REST}/api/user/user-regist/';
  static const String activateURL =
      '${ProjectConfig.REST}/api/user/user-activate/';
  static const String authWithSocialURL =
      '${ProjectConfig.REST}/api/user/user-auth-social/';
  static const String followersSubscribersURL =
      '${ProjectConfig.REST}/api/user/user-followers/';
  static const String checkStripeAccountURL =
      '${ProjectConfig.REST}/api/user/check-stripe-account/';
  static const String createStripeAccountURL =
      '${ProjectConfig.REST}/api/user/user-stripe-activate/';
  static const String searchUsersURL =
      '${ProjectConfig.REST}/api/user/user-profile-search/?search=';
  static const String restoreAccount =
      '${ProjectConfig.REST}/api/user/user-restore/';
}

class BroadcastAPI {
  static const String userBroadcastsURL =
      '${ProjectConfig.REST}/api/stream/last_streams/';
  static const String allBroadcastsURL =
      '${ProjectConfig.REST}/api/stream/stream_all/';
  static const String broadcastInfoURL =
      '${ProjectConfig.REST}/api/stream/stream_info/';
  static const String launchBroadcastURL =
      '${ProjectConfig.REST}/api/stream/stream_launch/';
  static const String broadcastPaymentURL =
      '${ProjectConfig.REST}/api/stream/stream_pay/';
  static const String broadcastPaymentAcceptURL =
      '${ProjectConfig.REST}/api/stream/stream_pay_accept/';
  static const String userPlannedBroadcastsURL =
      '${ProjectConfig.REST}/api/stream/planning_streams/';
  static const String userRequestedBroadcastURL =
      '${ProjectConfig.REST}/api/stream/request_streams/';
  static const String broadcastLiveDown =
      '${ProjectConfig.REST}/api/stream/stream_live_done/';
  static const String checkPaymentURL =
      '${ProjectConfig.REST}/api/stream/stream_check_pay/';
  static const String searchStreamsURL =
      '${ProjectConfig.REST}/api/stream/stream_search/?search=';
  static const String broadcastFeedURL =
      '${ProjectConfig.REST}/api/stream/subscribers_stream/';
}

class LiveAPI {
  static const String rtmpURL = '${ProjectConfig.RTMP}/live_redirect/';
  static const String hlsURL = '${ProjectConfig.REST}/hls/';
  static const String streamLiveChatURL = '${ProjectConfig.WS}/ws/';
}

class ImageAPI {
  static const String avatarsURL = '${ProjectConfig.REST}/avatars/';
  static const String previewURL = '${ProjectConfig.REST}/preview/';
}

class VideoAPI {
  static const String videoURL = '${ProjectConfig.REST}/hls';
}

class MessengerAPI {
  static const String chatsURL = '${ProjectConfig.REST}/back/messenger/chats/';
  static const String messagesURL =
      '${ProjectConfig.REST}/api/messenger/get_messages/';
  static const String deleteChatURL =
      '${ProjectConfig.REST}/api/messenger/delete_chat/';
}

class RecommendationAPI {
  static const String topBroadcastsURL =
      '${ProjectConfig.REST}/api/recommendation/top_streams/';
  static const String topUsersURL =
      '${ProjectConfig.REST}/api/recommendation/top_users';
}
