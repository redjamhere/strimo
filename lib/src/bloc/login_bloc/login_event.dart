part of 'login_bloc.dart';

class LoginEvent extends Equatable{
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class LoginMailChanged extends LoginEvent {
  const LoginMailChanged(this.mail);
  final String mail;

  @override
  List<Object> get props => [mail];
}

class LoginPasswordChanged extends LoginEvent {
  const LoginPasswordChanged(this.password);
  final String password;

  @override
  List<Object> get props => [password];
}

class LoginSubmitted extends LoginEvent {
  const LoginSubmitted();
}

class LoginWithSocialSubmitted extends LoginEvent {
  const LoginWithSocialSubmitted(this.social);
  final SocialAuthType social;

  @override
  List<Object> get props => [social];
}