import 'package:chatify/cacheManager/hive.cache.dart';
import 'package:chatify/components/dialogs/addContact/addContact.dialog.dart';
import 'package:chatify/models/contact.dart';
import 'package:get/get.dart';
import 'package:rxdart/subjects.dart';

class MessagesGet extends GetxController {
  PublishSubject<bool> contactsStream = PublishSubject<bool>();
  List<Contact> contacts = [];
  @override
  void onInit() {
    init();
    super.onInit();
  }

  void init() async {
    final list = await HiveCacheManager().getAll();
    contacts.clear();
    contacts.addAll(list);
    contactsStream.sink.add(true);
  }

  void addContact() {
    Get.dialog(AddContactDialog(), barrierDismissible: true);
  }
}
