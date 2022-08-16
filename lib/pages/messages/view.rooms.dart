import 'package:chatify/components/buttons/underline_button.dart';
import 'package:chatify/constants/colors.dart';
import 'package:chatify/constants/text_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MessagesRoomsTab extends StatelessWidget {
  MessagesRoomsTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              CupertinoIcons.group_solid,
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
              onPressed: () {},
            )
          ],
        ),
      ),
    );
  }
}
