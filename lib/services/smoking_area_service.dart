import 'dart:convert';

import 'package:damyo/models/smoking_area/sa_detail_model.dart';
import 'package:damyo/models/smoking_area/sa_basic_model.dart';
import 'package:damyo/models/smoking_area/sa_inform_model.dart';
import 'package:damyo/models/smoking_area/sa_keyword_search_model.dart';
import 'package:damyo/models/smoking_area/sa_search_model.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class SmokingAreaService {
  // 흡연구역 검색
  static Future<List<dynamic>> searchSmokingArea(
      SaSearchModel saSearchModel) async {
    final baseUrl = dotenv.get('BASE_URL');
    var url = Uri.parse('$baseUrl/area/locateSearch');

    var data = {
      "latitude": saSearchModel.latitude,
      "longitude": saSearchModel.longitude,
      "range": saSearchModel.range,
      "status": saSearchModel.status,
      "opened": saSearchModel.opened,
      "closed": saSearchModel.closed,
      "hygiene": saSearchModel.hygiene,
      "dirty": saSearchModel.dirty,
      "airOut": saSearchModel.airOut,
      "noExist": saSearchModel.noExist,
      "indoor": saSearchModel.indoor,
      "outdoor": saSearchModel.outdoor,
      "big": saSearchModel.big,
      "small": saSearchModel.small,
      "crowded": saSearchModel.crowded,
      "quite": saSearchModel.quite,
      "chair": saSearchModel.chair,
    };

    var body = json.encode(data);

    var response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: body,
    );

    var responseDecode = jsonDecode(utf8.decode(response.bodyBytes));
    if (response.statusCode == 200) {
      print("success searched");
      print(responseDecode['smokingAreas']);
      return responseDecode['smokingAreas'];
    } else {
      print(responseDecode);
      throw Exception("fail search");
    }
  }

  // 흡연구역 검색어 검색
  static Future<List<dynamic>> searchSmokingAreaByKeyword(
      SaKeywordSearchModel saKeywordSearchModel) async {
    final baseUrl = dotenv.get('BASE_URL');
    var url = Uri.parse('$baseUrl/area/querySearch');

    var data = saKeywordSearchModel.toMap();

    var body = json.encode(data);

    var response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: body,
    );

    var responseDecode = jsonDecode(utf8.decode(response.bodyBytes));
    if (response.statusCode == 200) {
      print("success searched");
      print(responseDecode['smokingAreas']);
      return responseDecode['smokingAreas'];
    } else {
      print(responseDecode);
      throw Exception("fail search");
    }
  }

  // 흡연구역 id로 기본정보 받아오기
  static Future<SaBasicModel> getBasicModelById(String id) async {
    final baseUrl = dotenv.get('BASE_URL');
    var url = Uri.parse('$baseUrl/area/summary/$id');

    var response = await http.get(url);

    var responseDecode = jsonDecode(utf8.decode(response.bodyBytes));
    if (response.statusCode == 200) {
      print("success search");
      return SaBasicModel.fromJson(responseDecode);
    } else {
      print(responseDecode);
      throw Exception("fail search");
    }
  }

  // 흡연구역 id로 상세정보 받아오기
  static Future<SaDetailModel> getDetailModelById(String id) async {
    final baseUrl = dotenv.get('BASE_URL');
    var url = Uri.parse('$baseUrl/area/details/$id');

    var response = await http.get(url);

    var responseDecode = jsonDecode(utf8.decode(response.bodyBytes));
    if (response.statusCode == 200) {
      print("success search");
      return SaDetailModel.fromJson(responseDecode);
    } else {
      print(responseDecode);
      throw Exception("fail search");
    }
  }

  // 흡연구역 제보
  static Future<bool> informSmokingArea(SaInformModel saInformModel) async {
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

    var response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: body,
    );

    var responseDecode = jsonDecode(utf8.decode(response.bodyBytes));
    if (response.statusCode == 200) {
      print("success inform");
      return true;
    } else {
      print(responseDecode);
      throw Exception("fail inform");
    }
  }
}
