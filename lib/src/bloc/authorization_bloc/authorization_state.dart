part of 'authorization_bloc.dart';

class AuthorizationState extends Equatable {
  const AuthorizationState._({
    this.status = AuthorizationStatus.unknow,
    this.user = JUser.empty,
    this.errorMessage
  });

  final AuthorizationStatus status;
  final JUser user;
  final String? errorMessage;

  const AuthorizationState.unknow() : this._();

  const AuthorizationState.authenticated(JUser user)
    : this._(status: AuthorizationStatus.authenticated, user: user);

  const AuthorizationState.unauthenticated(): this._(status: AuthorizationStatus.unauthenticated);

  const AuthorizationState.error(String error) : this._(errorMessage: error, status: AuthorizationStatus.error);

  @override
  List<Object> get props => [status, user];
}