import 'package:chatify/models/contact.dart';
import 'package:chatify/models/message.dart';
import 'package:chatify/models/room.dart';
import 'package:chatify/models/user.dart';
import 'package:hive/hive.dart';

class HiveCacheManager {
  static final HiveCacheManager _singleton = HiveCacheManager._internal();
  factory HiveCacheManager() {
    return _singleton;
  }
  HiveCacheManager._internal();

  Box<Contact>? contactsBox;
  Box<Room>? roomsBox;

  init() async {
    contactsBox = await Hive.openBox<Contact>('contacts');
    roomsBox = await Hive.openBox<Room>('rooms');
  }

  save(Contact contact) async {
    await init();
    if (contactsBox != null && contactsBox!.isOpen) {
      final result = contactsBox!.get(contact.user.id);
      if (result == null) {
        await contactsBox!.put(contact.user.id, contact);
      } else {
        result.messages.addAll(contact.messages);
        await contactsBox!.put(contact.user.id, result);
      }
    }
  }

  saveRoom(Room room) async {
    await init();
    if (roomsBox != null && roomsBox!.isOpen) {
      final result = roomsBox!.get(room.id);
      if (result == null) {
        await roomsBox!.put(room.id, room);
      } else {
        List<User> newMembers = [];
        for (final newMember in room.members) {
          if (result.members
              .where((element) => element.id == newMember.id)
              .toList()
              .isEmpty) {
            newMembers.add(newMember);
          }
        }
        result.members.addAll(newMembers);
        result.messages.addAll(room.messages);
        await roomsBox!.put(room.id, result);
      }
    }
  }

  update(String userId, Message msg) async {
    await init();
    if (contactsBox != null && contactsBox!.isOpen) {
      final contact = contactsBox!.get(userId);
      contact!.messages.add(msg);
      await contactsBox!.put(userId, contact);
    }
  }

  updateLastSeen(String userId) async {
    await init();
    if (contactsBox != null && contactsBox!.isOpen) {
      final contact = contactsBox!.get(userId);
      for (int i = 0; i < contact!.messages.length; i++) {
        contact.messages[i].seen = true;
      }
      await contactsBox!.put(userId, contact);
    }
  }

  Future<Contact?> get(String userId) async {
    await init();
    if (contactsBox != null && contactsBox!.isOpen) {
      return contactsBox!.get(userId);
    } else {
      return null;
    }
  }

  Future<List<Contact>> getAll() async {
    await init();
    if (contactsBox != null && contactsBox!.isOpen) {
      return contactsBox!.values.toList();
    } else {
      return [];
    }
  }

  Future<List<Room>> getAllRooms() async {
    await init();
    if (roomsBox != null && roomsBox!.isOpen) {
      return roomsBox!.values.toList();
    } else {
      return [];
    }
  }

  clearAll() async {
    await init();
    await contactsBox!.clear();
    contactsBox = null;
  }
}
