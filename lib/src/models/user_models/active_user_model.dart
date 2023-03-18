import 'package:joyvee/src/interfaces/interfaces.dart';

class ActiveUserModel extends Profile{
  final int id;
  final double latitude;
  final double longitude;

  const ActiveUserModel({
    int? userId = 0,
    double? rating = 0,
    String? avatar = "",
    required this.id,
    required this.latitude, 
    required this.longitude});

  factory ActiveUserModel.fromJson(Map<String, dynamic> data) => ActiveUserModel(
      id: data['id'],
      userId: data['user_id'],
      latitude: data['latitude'],
      longitude: data['longitude'],
      avatar: data['avatar']);

  const ActiveUserModel.emptyActiveUser({
    this.id = 0, 
    this.latitude = 0.0, 
    this.longitude = 0.0}) : super();

  @override
  Map<String, dynamic> toJson() => {};

  @override
  String toString() => '$userId';

  @override
  List<Object> get props => [userId!];
}