import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

Future<Map<String, String>> signup(String imageUrl, String email, String name,
    String gender, int age, String token) async {
  // .env 파일에서 BASE_URL 읽기
  final baseUrl = dotenv.get('BASE_URL');

  // 요청을 보낼 URL 구성
  var url = Uri.parse('$baseUrl/auth/signup');

  // MultipartRequest 객체 생성
  var request = http.MultipartRequest('POST', url);

  // 이미지 URL을 필드로 추가
  request.fields['image'] = imageUrl;

  // JSON 데이터 생성 및 필드로 추가
  var signUpRequest = json.encode({
    "email": email,
    "name": name,
    "gender": gender,
    "age": age,
  });
  request.fields['signUpRequest'] = signUpRequest;

  // 헤더 설정
  request.headers.addAll({
    'accept': '*/*',
    'Content-Type': 'multipart/form-data',
  });

  // 요청 보내기
  var response = await request.send();
  var jsonBody = await response.stream.bytesToString();
  var rtn = await jsonDecode(jsonBody);

  // 상태 코드에 따라 처리
  if (response.statusCode == 200) {
    print(rtn);
    return rtn;
  } else {
    throw '에러: ${response.statusCode}, 회원가입 실패';
  }
}
