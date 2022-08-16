import 'package:chatify/components/buttons/primary_button.dart';
import 'package:chatify/components/buttons/underline_button.dart';
import 'package:chatify/components/textfields/primary_textfield.dart';
import 'package:chatify/constants/text_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign In'),
        leading: IconButton(
          padding: EdgeInsets.zero,
          onPressed: () {},
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
                  const PrimaryTextfield(
                      hint: 'Enter Username',
                      prefixIcon: CupertinoIcons.person),
                  const Padding(
                    padding: EdgeInsets.only(top: 15.0),
                    child: PrimaryTextfield(
                        hint: 'Enter Password',
                        isPassword: true,
                        prefixIcon: CupertinoIcons.lock),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 30.0),
                    child: PrimaryButton(title: 'Sign In', onPressed: () {}),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: UnderlineButton(title: 'Forgot password?', onPressed: () {}),
                  ),
                ],
              ),
            )
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
          PrimaryButton(title: 'Sign In', onPressed: () {}),
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child:
                UnderlineButton(title: 'Create new account?', onPressed: () {}),
          ),
        ],
      );
}
