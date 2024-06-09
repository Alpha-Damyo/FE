import 'dart:convert';
import 'dart:io';
import 'package:damyo/models/updateprofile/update_name_model.dart';
import 'package:damyo/models/updateprofile/update_profile_model.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

Future<String?> putUserUpdateName(UpdateNameModel nameModel) async {
  final baseUrl = dotenv.get('BASE_URL');
  final token = dotenv.get('TEST_TOKEN');
  

  var url = Uri.parse('$baseUrl/user/update/name?name=${nameModel.name}');
  var headers = {
    "Authorization": 'Bearer $token',
  };

  var response = await http.put(
    url,
    headers: headers
  );

  if (response.statusCode == 200) {
    return response.body;
  } else {
    final Map<String, dynamic> jsonMap =
      jsonDecode(utf8.decode(response.bodyBytes));
    throw Exception("Failed to update name");
  }
}

Future<String?> putUserUpdateProfile(UpdateProfileModel profileModel, String token) async {
  final baseUrl = dotenv.get('BASE_URL');
  // final token = dotenv.get('TEST_TOKEN');
  
  var url = Uri.parse('$baseUrl/user/update/profile');
  var request = http.MultipartRequest('PUT', url);

  // 파일 추가
  var imageFile = File(profileModel.path);
  var stream = http.ByteStream(imageFile.openRead());
  var length = await imageFile.length();
  var multipartFile = http.MultipartFile(
    'image',
    stream,
    length,
    filename: profileModel.name,
  );

  // 파일 추가
  request.files.add(multipartFile);

  // 필요한 다른 데이터 추가
  request.headers['Authorization'] = 'Bearer $token';
  request.fields['key'] = 'value'; // 필요한 다른 필드 추가

  // 요청 보내기
  var response = await request.send();
  var jsonBody = await response.stream.bytesToString();

  
  print(jsonBody);

  if (response.statusCode == 200) {
    return jsonBody;
  } else {
    throw Exception("Failed to update profile");
  }
}
