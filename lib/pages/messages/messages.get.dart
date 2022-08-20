import 'package:chatify/components/dialogs/addContact/addContact.dialog.dart';
import 'package:get/get.dart';

class MessagesGet extends GetxController {
  void addContact() {
    Get.dialog(AddContactDialog(), barrierDismissible: true);
  }
}
