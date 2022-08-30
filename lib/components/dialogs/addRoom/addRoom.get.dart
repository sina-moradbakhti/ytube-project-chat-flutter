import 'dart:io';

import 'package:chatify/cacheManager/hive.cache.dart';
import 'package:chatify/components/dialogs/editMembers/editMembers.dialog.dart';
import 'package:chatify/constants/config.dart';
import 'package:chatify/models/contact.dart';
import 'package:chatify/models/member.dart';
import 'package:chatify/models/room.dart';
import 'package:chatify/pages/messages/messages.get.dart';
import 'package:chatify/services/newRoom.service.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rxdart/subjects.dart';

class AddRoomGet extends GetxController {
  var roomName = ''.obs;
  var roomDescription = ''.obs;
  var loading = false.obs;
  List<Member> members = [];
  PublishSubject<bool> listUpdateStream = PublishSubject<bool>();

  Rx<File?> profileAvatar = File('').obs;

  void uploadAvatar() async {
    final imagePicker = ImagePicker();
    final XFile? pickedFile = await imagePicker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 60,
        maxHeight: 300,
        maxWidth: 300);
    if (pickedFile != null) profileAvatar.value = File(pickedFile.path);
  }

  void add() async {
    if (roomName.value.isEmpty) {
      Config.errorHandler(
          message: 'You have to enter a room Name!', title: 'Error');
      return;
    }
    if (!loading.value) {
      loading.value = true;
      try {
        final service = NewRoomService();
        final result = await service.call({
          'roomAvatar': profileAvatar.value?.path ?? '',
          'userId': Config.me?.userId ?? '',
          'roomName': roomName.value,
          'roomDesc': roomDescription.value,
          'roomMembers': [
            for (final userItem in members)
              {'userId': userItem.user.id, 'role': 'normal'}
          ]..add({'userId': (Config.me?.userId ?? ''), 'role': 'admin'})
        });
        loading.value = false;
        if (result != null) {
          final messagesGet = Get.find<MessagesGet>();
          await HiveCacheManager().saveRoom(Room(
              creator: Config.me!.exportToUser(),
              name: roomName.value,
              desc: roomDescription.value,
              members: result['members'],
              id: result['roomId']));
          messagesGet.init();
          Get.back();
        }
      } catch (er) {
        print(er);
        loading.value = false;
      }
    }
  }

  void editMemebrs() {
    Get.dialog(
        EditMemberDialog(
            members: members,
            onSelectedMembers: (selectedMembers) {
              members.clear();
              members.addAll(selectedMembers);
              listUpdateStream.sink.add(true);
            }),
        barrierDismissible: true);
  }
}
