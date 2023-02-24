part of 'authorization_bloc.dart';

class AuthorizationEvent extends Equatable {
  const AuthorizationEvent();

  @override
  List<Object> get props => [];
}

// Событие которое принимает статус авторизации
class AuthorizationStatusChanged extends AuthorizationEvent {
  const AuthorizationStatusChanged(this.status);
  final AuthorizationStatus status;
  @override
  List<Object> get props => [status];
}

class AuthorizationLogoutRequested extends AuthorizationEvent {}