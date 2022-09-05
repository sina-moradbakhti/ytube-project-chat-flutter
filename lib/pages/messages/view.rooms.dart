import 'package:chatify/components/buttons/underline_button.dart';
import 'package:chatify/components/room.widget.dart';
import 'package:chatify/constants/text_styles.dart';
import 'package:chatify/pages/messages/messages.get.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MessagesRoomsTab extends StatelessWidget {
  MessagesRoomsTab({Key? key}) : super(key: key);

  final messagesGet = Get.find<MessagesGet>();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 60),
      child: StreamBuilder(
          stream: messagesGet.roomStream.stream,
          builder: (context, snapshot) => messagesGet.rooms.isNotEmpty
              ? ListView.builder(
                  itemBuilder: (context, index) => RoomWidget(
                        room: messagesGet.rooms[index],
                      ),
                  itemCount: messagesGet.rooms.length)
              : _emptyWidget),
    );
  }

  Widget get _emptyWidget => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              CupertinoIcons.group,
              size: 70,
              color: Colors.grey.shade300,
            ),
            Text(
              'No Rooms!',
              style: MyTextStyles.headline
                  .copyWith(color: Colors.grey, fontSize: 22),
            ),
            UnderlineButton(
              title: 'Make new one',
              onPressed: messagesGet.addRoom,
            )
          ],
        ),
      );
}
