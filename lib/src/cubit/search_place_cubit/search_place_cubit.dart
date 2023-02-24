import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:google_place/google_place.dart';
import 'package:joyvee/src/repository/map_repository.dart';
import 'package:joyvee/src/repository/respository.dart';

part 'search_place_state.dart';

class SearchPlaceCubit extends Cubit<SearchPlaceState> {
  SearchPlaceCubit({
    required UserRepository userRepository,
    required MapRepository mapRepository
  }) : _userRepository = userRepository,
       _mapRepository = mapRepository,
       super(const SearchPlaceState());

  final UserRepository _userRepository;
  final MapRepository _mapRepository; 
  

  void setUserSystemLanguage() {
    emit(state.copyWith(sysLang: _userRepository.user.sysLang));
  }

  void onSearchChanged(String s) async {
    emit(state.copyWith(searchStatus: FormzStatus.submissionInProgress));
    List<SearchResult>? results = await _mapRepository.getPlacesBySearch(s, state.sysLang);
    emit(state.copyWith(
      searchResults: results,
      searchStatus: FormzStatus.submissionSuccess
    ));
  }
}