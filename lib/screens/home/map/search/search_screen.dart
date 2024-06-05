import 'package:damyo/main.dart';
import 'package:damyo/models/smoking_area/sa_basic_model.dart';
import 'package:damyo/models/smoking_area/sa_keyword_search_model.dart';
import 'package:damyo/services/smoking_area_service.dart';
import 'package:damyo/style.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'dart:math';

// 두 좌표의 위도와 경도를 라디안으로 변환하는 함수
double _degreesToRadians(double degrees) {
  return degrees * pi / 180;
}

// 두 좌표 사이의 거리를 계산하는 함수
double calculateDistance(double lat1, double lon1, double lat2, double lon2) {
  // 지구의 반지름 (미터 단위)
  const double R = 6371000;

  // 위도와 경도를 라디안 단위로 변환
  double lat1Rad = _degreesToRadians(lat1);
  double lon1Rad = _degreesToRadians(lon1);
  double lat2Rad = _degreesToRadians(lat2);
  double lon2Rad = _degreesToRadians(lon2);

  // 위도와 경도의 차이 계산
  double deltaLat = lat2Rad - lat1Rad;
  double deltaLon = lon2Rad - lon1Rad;

  // 해버사인 공식 적용
  double a = sin(deltaLat / 2) * sin(deltaLat / 2) +
      cos(lat1Rad) * cos(lat2Rad) * sin(deltaLon / 2) * sin(deltaLon / 2);
  double c = 2 * atan2(sqrt(a), sqrt(1 - a));

  // 두 좌표 사이의 거리 계산 (미터 단위)
  double distance = R * c;

  return distance;
}

String mKm(double distance) {
  if (distance > 1000) {
    return '${(distance / 1000).toInt().toString()}km';
  } else {
    return '${(distance.toInt().toString())}m';
  }
}

class SearchScreen extends StatefulWidget {
  final Map<String, dynamic> searchFilterMap;
  SearchScreen({
    super.key,
    required this.searchFilterMap,
  });

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  List<SaBasicModel> smokingAreaLists = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _focusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        body: Column(
          children: [
            const SizedBox(
              height: 47,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Row(
                children: [
                  InkWell(
                    onTap: () {
                      if (MediaQuery.of(context).viewInsets.bottom > 0) {
                        FocusManager.instance.primaryFocus?.unfocus();
                      } else {
                        context.pop();
                      }
                    },
                    child: const Icon(Icons.arrow_back_ios),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      // focusNode: _focusNode,
                      onChanged: (text) {
                        setState(() {});
                      },
                      onEditingComplete: () async {
                        FocusManager.instance.primaryFocus?.unfocus();
                        SaKeywordSearchModel tmpModel =
                            SaKeywordSearchModel.fromMap(
                                _controller.text, widget.searchFilterMap);
                        List<dynamic> tmpRtn =
                            await SmokingAreaService.searchSmokingAreaByKeyword(
                          tmpModel,
                        );
                        smokingAreaLists.clear();
                        for (int i = 0; i < tmpRtn.length; i++) {
                          smokingAreaLists
                              .add(SaBasicModel.fromJson(tmpRtn[i]));
                        }
                        setState(() {});
                      },
                      decoration: const InputDecoration(
                        hintText: "흡연구역 검색",
                        border: InputBorder.none,
                        hintStyle: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF6F767F),
                        ),
                      ),
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  if (_controller.text.isNotEmpty)
                    IconButton(
                      onPressed: () {
                        _controller.clear();
                        setState(() {});
                      },
                      icon: const Icon(
                        Icons.cancel,
                        color: Colors.grey,
                        size: 18,
                      ),
                    ),
                ],
              ),
            ),
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.all(10),
                itemCount: smokingAreaLists.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              child: textFormat(
                                text: smokingAreaLists[index].name,
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                              ),
                            ),
                            Container(
                              child: textFormat(
                                text: smokingAreaLists[index].address,
                                color: const Color(0xFF6F767F),
                                fontWeight: FontWeight.w500,
                                fontSize: 12,
                              ),
                            )
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Container(
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.star_rounded,
                                    size: 17,
                                    color: Color(0xFFFFC226),
                                  ),
                                  textFormat(
                                    text: smokingAreaLists[index]
                                        .score
                                        .toString(),
                                    fontWeight: FontWeight.w500,
                                    fontSize: 12,
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              child: textFormat(
                                  text: mKm(calculateDistance(
                                userLatitude,
                                userLongitude,
                                smokingAreaLists[index].latitude,
                                smokingAreaLists[index].longitude,
                              ))),
                            ),
                          ],
                        )
                      ],
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return const Divider(
                    color: Color(0xFFEEF1F5),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
