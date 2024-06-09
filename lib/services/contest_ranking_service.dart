import 'dart:convert';

import 'package:damyo/models/challenge_rank_model.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

Future<RankResponse> contestRanking(String token) async {
  final baseUrl = dotenv.get('BASE_URL');
  var url = Uri.parse(
      'http://ec2-3-37-0-59.ap-northeast-2.compute.amazonaws.com/api/contest/ranking');
  var response = await http.get(
    url,
    headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    },
  );
  if (response.statusCode == 200) {
    var jsonResponse = json.decode(utf8.decode(response.bodyBytes));
    return RankResponse.fromJson(jsonResponse);
  } else {
    throw '에러: ${response.statusCode}, failed getting contest ranking';
  }
}
