import 'package:chatify/constants/config.dart';
import 'package:chatify/services/register.service.dart';
import 'package:get/get.dart';

class RegisterGet extends GetxController {
  var fullname = ''.obs;
  var username = ''.obs;
  var password = ''.obs;

  var loading = false.obs;

  void createNewAccount() async {
    if (fullname.value.isEmpty ||
        username.value.isEmpty ||
        password.value.isEmpty) {
      Config.errorHandler(
          title: 'Empty fields', message: 'Please enter all the fields!');
      return;
    }

    if (!loading.value) {
      loading.value = true;

      try {
        final service = RegisterService();
        await service.call({
          'fullname': fullname.value,
          'username': username.value,
          'password': password.value
        });
        loading.value = false;
        Get.offAllNamed(PageRoutes.messages);
      } catch (er) {
        Config.errorHandler(title: 'Error', message: er.toString());
        loading.value = false;
      }
    }
  }
}
