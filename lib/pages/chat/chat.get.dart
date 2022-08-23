import 'package:chatify/cacheManager/hive.cache.dart';
import 'package:chatify/constants/config.dart';
import 'package:chatify/init.dart';
import 'package:chatify/models/contact.dart';
import 'package:chatify/models/message.dart';
import 'package:chatify/models/user.dart';
import 'package:chatify/pages/messages/messages.get.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rxdart/subjects.dart';

class ChatGet extends GetxController {
  User? user;
  Contact? contact;
  var message = ''.obs;
  TextEditingController controller = TextEditingController();
  ScrollController scrollController = ScrollController();
  AppInit appInit = AppInit();
  List<Message> messages = [];
  final onUpdateStream = PublishSubject<bool>();

  @override
  void onInit() {
    user = Get.arguments;
    appInit.currentChatUser = user;

    onUpdateStream.listen((_) {
      Future.delayed(const Duration(milliseconds: 100)).then((_) =>
          scrollController.jumpTo(scrollController.position.maxScrollExtent));
    });

    initContact();

    super.onInit();
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
    super.dispose();
  }

  void userInfo() {}

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
  }
}
