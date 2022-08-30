import 'package:chatify/models/member.dart';
import 'package:chatify/pages/messages/messages.get.dart';
import 'package:get/get.dart';
import 'package:rxdart/rxdart.dart';

class EditMembersGet extends GetxController {
  var username = ''.obs;
  var loading = false.obs;
  PublishSubject<bool> listUpdateStream = PublishSubject<bool>();
  List<Member> members = [];
  bool fistTimeInit = true;

  void init(List<Member> defaultMembers) {
    if (!fistTimeInit) return;
    fistTimeInit = false;

    for (var contact in messagesGet.contacts) {
      members.add(Member(
          user: contact.user,
          isSelected: defaultMembers
                  .where((element) => element.user.id == contact.user.id)
                  .toList()
                  .isEmpty
              ? false
              : true));
    }
  }

  final messagesGet = Get.find<MessagesGet>();

  void toggleMember(int index) {
    members[index].isSelected = !members[index].isSelected;
    listUpdateStream.sink.add(true);
  }
}
