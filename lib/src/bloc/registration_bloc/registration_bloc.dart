// описание логики регастрации 
import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:intl/intl.dart';

//utils
import '../../utils/utils.dart';

//модели
import '../../models/models.dart';

//repositories
import '../../repository/respository.dart';

part 'registration_event.dart';
part 'registration_state.dart';

class RegistrationBloc extends Bloc<RegistrationEvent, RegistrationState> {
  RegistrationBloc({
    required ProfileRepository profileRepository,
    required AuthorizationRepository authorizationRepository,
    required UserRepository userRepository,
  }) 
    : _profileRepository = profileRepository,
      _authorizationRepository = authorizationRepository,
      _userRepository = userRepository,
      super(const RegistrationState()) {
        on<RegFirstnameChanged>(_onRegFirstnameChanged);
        on<RegLastnameChanged>(_onRegLastnameChanged);
        on<RegMailChanged>(_onRegMailChanged);
        on<RegPasswordChanged>(_onRegPassowrdChanged);
        on<RegRepeatPasswordChanged>(_onRegRepeatPasswordChanged);
        on<RegOtpCodeChanged>(_onRegOtpChanged);
        on<RegAvatarPicked>(_onRegAvatarPicked);
        on<RegProfileSubmitted>(_onRegProfileSubmitted);
        on<RegCredentialSubmitted>(_onRegCredentialSubmitted);
        on<RegOtpCodeSubmitted>(_onRegOtpCodeSubmitted);
        on<RegWithSocialSubmitted>(_onRegWithSocialSubmitted);
        on<RegSexChanged>(_onRegSexChanged);
      }

  final ProfileRepository _profileRepository;
  final AuthorizationRepository _authorizationRepository;
  final UserRepository _userRepository;

  void _onRegFirstnameChanged(
    RegFirstnameChanged event,
    Emitter<RegistrationState> emit
  ) {
    final firstname = Firstname.dirty(event.firstname);
    emit(state.copyWith(
      firstname: firstname, 
      profileStatus: Formz.validate([state.lastname, firstname])));
  }

  void _onRegLastnameChanged(
    RegLastnameChanged event,
    Emitter<RegistrationState> emit
  ) {
    final lastname = Lastname.dirty(event.lastname);
    emit(state.copyWith(
      lastname: lastname,
      profileStatus: Formz.validate([lastname, state.firstname])
    ));
  }

  void _onRegMailChanged(
    RegMailChanged event,
    Emitter<RegistrationState> emit
  ) {
    final mail = Mail.dirty(event.mail);
    emit(state.copyWith(
      mail: mail,
      credentialStatus: Formz.validate([state.password, state.repeatPassword, mail])
    ));
  }

  void _onRegPassowrdChanged(
    RegPasswordChanged event,
    Emitter<RegistrationState> emit
  ) {
    final password = Password.dirty(event.password);
    emit(state.copyWith(
      password: password,
      credentialStatus: Formz.validate([password, state.repeatPassword, state.mail])
    ));
  }
  
  void _onRegRepeatPasswordChanged(
    RegRepeatPasswordChanged event,
    Emitter<RegistrationState> emit
  ) {
    final repeatPassword = Password.dirty(event.repeatPassword);
    emit(state.copyWith(
      repeatPassword: repeatPassword,
      credentialStatus: Formz.validate([state.password, repeatPassword, state.mail])
    ));
  }
  
  void _onRegOtpChanged(
    RegOtpCodeChanged event,
    Emitter<RegistrationState> emit
  ) {
    final otp = OtpCode.dirty(event.otp);
    emit(state.copyWith(
      otpCode: otp,
      codeStatus: Formz.validate([otp])
    ));
  }

  void _onRegProfileSubmitted(
    RegProfileSubmitted event,
    Emitter<RegistrationState> emit
  ) {
    if (state.profileStatus.isValidated) {
      emit(state.copyWith(profile: state.profile.copyWith(
        firstname: state.firstname.value,
        lastname: state.lastname.value,
        gender: state.sex
      ), profileStatus: FormzStatus.submissionSuccess));
    } else {
      emit(state.copyWith(profileStatus: FormzStatus.submissionFailure, errorMessage: "Не все поля заполнены"));
    }
  }

