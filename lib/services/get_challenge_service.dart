import 'dart:convert';

import 'package:damyo/models/challenge_model.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

Future<List<Challenge>> getCurrentChallenge() async {
  FlutterSecureStorage storage = const FlutterSecureStorage();
  final baseUrl = dotenv.get('BASE_URL');
  var url = Uri.parse('$baseUrl/ch/getCurrentChallenge');

  final token = await storage.read(key: "accessToken");
  print(token);

  var response = await http.post(
    url,
    headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    },
    body: '',
  );
  print(response.statusCode);
  if (response.statusCode == 200) {
    List<dynamic> jsonData = jsonDecode(utf8.decode(response.bodyBytes));
    return jsonData.map((json) => Challenge.fromJson(json)).toList();
  } else {
    throw '에러: ${response.statusCode}, failed getting current challenge';
  }
}

Future<http.Response> getAllChallenge(String token) async {
  final baseUrl = dotenv.get('BASE_URL');
  var url = Uri.parse('$baseUrl/api/ch/getAllChallenge');
  var response = await http.get(
    url,
    headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    },
  );

  if (response.statusCode == 200) {
    return response;
  } else {
    throw '에러: ${response.statusCode}, failed getting all challenge';
  }
}
