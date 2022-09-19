import 'package:chatify/models/room.dart';
import 'package:get/get.dart';

class RoomPropertiesGet extends GetxController {
  Room? room;

  @override
  void onInit() {
    room = Get.arguments;
    super.onInit();
  }

  void deleteRoom() async {}
  void leaveRoom() async {}
}
