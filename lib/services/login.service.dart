import 'dart:convert';

import 'package:chatify/cacheManager/user.cache.dart';
import 'package:chatify/constants/config.dart';
import 'package:chatify/services/base.dart';
import 'package:http/http.dart' as http;

class LoginService extends BaseService {
  final Uri url = Uri.parse('${Config.httpsServicesBaseUrl}/signin');
  Future<bool> call(Map<String, dynamic> args) async {
    final client = http.Client();
    final response = await client.post(url, body: args);
    final decodedResponse = jsonDecode(response.body);

    if (response.statusCode == 200) {
      Config.errorHandler(
          title: decodedResponse['error_code'],
          message: decodedResponse['message']);
      await UserCacheManager.save(
          fullname: decodedResponse['data']['fullName'],
          userId: decodedResponse['data']['_id'],
          username: decodedResponse['data']['userName'],
          token: decodedResponse['data']['token']);
      await Future.delayed(const Duration(seconds: 2));
      return true;
    } else {
      Config.errorHandler(
          title: decodedResponse['error_code'],
          message: decodedResponse['message']);
      return false;
    }
  }
}
