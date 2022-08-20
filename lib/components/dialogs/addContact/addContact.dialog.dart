import 'package:chatify/components/buttons/primary_button.dart';
import 'package:chatify/components/buttons/underline_button.dart';
import 'package:chatify/components/dialogs/addContact/addContact.get.dart';
import 'package:chatify/components/loading.dart';
import 'package:chatify/components/textfields/primary_textfield.dart';
import 'package:chatify/constants/text_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddContactDialog extends StatelessWidget {
  AddContactDialog({Key? key}) : super(key: key);

  final addContactGet = AddContactGet();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async => false,
        child: AlertDialog(
          backgroundColor: Colors.white,
          content: Padding(
            padding: const EdgeInsets.only(top: 15, bottom: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Add Contact', style: MyTextStyles.header2),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: PrimaryTextfield(
                    hint: 'Enter username',
                    maxLength: 40,
                    prefixIcon: CupertinoIcons.person,
                    onChanged: (newVal) =>
                        addContactGet.username.value = newVal,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Obx(() => addContactGet.loading.value
                      ? const MyLoading()
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 15),
                              child: UnderlineButton(
                                title: 'Cancel',
                                onPressed: () => Get.back(),
                              ),
                            ),
                            PrimaryButton(
                                title: 'Add', onPressed: addContactGet.add)
                          ],
                        )),
                )
              ],
            ),
          ),
        ));
  }
}
