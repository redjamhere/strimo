part of 'registration_bloc.dart';

class RegistrationEvent extends Equatable {
  const RegistrationEvent();
  
  @override
  List<Object> get props => [];
}

class RegFirstnameChanged extends RegistrationEvent {
  const RegFirstnameChanged(this.firstname);
  final String firstname;

  @override
  List<Object> get props => [firstname];
}

class RegLastnameChanged extends RegistrationEvent {
  const RegLastnameChanged(this.lastname);
  final String lastname;

  @override
  List<Object> get props => [lastname];
}

class RegSexChanged extends RegistrationEvent {
  const RegSexChanged(this.sex);
  final Sex sex;

  @override
  List<Object> get props => [sex];
}

class RegMailChanged extends RegistrationEvent {
  const RegMailChanged(this.mail);
  final String mail;

  @override
  List<Object> get props => [mail];
}

class RegPasswordChanged extends RegistrationEvent {
  const RegPasswordChanged(this.password);
  final String password;

  @override
  List<Object> get props => [password];
}

class RegRepeatPasswordChanged extends RegistrationEvent {
  const RegRepeatPasswordChanged(this.repeatPassword);
  final String repeatPassword;

  @override
  List<Object> get props => [repeatPassword];
}

class RegOtpCodeChanged extends RegistrationEvent {
  const RegOtpCodeChanged(this.otp);
  final String otp;

  @override
  List<Object> get props => [otp];
}

class RegProfileSubmitted extends RegistrationEvent {
  const RegProfileSubmitted();
}

class RegCredentialSubmitted extends RegistrationEvent {
  const RegCredentialSubmitted();
}

class RegOtpCodeSubmitted extends RegistrationEvent {
  const RegOtpCodeSubmitted();
}

class RegAvatarPicked extends RegistrationEvent {
  const RegAvatarPicked(this.avatar);
  final File avatar;

  @override
  List<Object> get props => [avatar];
}

class RegWithSocialSubmitted extends RegistrationEvent {
  const RegWithSocialSubmitted(this.social);
  final SocialAuthType social;

  @override
  List<Object> get props => [social];
}