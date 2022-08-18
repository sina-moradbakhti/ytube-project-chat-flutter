import 'package:chatify/components/buttons/primary_button.dart';
import 'package:chatify/components/buttons/underline_button.dart';
import 'package:chatify/components/loading.dart';
import 'package:chatify/components/textfields/primary_textfield.dart';
import 'package:chatify/constants/config.dart';
import 'package:chatify/constants/text_styles.dart';
import 'package:chatify/pages/settings/setting_item.widget.dart';
import 'package:chatify/pages/settings/settings.get.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Settings extends StatelessWidget {
  Settings({Key? key}) : super(key: key);

  final settingsGet = SettingsGet();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        leading: IconButton(
          padding: EdgeInsets.zero,
          onPressed: () => Get.back(),
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 50, top: 15),
              child: Text(Config.me!.fullname, style: MyTextStyles.header),
            ),
            SettingItemWidget(
              onTapped: () {},
              title: 'Privacy Policy',
            ),
            SettingItemWidget(
              onTapped: () => settingsGet.logout(),
              title: 'Sign out',
              isInRed: true,
              prefixIcon: Icons.exit_to_app_rounded,
            )
          ],
        ),
      ),
    );
  }
}
