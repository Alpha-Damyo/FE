import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

void informSmokingArea() async {
  final baseUrl = dotenv.get('BASE_URL');
  var url = Uri.parse('');
  var response = await http.post(
    url,
    body: {},
  );
}
