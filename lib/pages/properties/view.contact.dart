import 'package:chatify/constants/config.dart';
import 'package:chatify/pages/properties/contact.get.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ContactProperties extends StatelessWidget {
  ContactProperties({Key? key}) : super(key: key);

  final contactGet = Get.put(ContactPropertiesGet());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contact Properties'),
        leading: IconButton(
          padding: EdgeInsets.zero,
          onPressed: () => Get.back(),
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: Get.size.height / 3,
            width: double.infinity,
            child: CachedNetworkImage(
              errorWidget: (context, url, error) => Container(
                  decoration: BoxDecoration(color: Colors.grey.shade300),
                  child: Icon(Icons.person,
                      color: Colors.grey.shade400, size: 50)),
              imageUrl:
                  Config.showAvatarBaseUrl(contactGet.contact?.user.id ?? ''),
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Text(contactGet.contact?.user.fullname ?? '',
                style: Get.theme.textTheme.headline3),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Text(contactGet.contact?.user.username ?? '',
                style: Get.theme.textTheme.headline6),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 20),
            child: Divider(),
          ),
          TextButton(
              onPressed: contactGet.deleteChat,
              child: Text(
                'Delete Chat',
                style: Get.theme.textTheme.button!
                    .copyWith(color: Colors.red, fontWeight: FontWeight.bold),
              ))
        ],
      ),
    );
  }
}
