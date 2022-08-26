import 'package:chatify/constants/config.dart';
import 'package:chatify/constants/text_styles.dart';
import 'package:chatify/pages/settings/setting_item.widget.dart';
import 'package:chatify/pages/settings/settings.get.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';

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
                padding: const EdgeInsets.only(bottom: 30, top: 15),
                child: MaterialButton(
                  padding: EdgeInsets.zero,
                  onPressed: settingsGet.uploadAvatar,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(80)),
                  child: Obx(() => (settingsGet.profileAvatar.value != null &&
                          settingsGet.profileAvatar.value!.path != '')
                      ? CircleAvatar(
                          backgroundColor: Colors.grey.shade300,
                          radius: 80,
                          backgroundImage:
                              FileImage(settingsGet.profileAvatar.value!),
                        )
                      : CircleAvatar(
                          backgroundColor: Colors.grey.shade300,
                          radius: 80,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(80),
                            child: CachedNetworkImage(
                              imageUrl:
                                  Config.showAvatarBaseUrl(Config.me!.userId),
                              errorWidget: (context, url, error) => Icon(
                                  Icons.person,
                                  color: Colors.grey.shade400,
                                  size: 50),
                            ),
                          ),
                        )),
                )),
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
