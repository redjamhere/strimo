part of 'stream_setup_bloc.dart';

class StreamSetupEvent extends Equatable {
  const StreamSetupEvent();
  @override
  List<Object> get props => [];
}

class StreamSetupNameChanged extends StreamSetupEvent {
  const StreamSetupNameChanged(this.name);
  final String name;
  @override
  List<Object> get props => [name];
} 

class StreamSetupDescriptionChanged extends StreamSetupEvent {
  const StreamSetupDescriptionChanged(this.description);
  final String description;
  @override
  List<Object> get props => [description];
}

class StreamSetupPreviewPicked extends StreamSetupEvent {
  const StreamSetupPreviewPicked(this.preview);
  final File preview;
  
  @override
  List<Object> get props => [preview];
}

class StreamSetupLocationPicked extends StreamSetupEvent {
  const StreamSetupLocationPicked(this.place);
  final PickedPlace place;
  @override
  List<Object> get props => [place];
}

class StreamSetupCostChanged extends StreamSetupEvent {
  const StreamSetupCostChanged(this.cost);
  final double cost;
  @override
  List<Object> get props => [cost];
}

class StreamSetupIsPrivateChanged extends StreamSetupEvent {
  const StreamSetupIsPrivateChanged(this.isPrivate);
  final bool isPrivate;
  @override
  List<Object> get props => [isPrivate];
}

class StreamSetupIsFreeChanged extends StreamSetupEvent {
  const StreamSetupIsFreeChanged(this.isFree);
  final bool isFree;
  @override
  List<Object> get props => [isFree];
}

class StreamSetupChatEnabledChanged extends StreamSetupEvent {
  const StreamSetupChatEnabledChanged(this.isChatEnabled);
  final bool isChatEnabled;
  @override
  List<Object> get props => [isChatEnabled];
}

class StreamSetupInstagramShared extends StreamSetupEvent {
  const StreamSetupInstagramShared(this.isInstagramShared);
  final bool isInstagramShared;
  @override
  List<Object> get props => [isInstagramShared];
}

class StreamSetupTikTokShared extends StreamSetupEvent {
  const StreamSetupTikTokShared(this.isTikTokShared);
  final bool isTikTokShared;
  @override
  List<Object> get props => [isTikTokShared];
}

class StreamSetupYouTubeShared extends StreamSetupEvent {
  const StreamSetupYouTubeShared(this.isYouTubeShared);
  final bool isYouTubeShared;
  @override
  List<Object> get props => [isYouTubeShared];
}

class StreamSetupFirstStepSubmitted extends StreamSetupEvent {}
class StreamSetupSecondStepSubmitted extends StreamSetupEvent {}

