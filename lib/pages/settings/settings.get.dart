import 'package:chatify/cacheManager/hive.cache.dart';
import 'package:chatify/cacheManager/user.cache.dart';
import 'package:chatify/constants/config.dart';
import 'package:get/get.dart';

class SettingsGet extends GetxController {
  void logout() async {
    await UserCacheManager.clear();
    await HiveCacheManager().clearAll();
    Config.me = null;
    Get.offAllNamed(PageRoutes.splash);
  }
}
