import 'package:chatify/components/buttons/primary_button.dart';
import 'package:chatify/components/buttons/underline_button.dart';
import 'package:chatify/components/dialogs/editMembers/editMembers.get.dart';
import 'package:chatify/components/loading.dart';
import 'package:chatify/components/textfields/primary_textfield.dart';
import 'package:chatify/constants/text_styles.dart';
import 'package:chatify/models/member.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditMemberDialog extends StatelessWidget {
  final Function(List<Member>)? onSelectedMembers;
  final List<Member>? members;
  EditMemberDialog({Key? key, this.onSelectedMembers, this.members})
      : super(key: key);

  final editMembersGet = EditMembersGet();

  @override
  Widget build(BuildContext context) {
    editMembersGet.init(members ?? []);
    return WillPopScope(
        onWillPop: () async => false,
        child: AlertDialog(
          backgroundColor: Colors.white,
          content: SizedBox(
            width: Get.size.width - 100,
            child: Padding(
              padding: const EdgeInsets.only(top: 15, bottom: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Edit Members', style: MyTextStyles.header2),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: PrimaryTextfield(
                      hint: 'Search user...',
                      maxLength: 40,
                      prefixIcon: CupertinoIcons.search,
                      onChanged: (newVal) =>
                          editMembersGet.username.value = newVal,
                    ),
                  ),
                  SizedBox(
                      height: Get.height / 2.5,
                      child: StreamBuilder(
                        stream: editMembersGet.listUpdateStream.stream,
                        builder: (context, snapshot) => ListView.builder(
                            itemBuilder: (context, index) => MaterialButton(
                                  padding: EdgeInsets.zero,
                                  onPressed: () =>
                                      editMembersGet.toggleMember(index),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 15),
                                    child: Row(
                                      children: [
                                        editMembersGet.members[index].isSelected
                                            ? const Icon(Icons.check_box)
                                            : const Icon(Icons
                                                .check_box_outline_blank_rounded),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 15),
                                          child: Row(
                                            children: [
                                              CircleAvatar(
                                                  radius: 15,
                                                  backgroundColor:
                                                      Colors.grey.shade300),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 5),
                                                child: Text(
                                                    editMembersGet
                                                        .members[index]
                                                        .user
                                                        .fullname,
                                                    style:
                                                        MyTextStyles.headline),
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                            itemCount: editMembersGet.members.length),
                      )),
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Obx(() => editMembersGet.loading.value
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
                                  title: 'Select',
                                  onPressed: () {
                                    onSelectedMembers!(editMembersGet.members
                                        .where((element) => element.isSelected)
                                        .toList());
                                    Get.back();
                                  })
                            ],
                          )),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
