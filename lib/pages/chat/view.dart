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
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      chatGet.room != null
                          ? (chatGet.room?.name ?? '')
                          : (chatGet.user?.fullname ?? ''),
                      style: MyTextStyles.button.copyWith(color: Colors.black)),
                  if (chatGet.room != null)
                    Text('${chatGet.room!.members.length} members',
                        style: MyTextStyles.button.copyWith(
                            color: Colors.black,
                            fontWeight: FontWeight.w300,
                            fontSize: 12))
                ],
              ),
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
                      return chatGet.room != null
                          ? Padding(
                              padding: const EdgeInsets.only(bottom: 15, left: 10),
                              child: Column(
                                children: [
                                  if (!isMyMessage)
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 10),
                                      child: Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 10, left: 10),
                                            child: CircleAvatar(
                                                radius: 16,
                                                backgroundColor:
                                                    Colors.grey.shade300),
                                          ),
                                          Text(message.user.fullname,
                                              style: MyTextStyles.small
                                                  .copyWith(
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                        ],
                                      ),
                                    ),
                                  chatBubble(isMyMessage, message)
                                ],
                              ),
                            )
                          : chatBubble(isMyMessage, message);
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
                                : (chatGet.room != null)
                                    ? chatGet.sendMessageInRoom
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
  } // end build

  Widget chatBubble(bool isMyMessage, var message) => ChatBubble(
        backGroundColor:
            isMyMessage ? MyColors.primaryColor : Colors.grey.shade400,
        margin: isMyMessage
            ? const EdgeInsets.only(bottom: 10, right: 20)
            : const EdgeInsets.only(bottom: 10, left: 20),
        padding: isMyMessage
            ? const EdgeInsets.only(left: 10, right: 20, bottom: 10, top: 10)
            : const EdgeInsets.only(left: 20, right: 10, bottom: 10, top: 10),
        clipper: ChatBubbleClipper4(
            type:
                isMyMessage ? BubbleType.sendBubble : BubbleType.receiverBubble,
            radius: 10),
        alignment: isMyMessage ? Alignment.centerRight : Alignment.centerLeft,
        child: Text(message.message, style: MyTextStyles.chat),
      );
}
