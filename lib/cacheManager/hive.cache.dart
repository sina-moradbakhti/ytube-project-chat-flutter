import 'package:chatify/models/contact.dart';
import 'package:chatify/models/message.dart';
import 'package:hive/hive.dart';

class HiveCacheManager {
  static final HiveCacheManager _singleton = HiveCacheManager._internal();
  factory HiveCacheManager() {
    return _singleton;
  }
  HiveCacheManager._internal();

  Box<Contact>? contactsBox;

  init() async {
    contactsBox = await Hive.openBox<Contact>('contacts');
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

  clearAll() async {
    await init();
    await contactsBox!.clear();
    contactsBox = null;
  }
}
