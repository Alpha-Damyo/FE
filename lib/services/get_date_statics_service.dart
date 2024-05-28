import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

// jjhinu104@gmail.com

Future<Map<String, dynamic>> getDateStatics() async {
  final baseUrl = dotenv.get('BASE_URL');
  var url = Uri.parse('$baseUrl/data/dateStatics');
  var response = await http.get(
    url,
  );
  
  final Map<String, dynamic> jsonMap =
      jsonDecode(utf8.decode(response.bodyBytes));

  if (response.statusCode == 200) {
    print(jsonMap);
    return jsonMap;
  } else {
    print(response);
    throw Exception("Failed to date statics");
  }
}
