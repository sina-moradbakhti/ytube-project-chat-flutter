import 'dart:convert';

import 'package:chatify/constants/config.dart';
import 'package:chatify/models/user.dart';
import 'package:chatify/services/base.dart';
import 'package:http/http.dart' as http;

class NewRoomService extends BaseService {
  final Uri url = Uri.parse('${Config.httpsServicesBaseUrl}/new-room');
  Future<Map<String, dynamic>?> call(Map<String, dynamic> args) async {
    final req = http.MultipartRequest('put', url)
      ..headers['Content-Type'] = 'multipart/form-data'
      ..headers['userid'] = args['userId']
      ..headers['roomname'] = args['roomName']
      ..headers['roomdesc'] = args['roomDesc']
      ..headers['roommembers'] = jsonEncode(args['roomMembers'])
      ..headers['Authorization'] = 'Bearer ${Config.me!.token}';

    if (args['roomAvatar'].toString().isNotEmpty) {
      req.files.add(
          await http.MultipartFile.fromPath('roomAvatar', args['roomAvatar']));
    }

    final response = await http.Response.fromStream(await req.send());

    final decodedResponse = jsonDecode(response.body);
    print('======> $decodedResponse');
    if (response.statusCode == 200) {
      print('\n\n ${decodedResponse['data']['members']}');
      return {
        'roomId': decodedResponse['data']['_id'],
        'members': [
          for (final userItemJson in decodedResponse['data']['members'])
            User.fromMakeRoomJson(userItemJson)
        ]
      };
    } else {
      Config.errorHandler(
          title: decodedResponse['error_code'],
          message: decodedResponse['message']);
      return null;
    }
  }
}
