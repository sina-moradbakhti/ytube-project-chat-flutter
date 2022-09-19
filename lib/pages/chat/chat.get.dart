import 'package:chatify/cacheManager/hive.cache.dart';
import 'package:chatify/constants/config.dart';
import 'package:chatify/init.dart';
import 'package:chatify/models/contact.dart';
import 'package:chatify/models/message.dart';
import 'package:chatify/models/room.dart';
import 'package:chatify/models/user.dart';
import 'package:chatify/pages/messages/messages.get.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rxdart/subjects.dart';

class ChatGet extends GetxController {
  User? user;
  Room? room;
  Contact? contact;
  var message = ''.obs;
  TextEditingController controller = TextEditingController();
  ScrollController scrollController = ScrollController();
  AppInit appInit = AppInit();
  List<Message> messages = [];
  final onUpdateStream = PublishSubject<bool>();

  final messagesGet = Get.find<MessagesGet>();

  @override
  void onInit() {
    if (Get.arguments.runtimeType == Room) {
      room = Get.arguments;
      appInit.currentChatRoom = room;
      initRoom();
    } else {
      user = Get.arguments;
      appInit.currentChatUser = user;
      initContact();
    }

    onUpdateStream.listen((_) {
      Future.delayed(const Duration(milliseconds: 100)).then((_) =>
          scrollController.jumpTo(scrollController.position.maxScrollExtent));
    });

    super.onInit();
  }

  void initRoom() async {
    room = await HiveCacheManager().getRoom(room?.id ?? '');

    await HiveCacheManager().updateLastSeenRoom(room?.id ?? '');
    (Get.find<MessagesGet>()).roomStream.sink.add(true);

    messages.clear();
    messages.addAll(room?.messages ?? []);
    onUpdateStream.sink.add(true);

    Future.delayed(const Duration(milliseconds: 100)).then((_) =>
        scrollController.jumpTo(scrollController.position.maxScrollExtent));
  }

  void initContact() async {
    contact = await HiveCacheManager().get(user!.id);

    await HiveCacheManager().updateLastSeen(user!.id);
    (Get.find<MessagesGet>()).contactsStream.sink.add(true);

    messages.clear();
    messages.addAll(contact?.messages ?? []);
    onUpdateStream.sink.add(true);

    Future.delayed(const Duration(milliseconds: 100)).then((_) =>
        scrollController.jumpTo(scrollController.position.maxScrollExtent));
  }

  @override
  void dispose() {
    appInit.currentChatUser = null;
    appInit.currentChatRoom = null;
    super.dispose();
  }

  void userInfo() {
    if (contact == null) {
      Get.toNamed(PageRoutes.roomProperties, arguments: room!);
    } else {
      Get.toNamed(PageRoutes.contactProperties, arguments: contact!);
    }
  }

  void send() {
    if (message.value.isEmpty) return;
    appInit.socket?.emit(
        'send-message', {'message': message.value, 'to': user?.id ?? ''});
    final myMsg = Message(
        date: DateTime.now(),
        message: message.value,
        user: Config.me!.exportToUser(),
        seen: true);
    messages.add(myMsg);

    HiveCacheManager().update(user!.id, myMsg);

    message.value = '';
    controller.clear();
    onUpdateStream.sink.add(true);
    messagesGet.contactsStream.sink.add(true);
  }

  void sendMessageInRoom() {
    if (message.value.isEmpty) return;
    appInit.socket?.emit(
        'send-message', {'message': message.value, 'roomId': room?.id ?? ''});
    final myMsg = Message(
        date: DateTime.now(),
        message: message.value,
        user: Config.me!.exportToUser(),
        seen: true,
        roomId: room?.id ?? '');
    messages.add(myMsg);

    HiveCacheManager().updateRoom(room!.id, myMsg);

    message.value = '';
    controller.clear();
    onUpdateStream.sink.add(true);
    messagesGet.roomStream.sink.add(true);
  }
}
