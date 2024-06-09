import 'dart:convert';

import 'package:damyo/models/contest_model.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

Future<ContestResponse> contestPage(String token, int cursorId, String sortBy,
    {String? region}) async {
  final baseUrl = dotenv.get('BASE_URL');

  var queryParams = {
    'cursorId': cursorId.toString(),
    'sortBy': sortBy,
  };

  if (region != null && region.isNotEmpty) {
    queryParams['region'] = region;
  }

  var url = Uri.parse(
    '$baseUrl/api/contest/page/$queryParams',
  );
  var response = await http.get(
    url,
    headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    },
  );
  print(response.statusCode);
  if (response.statusCode == 200) {
    var jsonResponse = json.decode(utf8.decode(response.bodyBytes));
    return ContestResponse.fromJson(jsonResponse);
  } else {
    throw '에러: ${response.statusCode}, failed getting contest page';
  }
}
