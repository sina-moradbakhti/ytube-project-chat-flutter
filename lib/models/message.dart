import 'package:chatify/constants/config.dart';
import 'package:chatify/models/user.dart';
import 'package:hive/hive.dart';

part 'message.g.dart';

@HiveType(typeId: 1)
class Message extends HiveObject {
  @HiveField(0)
  final User user;
  @HiveField(1)
  final String message;
  @HiveField(2)
  final DateTime date;
  @HiveField(3)
  bool seen = false;

  Message(
      {required this.date,
      required this.message,
      required this.user,
      this.seen = false});
  factory Message.fromJson(Map<String, dynamic> json) => Message(
      date: DateTime.now(),
      message: json['message'],
      user: User.fromSocketJson(json['from']),
      seen: false);

  bool isMyMessage() {
    return Config.me!.userId == user.id;
  }
}
