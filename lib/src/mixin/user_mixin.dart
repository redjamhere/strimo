import 'package:joyvee/src/services/services.dart';

mixin UserMixin {
  final UserService _service = UserService();
  Future<String?> getToken() async {
    var u = await _service.getUserFromLocalStorage();
    return u.token;
  }

  Future<int?> getId() async {
    var u = await _service.getUserFromLocalStorage();
    return u.id;
  }
}