import 'package:hive/hive.dart';

part 'user.g.dart';

@HiveType(typeId: 2)
class User extends HiveObject {
  @HiveField(0)
  String id;
  @HiveField(1)
  String fullname;
  @HiveField(2)
  String username;
  @HiveField(3)
  String role;

  User(
      {required this.fullname,
      required this.id,
      required this.username,
      this.role = 'normal'});
  factory User.fromJson(Map<String, dynamic> json) {
    print('${json}\n');
    return User(
      id: json['_id'] ?? '',
      fullname: json['fullName'] ?? '',
      username: json['userName'] ?? '',
      role: json['role'] ?? 'normal');
  }

  factory User.fromSocketJson(Map<String, dynamic> json) => User(
      id: json['userId'],
      fullname: json['fullname'],
      username: json['username']);

      factory User.fromMakeRoomJson(Map<String, dynamic> json) => User(
      id: json['userId'] ?? '',
      fullname: json['fullName'] ?? '',
      username: json['userName'] ?? '',
      role: json['role'] ?? 'normal');
}
