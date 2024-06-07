import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

Future<http.Response> signup(
    String image, String email, String name, String gender, int age) async {
  final baseUrl = dotenv.get('BASE_URL');
  var url = Uri.parse('$baseUrl/api/auth/signup');
  var body = {
    "image": image,
    "signUpRequest": {
      "email": email,
      "name": name,
      "gender": gender,
      "age": age
    },
  };

  var response = await http.post(
    url,
    headers: {
      'Content-Type': 'application/json',
    },
    body: body,
  );

  if (response.statusCode == 200) {
    return response;
  } else {
    throw '에러: ${response.statusCode}, failed signup';
  }
}
