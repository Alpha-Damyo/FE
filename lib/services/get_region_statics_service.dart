import 'dart:convert';
import 'package:damyo/models/stat_region_model.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

// jjhinu104@gmail.com

Future<statRegionModel> getRegionStatics() async {
  final baseUrl = dotenv.get('BASE_URL');
  var url = Uri.parse('$baseUrl/data/regionStatics');
  var response = await http.get(
    url,
  );

  final Map<String, dynamic> jsonMap =
      jsonDecode(utf8.decode(response.bodyBytes));

  if (response.statusCode == 200) {
    return statRegionModel(
        jsonMap['allRegionStatisticsResponse']['allRegion'], jsonMap['areaTopResponse']['areaTop']);
  } else {
    throw Exception("Failed to region statics");
  }
}
