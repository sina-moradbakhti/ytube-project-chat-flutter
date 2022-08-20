import 'package:chatify/constants/config.dart';
import 'package:chatify/models/user.dart';

class Message {
  final User user;
  final String message;
  final DateTime date;

  Message({required this.date, required this.message, required this.user});
  factory Message.fromJson(Map<String, dynamic> json) => Message(
      date: DateTime.now(),
      message: json['message'],
      user: User.fromSocketJson(json['from']));

  bool isMyMessage() {
    return Config.me!.userId == user.id;
  }
}
