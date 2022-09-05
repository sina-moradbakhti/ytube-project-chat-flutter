import 'package:chatify/models/chatType.enum.dart';

extension ChatTypeConvert on String {
  ChatType convertToChatType() {
    final strChatType = this;
    switch (strChatType) {
      case 'ChatType.message':
        return ChatType.message;
      case 'ChatType.image':
        return ChatType.image;
      case 'ChatType.voice':
        return ChatType.voice;
      case 'ChatType.sticker':
        return ChatType.sticker;
      default:
        return ChatType.message;
    }
  }
}

extension StrChatTypeConvert on ChatType {
  String convertToStrChatType() {
    final chatType = this;
    switch (chatType) {
      case ChatType.message:
        return 'ChatType.message';
      case ChatType.image:
        return 'ChatType.image';
      case ChatType.voice:
        return 'ChatType.voice';
      case ChatType.sticker:
        return 'ChatType.sticker';
      default:
        return 'ChatType.message';
    }
  }
}
