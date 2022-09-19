import 'package:cached_network_image/cached_network_image.dart';
import 'package:chatify/constants/colors.dart';
import 'package:chatify/constants/config.dart';
import 'package:chatify/constants/text_styles.dart';
import 'package:chatify/models/room.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RoomWidget extends StatelessWidget {
  final Room room;
  const RoomWidget({Key? key, required this.room}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final int badgeCount =
        room.messages.where((element) => element.seen == false).toList().length;

    return Stack(
      alignment: Alignment.center,
      children: [
        InkWell(
          onTap: () => Get.toNamed(PageRoutes.chat, arguments: room),
          child: Container(
            decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(width: .5, color: Colors.grey.shade300)),
            ),
            padding: const EdgeInsets.all(24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: CircleAvatar(
                    radius: 28,
                    backgroundColor: Colors.grey.shade300,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: SizedBox(
                        width: 100,
                        height: 100,
                        child: CachedNetworkImage(
                          fit: BoxFit.cover,
                          imageUrl: Config.showRoomAvatarBaseUrl(room.id),
                          errorWidget: (context, url, error) => Icon(Icons.person,
                              color: Colors.grey.shade400, size: 50),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: Text(room.name, style: MyTextStyles.title),
                          ),
                          Text(
                              room.messages.isNotEmpty
                                  ? _beautifyDate(room.messages.last.date)
                                  : '',
                              style: MyTextStyles.small)
                        ],
                      ),
                      SizedBox(
                        height: 16,
                        child: Text(
                            room.messages.isNotEmpty
                                ? '${room.messages.last.user.fullname}: ${room.messages.last.message}'
                                : '',
                            style: MyTextStyles.headline
                                .copyWith(overflow: TextOverflow.ellipsis)),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        if (badgeCount > 0)
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 16),
              child: CircleAvatar(
                radius: 10,
                backgroundColor: MyColors.primaryColor,
                child: Text(badgeCount.toString(),
                    style: MyTextStyles.small.copyWith(
                        color: Colors.white, fontWeight: FontWeight.bold)),
              ),
            ),
          ),
      ],
    );
  }

  String _beautifyDate(DateTime date) {
    return "${date.month}/${date.day} ${date.hour}:${date.minute}";
  }
}
