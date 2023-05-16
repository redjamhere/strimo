// Описание логики авторизации
import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:joyvee/src/mixin/mixins.dart';

//репозитории
import '../../repository/respository.dart';

//модели
import '../../models/models.dart';

part 'authorization_event.dart';
part 'authorization_state.dart';

class AuthorizationBloc extends Bloc<AuthorizationEvent, AuthorizationState> with UserStorageMixin{
  AuthorizationBloc({
    required AuthorizationRepository authorizationRepository,
  }) : 
    _authorizationRepository = authorizationRepository,
    super(AuthorizationState.unknow()) {
      on<AuthorizationStatusChanged>(_onAuthorizationStatusChanged);
      on<AuthorizationLogoutRequested>(_onAuthorizationLogoutRequested);
      _authorizationStatusSubscription = _authorizationRepository.status.listen((status) => add(AuthorizationStatusChanged(status)));
    }

  final AuthorizationRepository _authorizationRepository;

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
       return emit(AuthorizationState.unauthenticated());
      case AuthorizationStatus.authenticated:
        final user = getUserFromStorage();
        return emit(
          user != null
            ? AuthorizationState.authenticated(user)
            : AuthorizationState.unauthenticated()
        );
      case AuthorizationStatus.unknow:
        return emit(AuthorizationState.unknow());
      case AuthorizationStatus.error:
        return emit(AuthorizationState.error("Нет подключения к серверу"));
    }
  }

  void _onAuthorizationLogoutRequested(
    AuthorizationLogoutRequested event,
    Emitter<AuthorizationState> emit
  ) async {
    _authorizationRepository.logOut();
  }

}