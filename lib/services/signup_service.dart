import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

Future<http.Response> signup(
    String imageUrl, String email, String name, String gender, int age) async {
  // .env 파일에서 BASE_URL 읽기
  final baseUrl = dotenv.get('BASE_URL');

  // 요청을 보낼 URL 구성
  var url = Uri.parse(
      'http://ec2-3-37-0-59.ap-northeast-2.compute.amazonaws.com/api/auth/signup');

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
  var streamedResponse = await request.send();

  // Stream을 읽어서 Response로 변환
  var response = await http.Response.fromStream(streamedResponse);

  // 상태 코드에 따라 처리
  if (response.statusCode == 200) {
    return response;
  } else {
    throw '에러: ${response.statusCode}, 회원가입 실패';
  }
}
