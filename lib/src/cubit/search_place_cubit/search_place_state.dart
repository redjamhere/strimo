part of 'search_place_cubit.dart';

class SearchPlaceState extends Equatable {
  const SearchPlaceState({
    this.sysLang = "en",
    this.searchResults = const [],
    this.searchStatus = FormzStatus.pure
  });

  final String sysLang;
  final FormzStatus searchStatus;
  final List<SearchResult> searchResults;
  
  SearchPlaceState copyWith({
    String? sysLang,
    FormzStatus? searchStatus,
    List<SearchResult>? searchResults,
  }) => SearchPlaceState(
    sysLang: sysLang?? this.sysLang,
    searchStatus: searchStatus?? this.searchStatus,
    searchResults: searchResults?? this.searchResults
  );

  @override
  List<Object> get props => [sysLang, searchResults, searchStatus];
}