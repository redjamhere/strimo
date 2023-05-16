
//services
import 'package:joyvee/src/interfaces/repository_interface.dart';
import 'package:joyvee/src/mixin/mixins.dart';

import '../services/services.dart';
//models
import '../models/models.dart';

class ProfileRepository with UserStorageMixin {
  JProfile _profile = JProfile.empty;

  JProfile get profile => _profile;

  final ProfileService _profileApi = ProfileService();

  // Отправка инфорации о профиле при регистрации
  Future sendProfileData(RegistrationProfile p, JUser user) async {
    await _profileApi.sendProfileData(p, user);
  }

  // Обновление информации о профиле 
  Future updateProfileData(JProfile p, JUser user) async {
    await _profileApi.updateProfileData(p, user);
  } 

  // Получение профиля
  Future<JProfile> getProfile({required String token, required int id}) async {
    if (_profile != JProfile.empty) {
      return _profile;
    }
    Map<String, dynamic> result = await _profileApi.getProfile(token: token, id: id);
    _profile = JProfile.fromJson(result);
    return _profile;
  }

  Future<List<UserLastStream>> getUserLastStreams(JUser user) async {
    return await _profileApi.getUserLastStreams(user);
  }
}