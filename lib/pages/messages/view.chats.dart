import 'package:chatify/components/message.widget.dart';
import 'package:chatify/pages/messages/messages.get.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MessagesChatsTab extends StatelessWidget {
  MessagesChatsTab({Key? key}) : super(key: key);

  final messagesGet = Get.find<MessagesGet>();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 60),
      child: StreamBuilder(
          stream: messagesGet.contactsStream.stream,
          builder: (context, snapshot) => ListView.builder(
              itemBuilder: (context, index) => MessageWidget(
                    contact: messagesGet.contacts[index],
                  ),
              itemCount: messagesGet.contacts.length)),
    );
  }
}
