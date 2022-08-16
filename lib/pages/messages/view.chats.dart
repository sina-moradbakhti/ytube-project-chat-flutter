import 'package:chatify/components/message.widget.dart';
import 'package:flutter/material.dart';

class MessagesChatsTab extends StatelessWidget {
  MessagesChatsTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 60),
      child: ListView.builder(
          itemBuilder: (context, index) => MessageWidget(), itemCount: 2),
    );
  }
}
