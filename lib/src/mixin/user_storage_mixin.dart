import 'package:joyvee/src/utils/utils.dart';
import 'package:joyvee/src/models/models.dart';

mixin UserStorageMixin {
  final storage = AppStorage.storage;

  Future<void> addUserToStorage(JUser user) async {
    await storage.put('user', user);
  }

  Future<void> saveUserToStorage(JUser user) async {
    await user.save();
  }

  JUser? getUserFromStorage() {
    try {
      return AppStorage.storage.get('user');
    } catch (e) {
      return null;
    }
  }

  void removeUserFromStorage() {
    AppStorage.storage.delete('user');
  }

}