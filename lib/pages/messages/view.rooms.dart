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
      child: Column(
        children: [
          Obx(
            () => messagesGet.isSearchEnabled.value
                ? SizedBox(
                    height: 50,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: TextField(
                        onChanged: (newVal) {
                          messagesGet.searchValue.value = newVal;
                          messagesGet.roomStream.sink.add(true);
                        },
                        decoration: const InputDecoration(
                          hintText: 'Search ...',
                          border: InputBorder.none,
                          errorBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                        ),
                      ),
                    ))
                : Container(),
          ),
          Expanded(
            child: StreamBuilder(
                stream: messagesGet.roomStream.stream,
                builder: (context, snapshot) {
                  final rooms = messagesGet.searchValue.value.isNotEmpty
                      ? messagesGet.rooms
                          .where((element) => (element.name
                              .toLowerCase()
                              .contains(
                                  messagesGet.searchValue.value.toLowerCase())))
                          .toList()
                      : messagesGet.rooms;
                  return rooms.isNotEmpty
                      ? ListView.builder(
                          itemBuilder: (context, index) {
                            return RoomWidget(
                              room: rooms[index],
                            );
                          },
                          itemCount: rooms.length)
                      : _emptyWidget;
                }),
          ),
        ],
      ),
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
