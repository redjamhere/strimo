// Описание логики профиля
import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:joyvee/src/interfaces/interfaces.dart';
import 'package:joyvee/src/models/models.dart';

//repositories
import 'package:joyvee/src/repository/respository.dart';


part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc({
    required UserRepository userRepository,
    required ProfileRepository profileRepository
  }) 
  : _userRepository = userRepository,
    _profileRepository = profileRepository, 
    super (const ProfileState()) {
      on<ProfileRequestedEvent>(_onProfileRequestedEvent);
      on<ProfileAvatarChanged>(_onProfileAvatarChanged);
      on<ProfileDataChanged>(_onProfileDataChanged);
    }

  final UserRepository _userRepository;
  final ProfileRepository _profileRepository;

  void _onProfileRequestedEvent(
    ProfileRequestedEvent event,
    Emitter<ProfileState> emit
  ) async {
    emit(state.copyWith(profileLoadingStatus: FormzStatus.submissionInProgress));
    try {
      JProfile p = await _profileRepository.getProfile(_userRepository.user);
      List<UserLastStream> ls = await _profileRepository.getUserLastStreams(_userRepository.user);
      emit(state.copyWith(
        profile: p, 
        lastStreams: ls,
        profileLoadingStatus: FormzStatus.submissionSuccess));
    } catch (e) {
      emit(state.copyWith(
        profileLoadingStatus: FormzStatus.submissionFailure, 
        errorMessage: e.toString()));
    }
  }

  void _onProfileAvatarChanged(
    ProfileAvatarChanged event,
    Emitter<ProfileState> emit
  ) async {
    emit(state.copyWith(profileUpdatingStatus: FormzStatus.submissionInProgress));
    try {
      JProfile p = state.profile.copyWith(sourceAvatar: event.avatar);
      await _profileRepository.updateProfileData(p, _userRepository.user);
      emit(state.copyWith(profile: p, profileUpdatingStatus: FormzStatus.submissionSuccess));
    } catch (e) {
      emit(state.copyWith(profileUpdatingStatus: FormzStatus.submissionFailure, errorMessage: e.toString()));
    }
  }

  void _onProfileDataChanged(
    ProfileDataChanged event,
    Emitter<ProfileState> emit,
  ) async {
    emit(state.copyWith(profileUpdatingStatus: FormzStatus.submissionInProgress));
    try {
      await _profileRepository.updateProfileData(event.profile, _userRepository.user);
      emit(state.copyWith(profile: event.profile, profileUpdatingStatus: FormzStatus.submissionSuccess));
    } catch (e) {
      emit(state.copyWith(profileUpdatingStatus: FormzStatus.submissionFailure, errorMessage: e.toString()));
    }
  }

}