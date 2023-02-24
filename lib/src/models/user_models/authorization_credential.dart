import 'package:joyvee/src/interfaces/interfaces.dart';

class AuthorizationCredentials extends User {
  final String password;
  AuthorizationCredentials({
    required String email,
    required this.password
  }) : super(email: email);

  @override
  Map<String, dynamic> toJson() => {
    "email": email,
    "password": password,
  };
}