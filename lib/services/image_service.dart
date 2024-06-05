import 'dart:convert';
import 'dart:io';

import 'package:damyo/models/updateprofile/update_profile_model.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

Future<String> ImageService(UpdateProfileModel image) async {
  final baseUrl = dotenv.get('IMAGE_SERVER_URL');

  var url = Uri.parse('$baseUrl/filter');
  var request = http.MultipartRequest('POST', url);

  // 파일 추가
  var imageFile = File(image.path);
  var stream = http.ByteStream(imageFile.openRead());
  var length = await imageFile.length();
  var multipartFile = http.MultipartFile(
    'file',
    stream,
    length,
    filename: image.name,
  );

  // 파일 추가
  request.files.add(multipartFile);

  // 요청 보내기
  var response = await request.send();
  var jsonBody = await response.stream.bytesToString();
  var rtnUrl = jsonDecode(jsonBody)['url'];

  if (response.statusCode == 200) {
    print("//////////////////");
    print(rtnUrl);
    return rtnUrl;
  } else {
    print(jsonBody);
    throw Exception("Failed to update profile");
  }
}
