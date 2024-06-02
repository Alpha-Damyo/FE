import 'dart:convert';
import 'package:damyo/models/stat_date_model.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

// jjhinu104@gmail.com

Future<statDateModel> getDateStatics() async {
  final baseUrl = dotenv.get('BASE_URL');
  var url = Uri.parse('$baseUrl/api/data/dateStatics');
  var response = await http.get(
    url,
  );

  final Map<String, dynamic> jsonMap =
      jsonDecode(utf8.decode(response.bodyBytes));

  if (response.statusCode == 200) {
    // print(jsonMap);
    return statDateModel(
        jsonMap['hourlyStatisticsResponse'],
        jsonMap['dailyStatisticsResponse'],
        jsonMap['weeklyStatisticsResponse'],
        jsonMap['monthlyStatisticsResponse'],
        jsonMap['dayOfWeekStatisticsResponse']);
  } else {
    print(utf8.decode(response.bodyBytes));
    throw Exception("Failed to date statics");
  }
}
