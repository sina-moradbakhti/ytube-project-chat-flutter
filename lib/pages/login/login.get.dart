import 'package:chatify/cacheManager/user.cache.dart';
import 'package:chatify/constants/config.dart';
import 'package:chatify/services/login.service.dart';
import 'package:get/get.dart';

class LoginGet extends GetxController {
  var username = ''.obs;
  var password = ''.obs;

  var loading = false.obs;

  void loginToAccount() async {
    if (username.value.isEmpty || password.value.isEmpty) {
      Config.errorHandler(
          title: 'Empty fields', message: 'Please enter all the fields!');
      return;
    }

    if (!loading.value) {
      loading.value = true;

      try {
        final service = LoginService();
        final result = await service
            .call({'username': username.value, 'password': password.value});
        loading.value = false;
        if (result) {
          Config.me = UserCacheManager.getUserData();
          Get.offAllNamed(PageRoutes.splash);
        }
      } catch (er) {
        Config.errorHandler(title: 'Error', message: er.toString());
        loading.value = false;
      }
    }
  }
}
