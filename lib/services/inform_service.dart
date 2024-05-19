import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

Future<void> informSmokingArea(Map<String, dynamic> body) async {
  final baseUrl = dotenv.get('BASE_URL');
  var url = Uri.parse('$baseUrl/area/postArea');
  var response = await http.post(
    url,
    body: body,
  );

  if (response.statusCode == 200) {
    print("success informed");
  } else {
    print(response.body);
    throw Exception("failed inform");
  }
}
