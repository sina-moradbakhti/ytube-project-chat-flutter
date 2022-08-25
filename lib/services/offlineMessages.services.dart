import 'dart:convert';
import 'package:chatify/cacheManager/hive.cache.dart';
import 'package:chatify/constants/config.dart';
import 'package:chatify/models/contact.dart';
import 'package:chatify/models/message.dart';
import 'package:chatify/models/user.dart';
import 'package:chatify/services/base.dart';
import 'package:http/http.dart' as http;

class OfflineMessagesServices extends BaseService {
  final Uri url =
      Uri.parse('${Config.httpsServicesBaseUrl}/get-latest-offline-messages');
  final Uri urlDrop =
      Uri.parse('${Config.httpsServicesBaseUrl}/clear-latest-offline-messages');
  Future<void> call(Map<String, dynamic> args) async {
    try {
      final client = http.Client();
      final response = await client.post(url,
          body: args, headers: {'Authorization': 'Bearer ${Config.me!.token}'});
      final decodedResponse = jsonDecode(response.body);
      if (response.statusCode == 200) {
        for (final messageObject in decodedResponse['data']) {
          final userJson = messageObject['user'][0];
          final user = User(
              fullname: userJson['fullName'],
              id: userJson['_id'],
              username: userJson['userName']);
          await HiveCacheManager().save(Contact(user: user, messages: [
            Message(
                date: DateTime.parse(messageObject['dateTime']),
                message: messageObject['message'],
                user: user)
          ]));
        }
        await _dropMessages(args['userId']);
      }
    } catch (er) {
      print(er);
    }
  }

  Future<void> _dropMessages(String userId) async {
    try {
      final client = http.Client();
      await client.post(urlDrop,
          body: {'userId': userId},
          headers: {'Authorization': 'Bearer ${Config.me!.token}'});
    } catch (er) {
      print(er);
    }
  }
}
