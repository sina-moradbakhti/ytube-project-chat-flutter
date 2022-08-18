import 'package:chatify/components/buttons/primary_button.dart';
import 'package:chatify/components/buttons/underline_button.dart';
import 'package:chatify/components/loading.dart';
import 'package:chatify/components/textfields/primary_textfield.dart';
import 'package:chatify/constants/text_styles.dart';
import 'package:chatify/pages/login/login.get.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Login extends StatelessWidget {
  Login({Key? key}) : super(key: key);

  final loginGet = LoginGet();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign In'),
        leading: IconButton(
          padding: EdgeInsets.zero,
          onPressed: () => Get.back(),
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.only(bottom: 50),
              child: CircleAvatar(
                radius: 60,
                backgroundColor: Colors.black,
                child: Icon(CupertinoIcons.lock_shield,
                    size: 80, color: Colors.white),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Column(
                children: [
                  PrimaryTextfield(
                    hint: 'Enter Username',
                    prefixIcon: CupertinoIcons.person,
                    onChanged: (newVal) => loginGet.username.value = newVal,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 15.0),
                    child: PrimaryTextfield(
                      hint: 'Enter Password',
                      isPassword: true,
                      prefixIcon: CupertinoIcons.lock,
                      onChanged: (newVal) => loginGet.password.value = newVal,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 30.0),
                    child: Obx(() => loginGet.loading.value
                        ? const MyLoading()
                        : PrimaryButton(
                            title: 'Sign In',
                            onPressed: loginGet.loginToAccount)),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: UnderlineButton(
                        title: 'Forgot password?', onPressed: () {}),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
