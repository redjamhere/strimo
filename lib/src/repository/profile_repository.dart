
//services
import '../services/services.dart';
//models
import '../models/models.dart';

class ProfileRepository {
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
  Future<JProfile> getProfile(JUser user) async {
    _profile = await _profileApi.getProfile(user);
    return _profile;
  }

  Future<List<UserLastStream>> getUserLastStreams(JUser user) async {
    return await _profileApi.getUserLastStreams(user);
  }
}