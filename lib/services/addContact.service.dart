import 'dart:convert';

import 'package:chatify/constants/config.dart';
import 'package:chatify/models/user.dart';
import 'package:chatify/services/base.dart';
import 'package:http/http.dart' as http;

class AddContactService extends BaseService {
  final Uri url = Uri.parse('${Config.httpsServicesBaseUrl}/new-contact');
  Future<User?> call(Map<String, dynamic> args) async {
    final client = http.Client();
    final response = await client.post(url,
        body: args, headers: {'Authorization': 'Bearer ${Config.me!.token}'});
    final decodedResponse = jsonDecode(response.body);
    if (response.statusCode == 200) {
      return User.fromJson(decodedResponse['data']);
    } else {
      Config.errorHandler(
          title: decodedResponse['error_code'],
          message: decodedResponse['message']);
      return null;
    }
  }
}
