import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:path_provider/path_provider.dart';

Future<Map<String, dynamic>> signup(String imageUrl, String email, String name,
    String gender, int age, String token) async {
  // .env 파일에서 BASE_URL 읽기
  final baseUrl = dotenv.get('BASE_URL');

  // 요청을 보낼 URL 구성
  var url = Uri.parse('$baseUrl/auth/signup');

  // 이미지 URL을 필드로 추가
  var request = http.MultipartRequest('POST', url);

  // 1. Load the image from the assets
  ByteData byteData =
      await rootBundle.load('assets/images/default_profile.png');

  // 2. Convert ByteData to Uint8List
  Uint8List uint8List = byteData.buffer.asUint8List();

  // 3. Get the application documents directory
  Directory appDocDir = await getApplicationDocumentsDirectory();
  String appDocPath = appDocDir.path;

  // 4. Create a file path
  File file = File('$appDocPath/images.png');

  // 5. Write the file
  await file.writeAsBytes(uint8List);

  var imageFile = File(file.path);
  var stream = http.ByteStream(imageFile.openRead());
  var length = await imageFile.length();
  var multipartFile = http.MultipartFile(
    'image',
    stream,
    length,
    filename: 'image.png',
  );

  request.files.add(multipartFile);

  var data = {
    "token": token,
    "provider": "google",
    "name": name,
    "gender": gender,
    "age": age,
  };

  List<int> jsonData = utf8.encode(jsonEncode(data));
  request.files.add(http.MultipartFile.fromBytes(
    'signUpRequest',
    jsonData,
    contentType: MediaType(
      'application',
      'json',
      {'charset': 'utf-8'},
    ),
  ));

  // // 헤더 설정
  // request.headers.addAll({
  //   'Content-Type': 'multipart/form-data',
  // });

  // 요청 보내기
  var response = await request.send();
  var jsonBody = await response.stream.bytesToString();
  var rtn = await jsonDecode(jsonBody);

  // 상태 코드에 따라 처리
  if (response.statusCode == 200) {
    print(rtn);
    return rtn;
  } else {
    print(rtn);
    throw '에러: ${response.statusCode}, 회원가입 실패';
  }
}
