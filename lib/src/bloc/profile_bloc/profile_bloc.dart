// Описание логики профиля
import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:joyvee/src/interfaces/interfaces.dart';
import 'package:joyvee/src/mixin/mixins.dart';
import 'package:joyvee/src/models/models.dart';

//repositories
import 'package:joyvee/src/repository/respository.dart';


part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> with UserStorageMixin{
  ProfileBloc({
    required ProfileRepository profileRepository
  }) 
  : _profileRepository = profileRepository, 
    super (const ProfileState()) {
      on<ProfileRequestedEvent>(_onProfileRequestedEvent);
      on<ProfileAvatarChanged>(_onProfileAvatarChanged);
      on<ProfileDataChanged>(_onProfileDataChanged);
    }

  final ProfileRepository _profileRepository;

  void _onProfileRequestedEvent(
    ProfileRequestedEvent event,
    Emitter<ProfileState> emit
  ) async {
    emit(state.copyWith(profileLoadingStatus: FormzStatus.submissionInProgress));
    try {
      var user = getUserFromStorage();
      JProfile p = await _profileRepository
        .getProfile(id: event.userId?? user!.id!, token: user!.token!);
      List<UserLastStream> ls = await _profileRepository.getUserLastStreams(user);
      emit(state.copyWith(
        profile: p, 
        lastStreams: ls,
        isMy: event.isMy,
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
      var user = getUserFromStorage();
      JProfile p = state.profile.copyWith(sourceAvatar: event.avatar);
      await _profileRepository.updateProfileData(p, user!);
      emit(state.copyWith(profile: p, profileUpdatingStatus: FormzStatus.submissionSuccess));
    } catch (e) {
      emit(state.copyWith(profileUpdatingStatus: FormzStatus.submissionFailure, errorMessage: e.toString()));
    }
  }

  void _onProfileDataChanged(
    ProfileDataChanged event,
    Emitter<ProfileState> emit,
  ) async {
    var user = getUserFromStorage();
    emit(state.copyWith(profileUpdatingStatus: FormzStatus.submissionInProgress));
    try {
      await _profileRepository.updateProfileData(event.profile, user!);
      emit(state.copyWith(profile: event.profile, profileUpdatingStatus: FormzStatus.submissionSuccess));
    } catch (e) {
      emit(state.copyWith(profileUpdatingStatus: FormzStatus.submissionFailure, errorMessage: e.toString()));
    }
  }

}