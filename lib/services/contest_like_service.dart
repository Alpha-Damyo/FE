import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

Future<http.Response> contestLike(String token, int pictureId) async {
  final baseUrl = dotenv.get('BASE_URL');
  var queryParams = {
    'pictureId': pictureId.toString(),
  };
  var url = Uri.http('ec2-3-37-0-59.ap-northeast-2.compute.amazonaws.com',
      '/api/contest/like', queryParams);
  var response = await http.put(
    url,
    headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    },
  );
  print(response.statusCode);
  if (response.statusCode == 200) {
    return response;
  } else {
    throw '에러: ${response.statusCode}, failed like';
  }
}

Future<http.Response> contestUnlike(String token, int pictureId) async {
  final baseUrl = dotenv.get('BASE_URL');
  var queryParams = {
    'pictureId': pictureId.toString(),
  };
  var url = Uri.http('ec2-3-37-0-59.ap-northeast-2.compute.amazonaws.com',
      '/api/contest/unlike', queryParams);
  var response = await http.put(
    url,
    headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    },
  );
  print(response.statusCode);
  if (response.statusCode == 200) {
    return response;
  } else {
    throw '에러: ${response.statusCode}, failed unlike';
  }
}
