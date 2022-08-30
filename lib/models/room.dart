import 'package:chatify/models/message.dart';
import 'package:chatify/models/user.dart';
import 'package:hive/hive.dart';

part 'room.g.dart';

@HiveType(typeId: 4)
class Room extends HiveObject {
  @HiveField(0)
  final User creator;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String desc;
  @HiveField(3)
  final List<User> members;
  @HiveField(4)
  final String id;
  @HiveField(5)
  List<Message> messages = [];

  Room(
      {required this.creator,
      required this.name,
      required this.desc,
      required this.members,
      required this.id,
      this.messages = const []});
}
