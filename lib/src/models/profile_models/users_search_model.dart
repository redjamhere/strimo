import 'package:equatable/equatable.dart';
import 'package:joyvee/src/models/profile_models/profile.dart';

class UserSearch extends Equatable {
  const UserSearch({
    this.count = 0,
    this.next,
    this.prevois,
    this.profiles = const []
  });

  final int count;
  final String? next;
  final String? prevois;
  final List<JProfile> profiles;

  factory UserSearch.fromJson(Map<String, dynamic> data) 
    => UserSearch(
      count: data['count'],
      next: data['next'],
      prevois: data['prevois'],
      profiles: data['results']
    ); 
  
  UserSearch copyWith({
    int? count,
    String? next,
    String? prevois,
    List<JProfile>? profiles
  }) => UserSearch(
    count: count?? this.count,
    next: next?? this.next,
    prevois: prevois?? this.prevois,
    profiles: profiles?? this.profiles
  );

  @override
  List<Object> get props => [count, profiles];
}