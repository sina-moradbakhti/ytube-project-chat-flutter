import 'dart:convert';
import 'package:chatify/constants/config.dart';
import 'package:chatify/services/base.dart';
import 'package:http/http.dart' as http;

class UploadServices extends BaseService {
  final Uri url = Uri.parse('${Config.httpsServicesBaseUrl}/upload-avatar');
  Future<bool> call(Map<String, dynamic> args) async {
    try {
      final req = http.MultipartRequest('put', url)
        ..headers['Content-Type'] = 'multipart/form-data'
        ..headers['userid'] = args['userId']
        ..headers['Authorization'] = 'Bearer ${Config.me!.token}';

      req.files
          .add(await http.MultipartFile.fromPath('avatar', args['avatar']));
      final response = await http.Response.fromStream(await req.send());

      final decodedResponse = jsonDecode(response.body);
      if (response.statusCode == 200) {
        return true;
      } else {
        Config.errorHandler(
            title: decodedResponse['error_code'],
            message: decodedResponse['message']);
        return false;
      }
    } catch (er) {
      print(er);
      Config.errorHandler(title: 'Upload Error', message: er.toString());
      return false;
    }
  }
}
