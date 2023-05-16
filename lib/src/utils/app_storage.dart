import 'package:hive_flutter/hive_flutter.dart';
import 'package:joyvee/src/interfaces/interfaces.dart';
import 'package:joyvee/src/models/user_models/juser.dart';

class AppStorage {

  static late final Box storage;

  Future<void> initStorage() async {
    await Hive.initFlutter();
    Hive.registerAdapter(JUserAdapter());
    storage = await Hive.openBox<JUser>('app_storage');
  }
  
}