import 'dart:async';

import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:go_router/go_router.dart';

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

  // 사용자의 현재 위치를 받아오는 함수

  // void _getCurrentLocation() async {
  //   Location location = Location();
  //   bool serviceEnabled;
  //   PermissionStatus permissionGranted;
  //   LocationData locationData;

  //   serviceEnabled = await location.serviceEnabled();
  //   if (!serviceEnabled) {
  //     serviceEnabled = await location.requestService();
  //     if (!serviceEnabled) {
  //       return;
  //     }
  //   }

  //   permissionGranted = await location.hasPermission();
  //   if (permissionGranted == PermissionStatus.denied) {
  //     permissionGranted = await location.requestPermission();
  //     if (permissionGranted != PermissionStatus.granted) {
  //       return;
  //     }
  //   }

  //   locationData = await location.getLocation();
  //   print(locationData.longitude);
  // }

  // 지도  핵심 worker
  NaverMapController? mapController;
  final onCameraChangeStreamController = StreamController<void>.broadcast();
  StreamSubscription<void>? onCameraChangeStreamSubscription;

  // 현재 카메라 상태
  NCameraPosition? _nowCameraPosition;
  final int _animationMill = 300;

  void onCameraChange() async {
    _nowCameraPosition = mapController?.nowCameraPosition;
    if (mounted) setState(() {});
  }

  void updateCamera(NCameraUpdate cameraUpdate) {
    mapController?.updateCamera(cameraUpdate
      ..setAnimation(duration: Duration(milliseconds: _animationMill)));
  }

  // 제보 버튼이 눌렀는지 여부
  bool informPressed = false;

  String stringCoordinate(double? d) {
    if (d == null) {
      return 'null';
    } else {
      var s = d.toString().split('.');
      return '${s[0]}.${s[1].substring(0, 5)}';
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    // 화면을 동적으로 빌드하기 위한 사이즈
    final Size size = MediaQuery.of(context).size;
    final double searchMargin = size.width * 0.05;
    final double margin = size.width * 0.025;
    final double alignButtonSize = size.height * 0.05;
    final double searchWidth =
        size.width - 2 * searchMargin - margin - alignButtonSize;
    final double iconSize = alignButtonSize * 0.5;
    final double mapHeight = size.height - kBottomNavigationBarHeight;

    // NaverMapController 객체의 비동기 작업 완료를 나타내는 Completer 생성
    final Completer<NaverMapController> mapControllerCompleter = Completer();

    // _getCurrentLocation();
    return Scaffold(
      body: Stack(
        children: [
          // 지도 화면
          NaverMap(
            options: const NaverMapViewOptions(
              // initialCameraPosition: NCameraPosition(
              // target: NLatLng(37.56659, 126.97899),
              //   zoom: 14.0,
              // ),
              locationButtonEnable: true, // 위치 버튼 표시 여부 설정
              consumeSymbolTapEvents: false, // 심볼 탭 이벤트 소비 여부 설정
            ),
            onMapReady: (controller) async {
              // 지도 준비 완료 시 호출되는 콜백 함수
              mapController = controller;
              mapControllerCompleter
                  .complete(controller); // Completer에 지도 컨트롤러 완료 신호 전송
              log("onMapReady", name: "onMapReady");
            },
            onMapTapped: (point, latLng) {
              debugPrint("${latLng.latitude}, ${latLng.longitude}");
            },
            onCameraChange: (reason, animated) {
              onCameraChangeStreamController.sink.add(null);
            },
          ),
          Positioned.fill(
            child: Column(
              children: [
                SizedBox(
                  height: margin * 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 검색창
                    Container(
                      width: searchWidth,
                      height: alignButtonSize,
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      child: Row(
                        children: [
                          Icon(
                            Icons.search,
                            size: iconSize,
                          ),
                          const Text(
                            ' 검색창 입니다',
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: margin,
                    ),
                    // 여백
                    Column(
                      children: [
                        // 정렬 버튼
                        Container(
                          width: alignButtonSize,
                          height: alignButtonSize,
                          decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.primary,
                              borderRadius: const BorderRadius.all(
                                Radius.circular(20),
                              )),
                          child: FloatingActionButton(
                            heroTag: "alignbtn",
                            onPressed: () {},
                            child: Icon(
                              Icons.format_list_bulleted_rounded,
                              size: iconSize,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: margin,
                        ),
                        // 제보 버튼 (임시)
                        SizedBox(
                          width: alignButtonSize,
                          height: alignButtonSize,
                          child: FloatingActionButton(
                            heroTag: "informbtn",
                            onPressed: () {
                              setState(() {
                                informPressed = !informPressed;
                              });
                            },
                            backgroundColor: Theme.of(context).primaryColor,
                            child: Icon(Icons.add_location_alt_outlined,
                                size: iconSize),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: mapHeight / 2 - (margin * 6 + alignButtonSize * 3),
                ),

                // 제보를 누르면 등장하는 마커
                Visibility(
                  visible: informPressed,
                  child: Column(
                    children: [
                      Icon(
                        Icons.add_location_alt,
                        color: Colors.red,
                        size: alignButtonSize,
                      ),
                      SizedBox(
                        height: margin,
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

          // 위도 경도 임시 출력
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              color: Colors.blue,
              child: Text(
                '위도: ${stringCoordinate(_nowCameraPosition?.target.latitude)} 경도: ${stringCoordinate(_nowCameraPosition?.target.longitude)}',
                style: const TextStyle(fontSize: 20),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
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
