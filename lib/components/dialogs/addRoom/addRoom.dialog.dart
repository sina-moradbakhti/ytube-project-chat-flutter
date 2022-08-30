import 'package:chatify/components/buttons/primary_button.dart';
import 'package:chatify/components/buttons/underline_button.dart';
import 'package:chatify/components/dialogs/addRoom/addRoom.get.dart';
import 'package:chatify/components/loading.dart';
import 'package:chatify/components/textfields/primary_textfield.dart';
import 'package:chatify/constants/colors.dart';
import 'package:chatify/constants/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddRoomDialog extends StatelessWidget {
  AddRoomDialog({Key? key}) : super(key: key);

  final addRoomGet = AddRoomGet();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async => false,
        child: AlertDialog(
          backgroundColor: Colors.white,
          content: SizedBox(
            width: Get.size.width - 100, // Width of the dialog
            height: Get.size.height / 1.5, // Height of the dialog
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(top: 15, bottom: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text('Add Room', style: MyTextStyles.header2),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 30),
                      child: MaterialButton(
                        padding: EdgeInsets.zero,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(60)),
                        onPressed: addRoomGet.uploadAvatar,
                        child: Obx(
                          () => (addRoomGet.profileAvatar.value?.path ?? '')
                                  .isEmpty
                              ? CircleAvatar(
                                  radius: 60,
                                  backgroundColor: Colors.grey.shade300,
                                  child: Center(
                                      child: Icon(Icons.people,
                                          size: 40,
                                          color: Colors.grey.shade400)))
                              : CircleAvatar(
                                  radius: 60,
                                  backgroundColor: Colors.grey.shade300,
                                  backgroundImage: FileImage(
                                      addRoomGet.profileAvatar.value!),
                                ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 30),
                      child: PrimaryTextfield(
                        hint: 'Room name',
                        maxLength: 40,
                        onChanged: (newVal) =>
                            addRoomGet.roomName.value = newVal,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: PrimaryTextfield(
                        multiLine: true,
                        hint: 'Description',
                        onChanged: (newVal) =>
                            addRoomGet.roomDescription.value = newVal,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: TextButton(
                        onPressed: addRoomGet.editMemebrs,
                        child: StreamBuilder(
                            stream: addRoomGet.listUpdateStream.stream,
                            builder: (context, snapshot) => Text(
                                  addRoomGet.members.isNotEmpty
                                      ? '+ Edit Member (${addRoomGet.members.length})'
                                      : '+ Edit Member',
                                  style: MyTextStyles.button
                                      .copyWith(color: MyColors.primaryColor),
                                )),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 30),
                      child: Divider(),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Obx(() => addRoomGet.loading.value
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
                                    title: 'Add', onPressed: addRoomGet.add)
                              ],
                            )),
                    )
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
