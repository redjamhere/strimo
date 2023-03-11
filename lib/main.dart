import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:joyvee/src/repository/respository.dart';

import './src/utils/utils.dart';

import './src/app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  AppInitialize.init();

  runApp(Phoenix(child: JoyveeApp(
    authorizationRepository: AuthorizationRepository(),
    userRepository: UserRepository(),
    profileRepository: ProfileRepository(),
    streamRepository: StreamRepository(),
    mapRepository: MapRepository(),
    streamChatRepository: StreamChatRepository(),
    iosStreamRepository: IosStreamRepository(),
    messengerRepository: MessengerRepository(),
    searchRepository: SearchRepository(),
  )));
  // print(kMessages[DateTime(2023, 3, 1, 14, 18)]);
}