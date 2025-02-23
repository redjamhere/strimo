part of 'profile_bloc.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();
  @override
  List<Object> get props => [];
}

class ProfileRequestedEvent extends ProfileEvent {
  const ProfileRequestedEvent({this.isMy = true, this.userId});
  final bool isMy;
  final int? userId;
  @override
  List<Object> get props => [isMy];
}

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