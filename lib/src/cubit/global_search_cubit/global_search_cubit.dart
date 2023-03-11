import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:joyvee/src/models/models.dart';
import 'package:joyvee/src/repository/respository.dart';
import 'package:formz/formz.dart';
part 'global_search_state.dart';

class GlobalSearchCubit extends Cubit<GlobalSearchState> {
  GlobalSearchCubit({
    required UserRepository userRepository,
    required SearchRepository searchRepository
  }) 
  : _userRepository = userRepository,
    _searchRepository = searchRepository,
  super(const GlobalSearchState());

  final UserRepository _userRepository;
  final SearchRepository _searchRepository;
  final TextEditingController searchFieldController = TextEditingController();

  void onSearchFieldClear() {
    searchFieldController.clear();
    emit(state.copyWith(showSuffix: false));
  }

  void onTabChanged(int tab) {
    switch (tab) {
      case 0:
        emit(state.copyWith(searchCategory: SearchCategory.user));
        break;
      case 1:
        emit(state.copyWith(searchCategory: SearchCategory.stream));
        break;
      case 2:
        emit(state.copyWith(searchCategory: SearchCategory.place));
        break;
      default:
    }
  }

  void onSearchFieldChanged() async {
    emit(state.copyWith(showSuffix: searchFieldController.text.isNotEmpty));
    emit(state.copyWith(usersSearchStatus: FormzStatus.submissionInProgress));
    try {
      UserSearch users = await _searchRepository.fetchUsers(searchFieldController.text);
      emit(state.copyWith(usersSearchStatus: FormzStatus.submissionSuccess, users: users));
    } catch (e) {
      emit(state.copyWith(usersSearchStatus: FormzStatus.submissionFailure));
    }
  }

  void onFetchData() async {
    emit(state.copyWith(nextFetchStatus: FormzStatus.submissionInProgress));
    try {
      UserSearch users = await _searchRepository.fetchUsers(searchFieldController.text, url: state.users.next);
      emit(state.copyWith(nextFetchStatus: FormzStatus.submissionSuccess, users: state.users.copyWith(
        next: users.next,
        prevois: users.prevois,
        profiles: state.users.profiles..addAll(users.profiles)
      )));
    } catch (e) {
      emit(state.copyWith(nextFetchStatus: FormzStatus.submissionFailure));
    }
  }
}