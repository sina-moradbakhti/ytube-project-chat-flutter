import 'package:chatify/constants/text_styles.dart';
import 'package:flutter/material.dart';

class MessageWidget extends StatelessWidget {
  const MessageWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
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
                    children: const [
                      Padding(
                        padding: EdgeInsets.only(bottom: 10),
                        child: Text('Emily Dove', style: MyTextStyles.title),
                      ),
                      Text('09:13 AM', style: MyTextStyles.small)
                    ],
                  ),
                  SizedBox(
                    height: 16,
                    child: Text('Look, I wanted to appologize for today',
                        style: MyTextStyles.headline
                            .copyWith(overflow: TextOverflow.ellipsis)),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
