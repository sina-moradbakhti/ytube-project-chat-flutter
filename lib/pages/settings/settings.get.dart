import 'dart:io';
import 'package:chatify/cacheManager/hive.cache.dart';
import 'package:chatify/cacheManager/user.cache.dart';
import 'package:chatify/constants/config.dart';
import 'package:chatify/services/uploadServices.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class SettingsGet extends GetxController {
  Rx<File?> profileAvatar = File('').obs;

  void uploadAvatar() async {
    final imagePicker = ImagePicker();
    final XFile? pickedFile = await imagePicker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 60,
        maxHeight: 300,
        maxWidth: 300);

    if (pickedFile != null) {
      final uploadService = UploadServices();
      final uploadResult = await uploadService
          .call({'userId': Config.me!.userId, 'avatar': pickedFile.path});
      if (uploadResult) {
        profileAvatar.value = File(pickedFile.path);
      }
    }
  }

  void logout() async {
    await UserCacheManager.clear();
    await HiveCacheManager().clearAll();
    Config.me = null;
    Get.offAllNamed(PageRoutes.splash);
  }
}
