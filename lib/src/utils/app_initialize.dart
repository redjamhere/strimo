import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
class AppInitialize {
  AppInitialize.init() {
    initFirebase();
  }
  void initFirebase() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }
}
