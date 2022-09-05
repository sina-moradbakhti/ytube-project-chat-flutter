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
  @HiveField(4)
  String roomId = "";
  @HiveField(5)
  String replyTo = "";
  @HiveField(6)
  String chatType = "ChatType.message";

  Message(
      {required this.date,
      required this.message,
      required this.user,
      this.roomId = "",
      this.replyTo = "",
      this.chatType = "ChatType.message",
      this.seen = false});
  factory Message.fromJson(Map<String, dynamic> json) => Message(
      date: DateTime.now(),
      message: json['message'],
      user: User.fromSocketJson(json['from']),
      seen: false,
      roomId: json['roomId'] ?? '',
      replyTo: json['replyTo'] ?? '',
      chatType: json['chatType'] ?? '');

  bool isMyMessage() {
    return Config.me!.userId == user.id;
  }
}
