import '../../interfaces/interfaces.dart';

class TopAuthor extends Profile {
  const TopAuthor({
    required int userId,
    required double rating,
    required String avatar,
    required String firstname,
    required String lastname,
    required int followers,
  }): super(
    userId: userId,
    rating: rating,
    avatar: avatar,
    firstname: firstname,
    lastname: lastname,
    followers: followers
  );

  factory TopAuthor.fromJson(Map<String, dynamic> data) => TopAuthor(
    userId: data['user_id'],
    rating: data['rating'],
    avatar: data['avatar'],
    firstname: data['firstname'],
    lastname: data['lastname'],
    followers: data['followers']
  );

  @override
  Map<String, dynamic> toJson() => {};

  @override
  List<Object> get props => [userId!];
}