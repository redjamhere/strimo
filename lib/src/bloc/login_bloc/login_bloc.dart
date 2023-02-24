// описание логики логина
import 'package:equatable/equatable.dart';
import 'package:joyvee/src/repository/respository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:joyvee/src/utils/enums.dart';

//модели
import '../../models/models.dart';

part 'login_state.dart';
part 'login_event.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc({
    required AuthorizationRepository authorizationRepository,
    required UserRepository userRepository,
  }) : _authorizationRepository = authorizationRepository, 
       _userRepository = userRepository,
       super(const LoginState()) {
        on<LoginMailChanged>(_onMailChanged);
        on<LoginPasswordChanged>(_onPassowrdChanged);
        on<LoginSubmitted>(_onSubmitted);
        on<LoginWithSocialSubmitted>(_onSocialSubmitted);
      }

  final AuthorizationRepository _authorizationRepository;
  final UserRepository _userRepository;

  void _onMailChanged(
    LoginMailChanged event,
    Emitter<LoginState> emit
  ) {
    final mail = Mail.dirty(event.mail);
    emit(state.copyWith(
      mail: mail,
      status: Formz.validate([state.password, mail])
    ));
  }

  void _onPassowrdChanged(
    LoginPasswordChanged event,
    Emitter<LoginState> emit
  ) {
    final password = Password.dirty(event.password);
    emit(state.copyWith(
      password: password,
      status: Formz.validate([password, state.mail])
    ));
  }

  Future<void> _onSubmitted(
    LoginSubmitted event,
    Emitter<LoginState> emit
  ) async {
    if (state.status.isValidated) {
      emit(state.copyWith(status: FormzStatus.submissionInProgress));
      try {
        JUser user = await _authorizationRepository.logIn(
          AuthorizationCredentials(email: state.mail.value, password: state.password.value));
        DeviceInfo deviceInfo = await _userRepository.getDeviceInfo();
        user.copyWith(
          deviceId: deviceInfo.id,
          deviceName: deviceInfo.name,
          sysLang: _userRepository.getUserLocalLanguage()
        );
        await _userRepository.saveUserToLocalStorage(user);
        emit(state.copyWith(status: FormzStatus.submissionSuccess));
      } catch (e) {
        emit(state.copyWith(status: FormzStatus.submissionFailure, errorMessage: e.toString()));
      }
    }
  }

  Future<void> _onSocialSubmitted(
    LoginWithSocialSubmitted event,
    Emitter<LoginState> emit
  ) async {
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    try {
      JUser user = await _authorizationRepository.logInWithSocial(event.social);
      DeviceInfo deviceInfo = await _userRepository.getDeviceInfo();
      user.copyWith(
        email: user.email,
        isDeleted: false,
        registrationId: await _userRepository.getRegistrationId(),
        deviceId: deviceInfo.id,
        deviceName: deviceInfo.name,
      );
      await _userRepository.saveUserToLocalStorage(user);
      emit(state.copyWith(status: FormzStatus.submissionSuccess));
    } catch (e) {
      emit(state.copyWith(status: FormzStatus.submissionFailure, errorMessage: e.toString()));
    }
  }
}



