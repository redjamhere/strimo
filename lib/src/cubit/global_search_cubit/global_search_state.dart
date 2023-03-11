part of 'global_search_cubit.dart';

enum SearchCategory { user, stream, place }

class GlobalSearchState extends Equatable{
  const GlobalSearchState({
    this.showSuffix = false,
    this.users = const UserSearch(),
    this.usersSearchStatus = FormzStatus.pure,
    this.searchCategory = SearchCategory.user,
    this.nextFetchStatus = FormzStatus.pure
  });

  final bool showSuffix; 
  final UserSearch users;
  final FormzStatus usersSearchStatus;
  final SearchCategory searchCategory;

  final FormzStatus nextFetchStatus;

  GlobalSearchState copyWith({
    bool? showSuffix,
    UserSearch? users,
    FormzStatus? usersSearchStatus,
    SearchCategory? searchCategory,
    FormzStatus? nextFetchStatus
  }) => GlobalSearchState(
    showSuffix: showSuffix?? this.showSuffix,
    users: users?? this.users,
    usersSearchStatus: usersSearchStatus?? this.usersSearchStatus,
    searchCategory: searchCategory?? this.searchCategory,
    nextFetchStatus: nextFetchStatus?? this.nextFetchStatus
  );

  @override
  List<Object> get props => [showSuffix, users, usersSearchStatus, searchCategory, nextFetchStatus];
}