import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:joyvee/src/utils/enums.dart';

import '../models/models.dart';
import '../services/services.dart';

enum AuthorizationStatus { unknow, authenticated, unauthenticated, error }

class AuthorizationRepository {
  final StreamController<AuthorizationStatus> _controller = StreamController<AuthorizationStatus>.broadcast();
  final UserService _userAPI = UserService();
  final AuthorizationService _authAPI = AuthorizationService();

  //поток данных для статуса авторизации
  Stream<AuthorizationStatus> get status async* {
    JUser? u = await _userAPI.getUserFromLocalStorage();
    // ignore: unnecessary_null_comparison
    if (u == null) {
      yield AuthorizationStatus.unauthenticated;
    } else {
      try {
        bool isAuth = await checkAuth(u);
        yield isAuth
          ? AuthorizationStatus.authenticated
          : AuthorizationStatus.unauthenticated;
      } catch (e) {
        yield AuthorizationStatus.error;
      }

    }
    yield* _controller.stream;
  }

  Future<bool> checkAuth(JUser user) async{
    return await _authAPI.checkToken(user);
  }

  Future<JUser> logIn(AuthorizationCredentials c) async {
    return await _authAPI.logIn(c);
  }

  Future<JUser> logInWithSocial(SocialAuthType social) async {
    UserCredential sUser;
    switch (social) {
      case SocialAuthType.google:
        sUser = await _authAPI.signInWithGoogle();
        break;
      case SocialAuthType.apple:
        sUser = await _authAPI.signInWithApple();
        break;
      case SocialAuthType.facebook:
        sUser = await _authAPI.signInWithFacebook();
        break;
    }
    String idToken = await sUser.user!.getIdToken();
    JUser u = await _authAPI.loginWithSocial(idToken);
    return u.copyWith(idToken: idToken);
  }

  Future<String> getFirebaseIdToken(SocialAuthType social) async {
    UserCredential sUser;
    switch (social) {
      case SocialAuthType.google:
        sUser = await _authAPI.signInWithGoogle();
        break;
      case SocialAuthType.apple:
        sUser = await _authAPI.signInWithApple();
        break;
      case SocialAuthType.facebook:
        sUser = await _authAPI.signInWithFacebook();
        break;
    }
    String idToken = await sUser.user!.getIdToken();
    return idToken;
  }

  // для отправки логина я пороля при регистрации
  Future<int> sendCredentials(AuthorizationCredentials c, {String? currency}) async {
    return await _authAPI.sendCredentials(c, currency: currency);
  }

  Future<JUser> sendVerificationCode(JUser u, String code) async {
    return await _authAPI.sendVerificationCode(u, code);
  }

  Future<JUser> sendProfilWithSocialAuth(RegistrationProfile p, JUser user) async {
    return await _authAPI.sendProfileWithSocialAuth(p, user);
  }

  Future<void> logOut() async {
    await _userAPI.removeUserFromLocalStorage();
    await FirebaseAuth.instance.signOut();
    _controller.add(AuthorizationStatus.unauthenticated);
  }
  
  void dispose() => _controller.close();
}