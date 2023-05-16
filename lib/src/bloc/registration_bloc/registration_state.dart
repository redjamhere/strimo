part of 'registration_bloc.dart';

class RegistrationState extends Equatable {
  RegistrationState({
    this.profileStatus = FormzStatus.pure,
    this.firstname = const Firstname.pure(),
    this.lastname = const Lastname.pure(),
    this.sex = Sex.female,
    this.credentialStatus = FormzStatus.pure,
    this.mail = const Mail.pure(),
    this.password = const Password.pure(),
    this.repeatPassword = const Password.pure(),
    this.otpCode = const OtpCode.pure(),
    this.codeStatus = FormzStatus.pure,
    this.errorMessage,
    this.profile = RegistrationProfile.empty,
    this.socialAuthStatus = FormzStatus.pure,
    this.user
  });

  final FormzStatus profileStatus;
  final Firstname firstname;
  final Lastname lastname;
  final Sex sex;

  final FormzStatus credentialStatus;
  final Mail mail;
  final Password password;
  final Password repeatPassword;
  final FormzStatus socialAuthStatus;

  final FormzStatus codeStatus;
  final OtpCode otpCode;

  final String? errorMessage;
  
  final RegistrationProfile profile;
  final JUser? user;

  RegistrationState copyWith({
    FormzStatus? profileStatus,
    Firstname? firstname,
    Lastname? lastname,
    Sex? sex,
    FormzStatus? credentialStatus,
    Mail? mail,
    Password? password,
    Password? repeatPassword,
    FormzStatus? codeStatus,
    OtpCode? otpCode,
    String? errorMessage,
    RegistrationProfile? profile,
    JUser? user,
    FormzStatus? socialAuthStatus,
  }) => RegistrationState(
    profileStatus: profileStatus?? this.profileStatus,
    firstname: firstname?? this.firstname,
    lastname: lastname?? this.lastname,
    sex: sex?? this.sex,
    credentialStatus: credentialStatus?? this.credentialStatus,
    mail: mail ?? this.mail,
    password: password ?? this.password,
    repeatPassword: repeatPassword?? this.repeatPassword,
    codeStatus: codeStatus?? this.codeStatus,
    errorMessage: errorMessage?? this.errorMessage,
    profile: profile?? this.profile,
    user: user?? this.user,
    otpCode: otpCode?? this.otpCode,
    socialAuthStatus: socialAuthStatus?? this.socialAuthStatus
  );

  @override
  List<Object?> get props => [
    profile, 
    profileStatus, 
    firstname, 
    lastname, 
    sex, 
    credentialStatus, 
    mail, 
    password, 
    repeatPassword, 
    codeStatus, 
    otpCode, 
    user, 
    socialAuthStatus];
} 