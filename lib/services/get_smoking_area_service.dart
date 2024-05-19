import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

Future<Map<String, dynamic>> getSmokingArea() async {
  final baseUrl = dotenv.get('BASE_URL');
  var url = Uri.parse('$baseUrl/area');
  var response = await http.get(
    url,
  );

  final Map<String, dynamic> jsonMap =
      jsonDecode(utf8.decode(response.bodyBytes));

  if (response.statusCode == 200) {
    return jsonMap;
  } else {
    print(response);
    throw Exception("Failed to load smoking area");
  }
}
