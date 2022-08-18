import 'package:chatify/cacheManager/user.cache.dart';
import 'package:chatify/constants/config.dart';
import 'package:chatify/pages/login/view.dart';
import 'package:chatify/pages/messages/view.dart';
import 'package:chatify/pages/register/view.dart';
import 'package:chatify/pages/settings/view.dart';
import 'package:chatify/pages/splash/view.dart';
import 'package:chatify/pages/welcome/view.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Chatify',
      theme: Config.primaryThemeData,
      initialRoute: PageRoutes.splash,
      getPages: [
        GetPage(name: PageRoutes.welcome, page: () => const Welcome()),
        GetPage(name: PageRoutes.register, page: () => Register()),
        GetPage(name: PageRoutes.signIn, page: () => Login()),
        GetPage(name: PageRoutes.messages, page: () => Messages()),
        GetPage(name: PageRoutes.settings, page: () => Settings()),
        GetPage(name: PageRoutes.splash, page: () => Splash()),
      ],
    );
  }
}
