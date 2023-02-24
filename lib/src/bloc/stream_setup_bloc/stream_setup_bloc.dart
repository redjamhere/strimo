// описание логики настройки стримов
import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:hashtagable/functions.dart';
import 'package:joyvee/src/cubit/cubit.dart';

//utils
import '../../utils/utils.dart';

//models
import '../../models/models.dart';

//repository
import '../../repository/respository.dart';

part 'stream_setup_state.dart';
part 'stream_setup_event.dart';

class StreamSetupBloc extends Bloc<StreamSetupEvent, StreamSetupState> {
  StreamSetupBloc({
    required StreamType streamType,
    required StreamRepository streamRepository,
    required UserRepository userRepository,
    required this.pickLocationCubit
  })
    : _userRepository = userRepository,
      _streamRepository = streamRepository,
      super(StreamSetupState(streamType: streamType, currency: userRepository.user.currency!)) {
        on<StreamSetupNameChanged>(_onStreamSetupNameChanged);
        on<StreamSetupDescriptionChanged>(_onStreamSetupDescriptionChanged);
        on<StreamSetupPreviewPicked>(_onStreamSetupPreviewPicked);
        on<StreamSetupLocationPicked>(_onStreamSetupLocationPicked);
        on<StreamSetupCostChanged>(_onStreamSetupCostChanged);
        on<StreamSetupIsPrivateChanged>(_onStreamSetupIsPrivateChanged);
        on<StreamSetupIsFreeChanged>(_onStreamSetupIsFreeChanged);
        on<StreamSetupInstagramShared>(_onStreamSetupInstagramShared);
        on<StreamSetupYouTubeShared>(_onStreamSetupYouTubeShared);
        on<StreamSetupTikTokShared>(_onStreamSetupTikTokShared);
        on<StreamSetupChatEnabledChanged>(_onStreamSetupChatEnabledChaned);
        on<StreamSetupSecondStepSubmitted>(_onStreamSetupSecondStepSubmitted);

        pickLocationSubscription = pickLocationCubit.stream.listen((state) {
          if (state.pickLocationStatus.isSubmissionSuccess) {
            add(StreamSetupLocationPicked(state.pickedPlace!));
          }
        });
      }

  final UserRepository _userRepository;
  final StreamRepository _streamRepository;

  final PickLocationCubit pickLocationCubit;
  late StreamSubscription pickLocationSubscription;

  void _onStreamSetupNameChanged(
    StreamSetupNameChanged event,
    Emitter<StreamSetupState> emit
  ) {
    final name = StreamName.dirty(event.name);
    emit(state.copyWith(streamName: name, streamSetupFirstStepStatus: Formz.validate([state.description, name])));
  }

  void _onStreamSetupDescriptionChanged(
    StreamSetupDescriptionChanged event,
    Emitter<StreamSetupState> emit
  ) {
    final description = StreamDescription.dirty(event.description);
    emit(state.copyWith(streamDescription: description, streamSetupFirstStepStatus: Formz.validate([description, state.name])));
  }

  void _onStreamSetupCostChanged(
    StreamSetupCostChanged event,
    Emitter<StreamSetupState> emit
  ) {
    final cost = Cost.dirty(event.cost);
    emit(state.copyWith(
      cost: cost, 
      isFree: cost.value <= 0,
      streamSetupSecondStepStatus: Formz.validate([state.pickedPlace, cost])));
  }

  void _onStreamSetupIsPrivateChanged(
    StreamSetupIsPrivateChanged event,
    Emitter<StreamSetupState> emit
  ) {
    emit(state.copyWith(setupedStream: state.setupedStream.copyWith(isPrivate: event.isPrivate)));
  }

  void _onStreamSetupChatEnabledChaned(
    StreamSetupChatEnabledChanged event,
    Emitter<StreamSetupState> emit
  ) {
    emit(state.copyWith(setupedStream: state.setupedStream.copyWith(isChatEnabled: event.isChatEnabled)));
  }

  void _onStreamSetupInstagramShared(
    StreamSetupInstagramShared event,
    Emitter<StreamSetupState> emit,
  ) {
    emit(state.copyWith(setupedStream: state.setupedStream.copyWith(isInstagramShared: event.isInstagramShared)));
  }

  void _onStreamSetupYouTubeShared(
    StreamSetupYouTubeShared event,
    Emitter<StreamSetupState> emit,
  ) {
    emit(state.copyWith(setupedStream: state.setupedStream.copyWith(isYouTubeShared: event.isYouTubeShared)));
  }

  void _onStreamSetupTikTokShared(
    StreamSetupTikTokShared event,
    Emitter<StreamSetupState> emit,
  ) {
    emit(state.copyWith(setupedStream: state.setupedStream.copyWith(isTikTokShared: event.isTikTokShared)));
  }

  void _onStreamSetupIsFreeChanged(
    StreamSetupIsFreeChanged event,
    Emitter<StreamSetupState> emit
  ) {
    final cost = (event.isFree) ? const Cost.pure() : state.cost;
    state.costController.text = cost.value.toString();
    emit(state.copyWith(isFree: event.isFree, cost: cost, costController: state.costController));
  }

  void _onStreamSetupLocationPicked(
    StreamSetupLocationPicked event,
    Emitter<StreamSetupState> emit
  ) {
    final pickedPlace = PickedPlaceFormz.dirty(event.place);
    emit(state.copyWith(pickedPlace: pickedPlace, streamSetupSecondStepStatus: Formz.validate([pickedPlace, state.cost])));
  }

  void _onStreamSetupPreviewPicked(
    StreamSetupPreviewPicked event,
    Emitter<StreamSetupState> emit
  ) {
    emit(state.copyWith(setupedStream: state.setupedStream.copyWith(sourcePreview: event.preview)));
  }

  void _onStreamSetupSecondStepSubmitted(
    StreamSetupSecondStepSubmitted event,
    Emitter<StreamSetupState> emit
  ) async {
    emit(state.copyWith(streamSetupSecondStepStatus: FormzStatus.submissionInProgress));
    if (state.streamSetupSecondStepStatus.isValidated) {
      try {
        JUser u = await _userRepository.getUserFromLocalStorage();
        JStream stream = state.setupedStream.copyWith(
          title: state.name.value,
          description: state.description.value,
          position: state.pickedPlace.value.position,
          locationName: state.pickedPlace.value.toString(),
          streamType: state.streamType,
          tags: extractHashTags(state.description.value),
          cost: state.cost.value,
          owner: StreamOwner(userId: u.id!)
        );
        stream = await _streamRepository.createBroadcast(stream, u.token!);
        emit(state.copyWith(streamSetupSecondStepStatus: FormzStatus.submissionSuccess, setupedStream: stream, streamStartKey: u.streamKey));
      } catch (e) {
        emit(state.copyWith(streamSetupSecondStepStatus: FormzStatus.submissionFailure, errorMessage: e.toString()));
      }
    }
  }

}