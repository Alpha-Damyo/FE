import 'dart:async';

import 'dart:developer';
import 'package:bottom_drawer/bottom_drawer.dart';
import 'package:damyo/main.dart';
import 'package:damyo/models/sa_basic_model.dart';
import 'package:damyo/screens/home/map/filter/smoking_area_filter.dart';
import 'package:damyo/screens/home/map/filter/smoking_area_filter_listview.dart';
import 'package:damyo/screens/home/map/ovelay_util.dart';
import 'package:damyo/screens/home/map/somking_area/smoking_area_info_card.dart';
import 'package:damyo/screens/home/map/util/map_filter_listview.dart';
import 'package:damyo/services/get_smoking_area_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import 'package:provider/provider.dart';
import 'package:damyo/provider/filterlist_provider.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen>
    with AutomaticKeepAliveClientMixin {
  // 한 번 지도를 실행하면 다시 로드하지 않도록 해주는 변수
  @override
  bool get wantKeepAlive => true;

  // 지도  핵심 worker
  NaverMapController? mapController;
  final onCameraChangeStreamController = StreamController<void>.broadcast();
  StreamSubscription<void>? onCameraChangeStreamSubscription;
  final NInfoOverlayPortalController nOverlayInfoOverlayPortalController =
      NInfoOverlayPortalController();

  // 현재 카메라 상태
  NCameraPosition? _nowCameraPosition;
  final int _animationMill = 300;

  // 흡연 구역을 받아옴
  void getArea() async {
    smokingAreaMap = await getSmokingArea();
  }

  // 제보 버튼이 눌렀는지 여부
  bool informPressed = false;

  String stringCoordinate(double? d) {
    if (d == null) {
      return 'null';
    } else {
      return d.toStringAsFixed(5);
    }
  }

  // 필터 목록
  final List<String> _mapFilterCharacterList = [
    '실외',
    '개방된',
    '한산한',
    '청결한',
    '의자가 있는',
  ];

  bool smokingAreaSelected = false;
  BottomDrawerController bottomDrawerController = BottomDrawerController();
  String smokingAreaId = '';
  String smokingAreaName = '';
  Map<String, dynamic> smokingAreaMap = {};

  @override
  Widget build(BuildContext context) {
    super.build(context);

    // 화면을 동적으로 빌드하기 위한 사이즈
    final Size size = MediaQuery.of(context).size;
    const double padding = 10;
    const double alignButtonSize = 40;
    const double searchWidth = double.infinity;
    const double iconSize = 25;
    final double mapHeight = size.height - kBottomNavigationBarHeight;

    // NaverMapController 객체의 비동기 작업 완료를 나타내는 Completer 생성
    final Completer<NaverMapController> mapControllerCompleter = Completer();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          // 지도 화면
          NaverMap(
            options: NaverMapViewOptions(
              initialCameraPosition: NCameraPosition(
                target: NLatLng(userLatitude, userLongitude),
                zoom: 14.0,
              ),
              locationButtonEnable: true, // 위치 버튼 표시 여부 설정
              consumeSymbolTapEvents: false, // 심볼 탭 이벤트 소비 여부 설정
            ),
            onMapReady: (controller) async {
              // 지도 준비 완료 시 호출되는 콜백 함수
              mapController = controller;
              mapControllerCompleter
                  .complete(controller); // Completer에 지도 컨트롤러 완료 신호 전송
              log("onMapReady", name: "onMapReady");
              // 마커를 지도 위에 추가
              var tmp = {
                "smokingAreas": [
                  {
                    "areaId": "area1",
                    "name": "국민대",
                    "latitude": null,
                    "longitude": null,
                    "address": "길음",
                    "createdAt": "2023-05-16T06:48:57.450179",
                    "status": true,
                    "description": null,
                    "score": null,
                    "opened": null,
                    "closed": null,
                    "hygiene": null,
                    "dirty": null,
                    "air_out": null,
                    "no_exist": null,
                    "indoor": null,
                    "outdoor": null,
                    "big": null,
                    "small": null,
                    "crowded": null,
                    "quite": null,
                    "chair": null
                  },
                  {
                    "areaId": "area2",
                    "name": "고려대",
                    "latitude": null,
                    "longitude": null,
                    "address": "길음",
                    "createdAt": "2023-05-16T06:48:57.450179",
                    "status": true,
                    "description": null,
                    "score": null,
                    "opened": null,
                    "closed": null,
                    "hygiene": null,
                    "dirty": null,
                    "air_out": null,
                    "no_exist": null,
                    "indoor": null,
                    "outdoor": null,
                    "big": null,
                    "small": null,
                    "crowded": null,
                    "quite": null,
                    "chair": null
                  }
                ]
              };
              // for (var data in smokingAreaMap['smokingAreas']) {
              //   if (data['latitude'] != null && data['longitude'] != null) {
              //     attachOverlay(
              //         data['areaId'], data['latitude'], data['longitude']);
              //   }
              // }
              // final Marker marker = Marker(
              //   mapController: mapController!,
              //   nOverlayInfoOverlayPortalController:
              //       nOverlayInfoOverlayPortalController,
              //   onCameraChangeStream: onCameraChangeStreamController.stream,
              // );

              attachOverlay(SaBasicModel(1, "국민대 도서관 1", 37.65640, 127.11670));
              attachOverlay(SaBasicModel(2, "국민대 도서관 2", 37.65690, 127.11720));
            },
            onMapTapped: (point, latLng) {
              smokingAreaSelected = false;
              debugPrint("${latLng.latitude}, ${latLng.longitude}");
            },
            onCameraChange: (reason, animated) {
              onCameraChangeStreamController.sink.add(null);
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: padding),
            child: Column(
              children: [
                const SizedBox(
                  height: 50,
                ),
                GestureDetector(
                  onTap: () {
                    context.push('/search');
                  },
                  child: Container(
                    width: searchWidth,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 0,
                          blurRadius: 2.0,
                          offset:
                              const Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.only(left: 10),
                    child: const Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(
                          Icons.search,
                          size: iconSize,
                        ),
                        SizedBox(width: 10),
                        Text(
                          "흡연구역 검색",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF6F767F),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(
                  height: padding,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    MapFilterListview(
                      characterList: _mapFilterCharacterList,
                    ),
                    const SizedBox(width: 10),
                    // 필터 설정 버튼
                    InkWell(
                      onTap: () {
                        filterScreen(context);
                      },
                      child: Container(
                        width: alignButtonSize,
                        height: alignButtonSize,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: const Color(0xFFD2D7DD)),
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 0,
                              blurRadius: 2.0,
                              offset: const Offset(
                                  0, 3), // changes position of shadow
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.format_list_bulleted_rounded,
                          size: iconSize,
                          color: Color(0xff6f767f),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: padding),
                // 제보 버튼
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                      onTap: () {
                        setState(() {
                          print(smokingAreaMap);
                          informPressed = !informPressed;
                          bottomDrawerController.open();
                        });
                      },
                      child: Container(
                        width: alignButtonSize,
                        height: alignButtonSize + 20,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: const Color(0xFFD2D7DD)),
                          borderRadius: BorderRadius.circular(30),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 0,
                              blurRadius: 2.0,
                              offset: const Offset(
                                  0, 3), // changes position of shadow
                            ),
                          ],
                        ),
                        child: const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.add_location_alt_outlined,
                              size: iconSize,
                              color: Color(0xff6f767f),
                            ),
                            Text(
                              '제보',
                              style: TextStyle(
                                  fontSize: 12, color: Color(0xff6f767f)),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(
                  height: mapHeight / 2 -
                      (50 +
                          50 +
                          padding +
                          alignButtonSize +
                          padding +
                          alignButtonSize +
                          20 +
                          alignButtonSize),
                ),

                // 제보를 누르면 등장하는 마커
                Visibility(
                  visible: informPressed,
                  child: Column(
                    children: [
                      const Icon(
                        Icons.add_location_alt,
                        color: Colors.red,
                        size: alignButtonSize,
                      ),
                      const SizedBox(
                        height: padding,
                      ),
                      // 제보하기를 누르면 등장하는 '제보하기' 버튼
                      SizedBox(
                        width: 100,
                        height: 40,
                        child: ElevatedButton(
                          onPressed: () {
                            context.push('/inform',
                                extra:
                                    '${stringCoordinate(_nowCameraPosition?.target.longitude)},${stringCoordinate(_nowCameraPosition?.target.latitude)}');
                          },
                          child: const Text('제보하기'),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Padding(
              padding: const EdgeInsets.all(padding),
              child: Visibility(
                visible: smokingAreaSelected,
                maintainAnimation: true,
                maintainState: true,
                child: SmokingAreaInfoCard(
                  smokingAreaId: smokingAreaId,
                  smokingAreaName: smokingAreaName,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void attachOverlay(SaBasicModel sa) async {
    final cameraPosition = mapController!.nowCameraPosition;
    final marker = NMarker(
      id: sa.id.toString(),
      position: NLatLng(sa.longitude, sa.latitude),
    );
    marker.setOnTapListener((overlay) async {
      smokingAreaId = sa.id.toString();
      smokingAreaName = sa.name;
      smokingAreaSelected = true;
    });
    mapController!.addOverlay(marker);
  }

  void onCameraChange() async {
    _nowCameraPosition = mapController?.nowCameraPosition;
    if (mounted) setState(() {});
  }

  void updateCamera(NCameraUpdate cameraUpdate) {
    mapController!.updateCamera(cameraUpdate
      ..setAnimation(duration: Duration(milliseconds: _animationMill)));
  }

  @override
  void initState() {
    super.initState();
    // getArea();
    onCameraChange();
    onCameraChangeStreamSubscription =
        onCameraChangeStreamController.stream.listen((_) => onCameraChange());
  }

  @override
  void dispose() {
    onCameraChangeStreamSubscription?.cancel();
    onCameraChangeStreamSubscription = null;
    super.dispose();
  }
}
