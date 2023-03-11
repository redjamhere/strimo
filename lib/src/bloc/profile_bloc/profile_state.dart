part of 'profile_bloc.dart';

class ProfileState extends Equatable {
  const ProfileState({
    this.profile = JProfile.empty,
    this.profileLoadingStatus = FormzStatus.pure,
    this.profileUpdatingStatus = FormzStatus.pure,
    this.errorMessage,
    this.lastStreams = const [],
    this.isMy = true
  });

  final JProfile profile;
  
  final FormzStatus profileLoadingStatus;
  final FormzStatus profileUpdatingStatus;

  final String? errorMessage;
  final List<UserLastStream> lastStreams;

  // is profile another or self
  final bool isMy;

  ProfileState copyWith({
    JProfile? profile,
    FormzStatus? profileLoadingStatus,
    FormzStatus? profileUpdatingStatus,
    String? errorMessage,
    List<UserLastStream>? lastStreams,
    bool? isMy,
  }) => ProfileState(
    profile: profile?? this.profile,
    profileLoadingStatus: profileLoadingStatus?? this.profileLoadingStatus,
    profileUpdatingStatus: profileUpdatingStatus?? this.profileUpdatingStatus,
    errorMessage: errorMessage?? this.errorMessage,
    lastStreams: lastStreams?? this.lastStreams,
    isMy: isMy?? this.isMy
  );

  @override
  List<Object> get props => [profile, profileLoadingStatus, lastStreams, profileUpdatingStatus, isMy];
}