import 'package:chatify/components/buttons/primary_button.dart';
import 'package:chatify/components/buttons/underline_button.dart';
import 'package:chatify/components/loading.dart';
import 'package:chatify/components/textfields/primary_textfield.dart';
import 'package:chatify/constants/text_styles.dart';
import 'package:chatify/pages/register/register.get.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Register extends StatelessWidget {
  Register({Key? key}) : super(key: key);

  final registerGet = RegisterGet();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
        leading: IconButton(
          padding: EdgeInsets.zero,
          onPressed: () => Get.back(),
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          bottom: false,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.only(bottom: 100, top: 100),
                child: CircleAvatar(
                  radius: 60,
                  backgroundColor: Colors.black,
                  child: Icon(CupertinoIcons.person_add,
                      size: 80, color: Colors.white),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: Column(
                  children: [
                    PrimaryTextfield(
                      maxLength: 30,
                      hint: 'Enter Full name',
                      onChanged: (newVal) =>
                          registerGet.fullname.value = newVal,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 15.0),
                      child: PrimaryTextfield(
                        hint: 'Enter Username',
                        prefixIcon: CupertinoIcons.person,
                        onChanged: (newVal) =>
                            registerGet.username.value = newVal,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 15.0),
                      child: PrimaryTextfield(
                        hint: 'Enter Password',
                        isPassword: true,
                        prefixIcon: CupertinoIcons.lock,
                        onChanged: (newVal) =>
                            registerGet.password.value = newVal,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 30.0),
                      child: Obx(() => registerGet.loading.value
                          ? MyLoading()
                          : PrimaryButton(
                              title: 'Create New Account',
                              onPressed: registerGet.createNewAccount)),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: UnderlineButton(
                          title: 'You already registered?', onPressed: () {}),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget get _title => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              'Welcome to',
              style: MyTextStyles.caption,
            ),
            Text(
              'Chatify App',
              style: MyTextStyles.header,
            ),
          ],
        ),
      );

  Widget get _logo => Center(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: SizedBox(
            width: 100,
            height: 100,
            child: Image.asset('assets/images/png/chatify_logo.png'),
          ),
        ),
      );

  Widget get _buttons => Column(
        children: [
          PrimaryButton(title: 'Sign In', onPressed: () {}),
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child:
                UnderlineButton(title: 'Create new account?', onPressed: () {}),
          ),
        ],
      );
}
