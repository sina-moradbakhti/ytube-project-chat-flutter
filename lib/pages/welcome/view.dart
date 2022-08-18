import 'package:chatify/components/buttons/primary_button.dart';
import 'package:chatify/components/buttons/underline_button.dart';
import 'package:chatify/constants/config.dart';
import 'package:chatify/constants/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Welcome extends StatelessWidget {
  const Welcome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              children: [_logo, _title],
            ),
            _buttons
          ],
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
          PrimaryButton(
              title: 'Sign In',
              onPressed: () => Get.toNamed(PageRoutes.signIn)),
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: UnderlineButton(
                title: 'Create new account?',
                onPressed: () => Get.toNamed(PageRoutes.register)),
          ),
        ],
      );
}
