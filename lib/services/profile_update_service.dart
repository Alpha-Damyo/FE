import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

Future<String?> putUserUpdateName(String name) async {
  final baseUrl = dotenv.get('BASE_URL');
  final token = dotenv.get('TEST_TOKEN');
  var url = Uri.parse('$baseUrl/user/update/name?name=$name');
  var headers = {
    "Authorization": 'Bearer $token',
  };
  var response = await http.put(
    url,
    headers: headers
  );

  

  if (response.statusCode == 200) {
    return response.body;
  } else {
    final Map<String, dynamic> jsonMap =
      jsonDecode(utf8.decode(response.bodyBytes));
    print(utf8.decode(response.bodyBytes));
    throw Exception("Failed to update name");
  }
}
