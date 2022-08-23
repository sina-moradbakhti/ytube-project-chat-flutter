import 'package:chatify/models/message.dart';
import 'package:chatify/models/user.dart';
import 'package:hive/hive.dart';

part 'contact.g.dart';

@HiveType(typeId: 3)
class Contact extends HiveObject {
  @HiveField(0)
  final User user;
  @HiveField(1)
  List<Message> messages = [];

  Contact({required this.user, this.messages = const []});
}