  void _onRegCredentialSubmitted(
    RegCredentialSubmitted event,
    Emitter<RegistrationState> emit
  ) async {
    if (state.credentialStatus.isValidated) {
      emit(state.copyWith(credentialStatus: FormzStatus.submissionInProgress));
      try {
        if (state.password.value != state.repeatPassword.value) {
          return emit(state.copyWith(credentialStatus: FormzStatus.submissionFailure, errorMessage: "Password mismatch"));
        }
        String sysLang = _userRepository.getUserLocalLanguage();
        var format = NumberFormat.simpleCurrency(locale: sysLang);

        int id = await _authorizationRepository.sendCredentials(
          AuthorizationCredentials(email: state.mail.value, password: state.password.value), 
          currency: format.currencyName!.toLowerCase());
        DeviceInfo deviceInfo = await _userRepository.getDeviceInfo();
        JUser user = JUser(
          id: id,
          email: state.mail.value,
          isDeleted: false,
          registrationId: await _userRepository.getRegistrationId(),
          deviceId: deviceInfo.id,
          deviceName: deviceInfo.name,
          sysLang: _userRepository.getUserLocalLanguage(),
          currency: format.currencyName!.toLowerCase()
        );
        emit(state.copyWith(user: user, credentialStatus: FormzStatus.submissionSuccess));
      } catch (e) {
        emit(state.copyWith(credentialStatus: FormzStatus.submissionFailure, errorMessage: e.toString()));
      }
    }
  }

  void _onRegOtpCodeSubmitted(
    RegOtpCodeSubmitted event,
    Emitter<RegistrationState> emit
  ) async {
    if (state.codeStatus.isValidated) {
      emit(state.copyWith(codeStatus: FormzStatus.submissionInProgress));
      try {
        JUser userInfo = await _authorizationRepository.sendVerificationCode(state.user, state.otpCode.value);
        emit(state.copyWith(user: state.user.copyWith(token: userInfo.token, streamKey: userInfo.streamKey)));
        await _profileRepository.sendProfileData(state.profile, state.user);
        await _userRepository.saveUserToLocalStorage(state.user);
        emit(state.copyWith(codeStatus: FormzStatus.submissionSuccess));
      } catch (e) {
        emit(state.copyWith(codeStatus: FormzStatus.submissionFailure, errorMessage: e.toString()));
      } 
    } else {
       emit(state.copyWith(codeStatus: FormzStatus.submissionFailure, errorMessage: "Не верный формат"));
    }
  }

  void _onRegSexChanged(
    RegSexChanged event,
    Emitter<RegistrationState> emit
  ) {
    emit(state.copyWith(sex: event.sex));
  }

  void _onRegAvatarPicked(
    RegAvatarPicked event,
    Emitter<RegistrationState> emit
  ) {
    emit(state.copyWith(profile: state.profile.copyWith(sourceAvatar: event.avatar)));
  }

  void _onRegWithSocialSubmitted(
    RegWithSocialSubmitted event,
    Emitter<RegistrationState> emit
  ) async {
    emit(state.copyWith(socialAuthStatus: FormzStatus.submissionInProgress));
    try {
      String idToken = await _authorizationRepository.getFirebaseIdToken(event.social);
      DeviceInfo deviceInfo = await _userRepository.getDeviceInfo();
      var format = NumberFormat.simpleCurrency(locale: _userRepository.getUserLocalLanguage());
      JUser user = JUser(
        deviceId: deviceInfo.id,
        deviceName: deviceInfo.name,
        registrationId: await _userRepository.getRegistrationId(),
        sysLang: _userRepository.getUserLocalLanguage(),
        currency: format.currencyName,
        idToken: idToken
      );
      JUser userInfo = await _authorizationRepository.sendProfilWithSocialAuth(state.profile, user);
      user = user.copyWith(id: userInfo.id, token: userInfo.token);
      await _userRepository.saveUserToLocalStorage(user);
      emit(state.copyWith(socialAuthStatus: FormzStatus.submissionSuccess));
    } catch (e) {
      emit(state.copyWith(socialAuthStatus: FormzStatus.submissionFailure, errorMessage: e.toString()));
    }
  }
}