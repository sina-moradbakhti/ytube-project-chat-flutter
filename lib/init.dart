import 'package:chatify/constants/config.dart';
import 'package:chatify/models/message.dart';
import 'package:chatify/models/user.dart';
import 'package:chatify/pages/chat/chat.get.dart';
import 'package:get/get.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class AppInit {
  static final AppInit _singleton = AppInit._internal();
  factory AppInit() {
    return _singleton;
  }
  AppInit._internal();

  IO.Socket? socket;
  User? currentChatUser;

  void initSocketClient() {
    AppInit().socket = IO.io(
        '${Config.socketServerBaseUrl}?token=${Config.me!.token}',
        IO.OptionBuilder()
            .setTransports(["websocket"])
            .disableAutoConnect()
            .enableForceNew()
            .build());

    AppInit().socket?.onConnect((data) => print('Connected'));
    AppInit().socket?.onDisconnect((data) => print('Disconnected'));
    AppInit().socket?.on('onMessage', (data) => _onMessageHandler(data));

    AppInit().socket?.connect();
  } // end socket client initialization

  _onMessageHandler(Map<String, dynamic> json) {
    final message = Message(
        date: DateTime.now(),
        message: json['message'],
        user: User.fromSocketJson(json['from']));
    if (message.user.id == currentChatUser?.id) {
      final chatGet = Get.find<ChatGet>();
      chatGet.messages.add(message);
      chatGet.onUpdateStream.sink.add(true);
    }
  }
}
