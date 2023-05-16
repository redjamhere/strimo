part of 'authorization_bloc.dart';

class AuthorizationState extends Equatable {
  AuthorizationState._({
    this.status = AuthorizationStatus.unknow,
    this.errorMessage,
    JUser? user
  }) : user = JUser.empty;

  final AuthorizationStatus status;
  final JUser user;
  final String? errorMessage;

  AuthorizationState.unknow() : this._();

  AuthorizationState.authenticated(JUser user)
    : this._(status: AuthorizationStatus.authenticated, user: user);

  AuthorizationState.unauthenticated(): this._(status: AuthorizationStatus.unauthenticated);

  AuthorizationState.error(String error) : this._(errorMessage: error, status: AuthorizationStatus.error);

  @override
  List<Object> get props => [status, user];
}