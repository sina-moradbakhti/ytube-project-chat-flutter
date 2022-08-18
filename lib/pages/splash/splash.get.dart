import 'package:chatify/cacheManager/user.cache.dart';
import 'package:chatify/constants/config.dart';
import 'package:chatify/init.dart';
import 'package:get/get.dart';

class SplashGet extends GetxController {
  @override
  void onInit() {
    _init();
    super.onInit();
  }

  void _init() async {
    await UserCacheManager.checkLogin();
    if (UserCacheManager.isUserLoggedIn) {
      Config.me = UserCacheManager.getUserData();
      AppInit().initSocketClient();
      Get.offAllNamed(PageRoutes.messages);
    } else {
      Get.offAllNamed(PageRoutes.welcome);
    }
  }
}
