import 'dart:async';

import 'dart:developer';
import 'package:bottom_drawer/bottom_drawer.dart';
import 'package:damyo/main.dart';
import 'package:damyo/screens/home/map/ovelay_util.dart';
import 'package:damyo/screens/home/map/somking_area/smoking_area_info_card.dart';
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

  // 제보 버튼이 눌렀는지 여부
  bool informPressed = false;

  String stringCoordinate(double? d) {
    if (d == null) {
      return 'null';
    } else {
      return d.toStringAsFixed(5);
    }
  }

  // 필터 눌렸는지 여부
  final List<bool> isPressedFilter = List.generate(12, (index) => false);
  // 필터 색깔 지정
  Color _colors = Colors.white;

  Color changeColor(bool state, int index) {
    if (state) {
      // print(_state);
      _colors = Colors.red;
      return _colors;
    } else {
      // print(_state);
      _colors = Colors.white;
      return _colors;
    }
  }

  bool smokingAreaSelected = false;
  BottomDrawerController bottomDrawerController = BottomDrawerController();
  String smokingAreaId = '';

  @override
  Widget build(BuildContext context) {
    super.build(context);

    // 화면을 동적으로 빌드하기 위한 사이즈
    final Size size = MediaQuery.of(context).size;
    const double padding = 10;
    const double alignButtonSize = 53;
    final double searchWidth = size.width - 3 * padding - alignButtonSize;
    const double iconSize = 25;
    final double mapHeight = size.height - kBottomNavigationBarHeight;

    // NaverMapController 객체의 비동기 작업 완료를 나타내는 Completer 생성
    final Completer<NaverMapController> mapControllerCompleter = Completer();

    // 필터 목록을 구독
    final List<Map<String, dynamic>> filters =
        Provider.of<FilterList>(context, listen: true).filterList;
    // 필터 버튼 상태
    final List<List<String>> filtersItem =
        Provider.of<FilterList>(context, listen: false).filterItem;

    return ScreenUtilInit(
      designSize: const Size(390, 733),
      builder: (context, child) => Scaffold(
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
                // final Marker marker = Marker(
                //   mapController: mapController!,
                //   nOverlayInfoOverlayPortalController:
                //       nOverlayInfoOverlayPortalController,
                //   onCameraChangeStream: onCameraChangeStreamController.stream,
                // );
                attachOverlay("1", 37.65640, 127.11670);
                attachOverlay("2", 37.65690, 127.11720);
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
              padding: const EdgeInsets.all(padding),
              child: Column(
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: searchWidth,
                        height: alignButtonSize,
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        child: const Row(
                          children: [
                            Icon(
                              Icons.search,
                              size: iconSize,
                            ),
                            Text(
                              ' 검색창 입니다',
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                      ),
                      // 필터 설정 버튼
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
                          onPressed: () {
                            filterScreen(context);
                          },
                          child: const Icon(
                            Icons.format_list_bulleted_rounded,
                            size: iconSize,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(
                    height: padding,
                  ),
                  // 여백
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // 필터 목록
                      SizedBox(
                        height: 50,
                        width: searchWidth,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: isPressedFilter.length, // 필터의 개수만큼 아이템 생성
                          itemBuilder: (context, index) {
                            return ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  isPressedFilter[index] =
                                      !isPressedFilter[index];
                                  changeColor(isPressedFilter[index], index);
                                });
                                if (isPressedFilter[index]) {
                                  Provider.of<FilterList>(context,
                                          listen: false)
                                      .changeFilterList(
                                          filters[index ~/ 2].keys.first,
                                          index % 2);
                                } else {
                                  Provider.of<FilterList>(context,
                                          listen: false)
                                      .changeFilterList(
                                          filters[index ~/ 2].keys.first, -1);
                                }
                                // print(filters[index~/2].values.first);
                                print(filters);
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: _colors = changeColor(
                                      isPressedFilter[index], index)),
                              child: Text(filtersItem[index ~/ 2][index % 2]),
                            );
                          },
                        ),
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
                              bottomDrawerController.open();
                            });
                          },
                          backgroundColor:
                              Theme.of(context).colorScheme.background,
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
                    height: mapHeight / 2 - (padding * 6 + alignButtonSize * 3),
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
                  ),
                ),
              ),
            ),

            // 위도 경도 임시 출력
            // Positioned(
            //   left: 0,
            //   right: 0,
            //   bottom: 0,
            //   child: Container(
            //     color: Colors.blue,
            //     child: Text(
            //       '위도: ${stringCoordinate(_nowCameraPosition?.target.latitude)} 경도: ${stringCoordinate(_nowCameraPosition?.target.longitude)}',
            //       style: const TextStyle(fontSize: 20),
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

  Future<dynamic> filterScreen(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
          width: double.infinity,
          height: 527.h,
          child: Material(
              color: Colors.white,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 14.h),
                          Align(
                            alignment: Alignment.center,
                            child: Container(
                              width: 35.w,
                              height: 5.h,
                              decoration: BoxDecoration(
                                color: const Color(0xffe4e7eB),
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                          ),
                          SizedBox(height: 36.h),
                          Text(
                            "별점",
                            style: Theme.of(context).textTheme.displaySmall,
                          ),
                          const SizedBox(height: 20),
                          Text(
                            "실내 여부",
                            style: Theme.of(context).textTheme.displaySmall,
                          ),
                          const SizedBox(height: 20),
                          Text(
                            "리뷰",
                            style: Theme.of(context).textTheme.displaySmall,
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                    InkWell(
                      onTap: () {},
                      child: Ink(
                        width: double.infinity,
                        height: 47.h,
                        decoration: const BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.all(Radius.circular(16)),
                        ),
                        child: const Align(
                          alignment: Alignment.center,
                          child: Text(
                            '적용하기',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ) // 모달 내부 디자인 영역
              ),
        );
      },
    );
  }

  void attachOverlay(String id, double lat, double lng) async {
    final cameraPosition = mapController!.nowCameraPosition;
    final marker = NMarker(
      id: id,
      position: NLatLng(lat, lng),
    );
    marker.setOnTapListener((overlay) async {
      smokingAreaId = id;
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
