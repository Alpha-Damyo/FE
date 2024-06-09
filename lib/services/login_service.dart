import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

Future<http.Response> login(String email) async {
  final baseUrl = dotenv.get('BASE_URL');
  var url = Uri.parse(
      'http://ec2-3-37-0-59.ap-northeast-2.compute.amazonaws.com/api/auth/login');
  var response = await http.post(
    url,
    headers: {
      'Content-Type': 'application/json',
      'accept': '*/*',
    },
    body: jsonEncode({'email': email}),
  );
  print(response.statusCode);
  if (response.statusCode == 200) {
    return response;
  } else {
    throw '${response.statusCode}';
  }
}
