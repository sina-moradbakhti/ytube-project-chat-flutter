import 'package:chatify/constants/config.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class AppInit {
  static final AppInit _singleton = AppInit._internal();
  factory AppInit() {
    return _singleton;
  }
  AppInit._internal();

  void initSocketClient() {
    IO.Socket socket = IO.io(
        '${Config.socketServerBaseUrl}?token=${Config.me!.token}',
        IO.OptionBuilder()
            .setTransports(["websocket"])
            .disableAutoConnect()
            .enableForceNew()
            .build());

    socket.onConnect((data) => print('Connected'));
    socket.onDisconnect((data) => print('Disconnected'));
    socket.on('onMessage', (data) => print('onMessage : $data'));

    socket.connect();
  } // end socket client initialization
}
