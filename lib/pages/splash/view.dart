import 'package:chatify/components/loading.dart';
import 'package:chatify/pages/splash/splash.get.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Splash extends StatelessWidget {
  Splash({Key? key}) : super(key: key);

  final splashGet = Get.put(SplashGet());

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: MyLoading(),
      ),
    );
  }
}
