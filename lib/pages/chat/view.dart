import 'package:chatify/constants/colors.dart';
import 'package:chatify/constants/text_styles.dart';
import 'package:chatify/pages/chat/chat.get.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/bubble_type.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:flutter_chat_bubble/clippers/chat_bubble_clipper_4.dart';
import 'package:get/get.dart';

class Chat extends StatelessWidget {
  Chat({Key? key}) : super(key: key);

  final chatGet = Get.put(ChatGet());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: chatGet.userInfo,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: CircleAvatar(
                    radius: 20, backgroundColor: Colors.grey.shade300),
              ),
              Text(chatGet.user?.fullname ?? '',
                  style: MyTextStyles.button.copyWith(color: Colors.black))
            ],
          ),
        ),
        leading: IconButton(
          padding: EdgeInsets.zero,
          onPressed: () => Get.back(),
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          StreamBuilder<bool>(
              stream: chatGet.onUpdateStream.stream,
              builder: (context, snapshot) {
                final count = chatGet.messages.length;
                return ListView.builder(
                    physics: const ClampingScrollPhysics(),
                    padding: const EdgeInsets.only(bottom: 150),
                    controller: chatGet.scrollController,
                    itemCount: count,
                    itemBuilder: (context, index) {
                      final message = chatGet.messages[index];
                      final isMyMessage = message.isMyMessage();
                      return ChatBubble(
                        backGroundColor: isMyMessage
                            ? MyColors.primaryColor
                            : Colors.grey.shade400,
                        margin: isMyMessage
                            ? const EdgeInsets.only(bottom: 10, right: 10)
                            : const EdgeInsets.only(bottom: 10, left: 10),
                        padding: const EdgeInsets.all(16),
                        clipper: ChatBubbleClipper4(
                            type: isMyMessage
                                ? BubbleType.sendBubble
                                : BubbleType.receiverBubble,
                            radius: 10),
                        alignment: isMyMessage
                            ? Alignment.centerRight
                            : Alignment.centerLeft,
                        child:
                            Text(message.message, style: MyTextStyles.button),
                      );
                    });
              }),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                  color: Colors.white,
                  border:
                      Border(top: BorderSide(width: 0.5, color: Colors.grey))),
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: TextField(
                    controller: chatGet.controller,
                    onChanged: (newVal) => chatGet.message.value = newVal,
                    minLines: 1,
                    maxLines: 8,
                    style: MyTextStyles.textfield
                        .copyWith(fontWeight: FontWeight.bold),
                    decoration: InputDecoration(
                        hintText: 'Write a message...',
                        border: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        suffixIcon: Obx(() => IconButton(
                            onPressed: chatGet.message.value.isEmpty
                                ? null
                                : chatGet.send,
                            icon: Icon(
                              Icons.send,
                              color: chatGet.message.value.isEmpty
                                  ? Colors.grey.shade400
                                  : MyColors.primaryColor,
                            )))),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
