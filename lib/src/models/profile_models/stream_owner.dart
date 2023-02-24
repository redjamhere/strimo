import '../../interfaces/interfaces.dart';

class StreamOwner extends Profile {
  const StreamOwner({
    int? userId = 0,
    double? rating = 0,
    String? avatar = "",
    String? firstname = "",
    String? lastname = ""}) : super(
      userId: userId,
      rating: rating,
      avatar: avatar,
      firstname: firstname,
      lastname: lastname);

  factory StreamOwner.fromJson(Map<String, dynamic> data) => StreamOwner(
      userId: data['user_id'],
      rating: data['rating'],
      avatar: data['avatar'],
      firstname: data['firstname'],
      lastname: data['lastname']
  );

  const StreamOwner.emptyOwner() : super();

  @override
  Map<String, dynamic> toJson() => {};

  @override
  List<Object> get props => [userId!, avatar!, firstname!, lastname!];

  static const empty = StreamOwner.emptyOwner();  
}