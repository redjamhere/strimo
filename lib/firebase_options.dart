// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyASprSzA8vcaWOmryWgWQ45rI9OhZL1W3s',
    appId: '1:844536392674:web:18e9cc8419afe93cdbe7bb',
    messagingSenderId: '844536392674',
    projectId: 'joyvee-ad822',
    authDomain: 'joyvee-ad822.firebaseapp.com',
    storageBucket: 'joyvee-ad822.appspot.com',
    measurementId: 'G-NDLGSGTDTK',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAAI7brtk39r4yLPPj21Sy5tAc8Md-8Jts',
    appId: '1:844536392674:android:b1e3991d1524c97ddbe7bb',
    messagingSenderId: '844536392674',
    projectId: 'joyvee-ad822',
    storageBucket: 'joyvee-ad822.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyByEisxskM1frU85w4CCNCB0d3JArjwcBo',
    appId: '1:844536392674:ios:8b02b96b99f1eb84dbe7bb',
    messagingSenderId: '844536392674',
    projectId: 'joyvee-ad822',
    storageBucket: 'joyvee-ad822.appspot.com',
    androidClientId: '844536392674-ffj31tm2654t2llpa0hc7u03ltndlpgf.apps.googleusercontent.com',
    iosClientId: '844536392674-eor3es9eaf5qiva9me57l6nhj6tevbgt.apps.googleusercontent.com',
    iosBundleId: 'com.joyvee.streamapp',
  );
}
