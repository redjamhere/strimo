// Описание логики авторизации
import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';

//репозитории
import '../../repository/respository.dart';

//модели
import '../../models/models.dart';

part 'authorization_event.dart';
part 'authorization_state.dart';

class AuthorizationBloc extends Bloc<AuthorizationEvent, AuthorizationState> {
  AuthorizationBloc({
    required AuthorizationRepository authorizationRepository,
    required UserRepository userRepository
  }) : 
    _authorizationRepository = authorizationRepository,
    _userRepository = userRepository,
    super(const AuthorizationState.unknow()) {
      on<AuthorizationStatusChanged>(_onAuthorizationStatusChanged);
      on<AuthorizationLogoutRequested>(_onAuthorizationLogoutRequested);
      _authorizationStatusSubscription = _authorizationRepository.status.listen((status) => add(AuthorizationStatusChanged(status)));
    }

  final AuthorizationRepository _authorizationRepository;
  final UserRepository _userRepository;
  late StreamSubscription<AuthorizationStatus> _authorizationStatusSubscription;

  @override
  Future<void> close() {
    _authorizationStatusSubscription.cancel();
    _authorizationRepository.dispose();
    return super.close();
  }

  Future<void> _onAuthorizationStatusChanged(
    AuthorizationStatusChanged event,
    Emitter<AuthorizationState> emit
  ) async {
    switch (event.status) {
      case AuthorizationStatus.unauthenticated:
       return emit(const AuthorizationState.unauthenticated());
      case AuthorizationStatus.authenticated:
        final user = await _tryGetUser();
        return emit(
          user != null
            ? AuthorizationState.authenticated(user)
            : const AuthorizationState.unauthenticated()
        );
      case AuthorizationStatus.unknow:
        return emit(const AuthorizationState.unknow());
      case AuthorizationStatus.error:
        return emit(const AuthorizationState.error("Нет подключения к серверу"));
    }
  }

  void _onAuthorizationLogoutRequested(
    AuthorizationLogoutRequested event,
    Emitter<AuthorizationState> emit
  ) async {
    _authorizationRepository.logOut();
  }

  Future<JUser?> _tryGetUser() async {
    try {
      final JUser u = await _userRepository.getUserFromLocalStorage();
      return u;
    } catch (_) {
      return null;
    }
  }

}