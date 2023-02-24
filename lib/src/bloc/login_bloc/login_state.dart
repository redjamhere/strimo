part of 'login_bloc.dart';


class LoginState extends Equatable {
  const LoginState({
    this.status = FormzStatus.pure,
    this.mail = const Mail.pure(),
    this.password = const Password.pure(),
    this.errorMessage
  });

  final FormzStatus status;
  final Mail mail;
  final Password password;

  final String? errorMessage;

  LoginState copyWith({
    FormzStatus? status,
    Mail? mail,
    Password? password,
    String? errorMessage
  }) {
    return LoginState(
      status: status ?? this.status,
      mail: mail ?? this.mail,
      password: password ?? this.password,
      errorMessage: errorMessage ?? this.errorMessage
    );
  }

  @override
  List<Object> get props => [mail, password, status];
}