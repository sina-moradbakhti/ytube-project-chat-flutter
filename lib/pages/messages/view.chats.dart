import 'package:chatify/components/buttons/underline_button.dart';
import 'package:chatify/components/message.widget.dart';
import 'package:chatify/constants/text_styles.dart';
import 'package:chatify/pages/messages/messages.get.dart';
import 'package:flutter/cupertino.dart';
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
          builder: (context, snapshot) => messagesGet.contacts.isNotEmpty
              ? ListView.builder(
                  itemBuilder: (context, index) => MessageWidget(
                        contact: messagesGet.contacts[index],
                      ),
                  itemCount: messagesGet.contacts.length)
              : _emptyWidget),
    );
  }

  Widget get _emptyWidget => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              CupertinoIcons.chat_bubble_2,
              size: 70,
              color: Colors.grey.shade300,
            ),
            Text(
              'No Chats!',
              style: MyTextStyles.headline
                  .copyWith(color: Colors.grey, fontSize: 22),
            ),
            UnderlineButton(
              title: 'Add Contact to chat',
              onPressed: messagesGet.addContact,
            )
          ],
        ),
      );
}
