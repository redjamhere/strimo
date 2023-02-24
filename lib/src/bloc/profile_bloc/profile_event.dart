part of 'profile_bloc.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();
  @override
  List<Object> get props => [];
}

class ProfileRequestedEvent extends ProfileEvent {}

class ProfileAvatarChanged extends ProfileEvent {
  const ProfileAvatarChanged(this.avatar);
  final File avatar;
  @override
  List<Object> get props => [avatar];
}

class ProfileDataChanged extends ProfileEvent {
  const ProfileDataChanged(this.profile);
  final JProfile profile;

  @override
  List<Object> get props => [profile];
}