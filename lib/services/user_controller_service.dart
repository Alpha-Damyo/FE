import 'dart:convert';
import 'package:damyo/models/userinfo/user_info_model.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

Future<UserInfoModel> getUserInfo() async {
  FlutterSecureStorage secureStorage = const FlutterSecureStorage();
  final baseUrl = dotenv.get('BASE_URL');
  final accessToken = await secureStorage.read(key: "accessToken");
  print("token: $accessToken");

  var url = Uri.parse('$baseUrl/user/info');
  var headers = {
    "Authorization": 'Bearer $accessToken',
  };

  var response = await http.get(url, headers: headers);

  var responseDecode = jsonDecode(utf8.decode(response.bodyBytes));

  if (response.statusCode == 200) {
    UserInfoModel userInfoModel = UserInfoModel.fromJson(responseDecode);
    return userInfoModel;
  } else {
    print(responseDecode);
    throw Exception("Failed to update name");
  }
}
