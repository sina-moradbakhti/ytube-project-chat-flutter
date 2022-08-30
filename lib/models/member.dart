import 'package:chatify/models/user.dart';

class Member {
  final User user;
  bool isSelected;

  Member({required this.user, this.isSelected = false});
}
