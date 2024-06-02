import 'dart:convert';

import 'package:damyo/models/sa_inform_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

Future<bool> informSmokingArea(SaInformModel saInformModel) async {
  final baseUrl = dotenv.get('BASE_URL');
  var url = Uri.parse('$baseUrl/area/postArea');

  var data = {
    "address": saInformModel.address,
    "name": saInformModel.name,
    "description": saInformModel.description,
    "latitude": saInformModel.latitude,
    "longitude": saInformModel.longitude,
    "score": saInformModel.score,
    "opened": saInformModel.opened,
    "closed": saInformModel.closed,
    "indoor": saInformModel.indoor,
    "outdoor": saInformModel.outdoor,
    "url": saInformModel.url,
  };

  var body = json.encode(data);
  print(body);

  var response = await http.post(
    url,
    headers: {
      'Content-Type': 'application/json',
    },
    body: body,
  );

  var resoponseDecode = jsonDecode(utf8.decode(response.bodyBytes));
  if (response.statusCode == 200) {
    print("success informed");
    print(resoponseDecode);
    return true;
  } else {
    print(resoponseDecode);
    throw Exception("failed inform");
  }
}
