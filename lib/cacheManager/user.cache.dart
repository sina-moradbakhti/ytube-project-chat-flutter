import 'package:get_storage/get_storage.dart';

class UserCacheManager {
  UserCacheManager._();

  static bool isUserLoggedIn = false;

  static const String USER_ID_KEY = '--user-id-key';
  static const String USER_NAME_KEY = '--user-name-key';
  static const String USER_FULLNAME_KEY = '--user-fullname-key';
  static const String USER_TOKEN_KEY = '--user-token-key';

  static Future<void> save(
      {String userId = '',
      String fullname = '',
      String username = '',
      String token = ''}) async {
    final box = GetStorage();
    await box.write(USER_ID_KEY, userId);
    await box.write(USER_FULLNAME_KEY, fullname);
    await box.write(USER_NAME_KEY, username);
    await box.write(USER_TOKEN_KEY, token);
  }

  static Future<void> checkLogin() async {
    final box = GetStorage();
    final userId = await box.read(USER_ID_KEY);
    UserCacheManager.isUserLoggedIn = userId != null;
  }
}
