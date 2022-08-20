import 'package:chatify/models/user.dart';

class Me {
  String userId;
  String fullname;
  String username;
  String token;

  Me(
      {required this.token,
      required this.fullname,
      required this.userId,
      required this.username});

  User exportToUser() {
    return User(id: userId, fullname: fullname, username: username);
  }
}
