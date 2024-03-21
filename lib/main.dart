import 'dart:developer';

import 'package:damyo/screens/home/inform/inform_screen.dart';
import 'package:damyo/screens/login/login_screen.dart';
import 'package:damyo/screens/home/home_screen.dart';
import 'package:damyo/secret.dart';
import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';

// 지도 초기화
Future<void> _initializeMap() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NaverMapSdk.instance.initialize(
      clientId: secretNaverCloudId,
      onAuthFailed: (e) => log("인증오류 : $e", name: "onAuthFailed"));
}

// 카카오 sdk 초기화
void _initializeKakao() {
  KakaoSdk.init(
    nativeAppKey: secretKakaoNativeAppKey,
    javaScriptAppKey: secretKakaoJavaScriptAppKey,
  );
}

// 위치 권환 조회
Future<bool> _getLocationPermission() async {
  bool status = await Permission.location.isGranted;
  if (status == true) {
    return true;
  } else {
    return false;
  }
}

// 카메라 권한 조회
Future<bool> _getCameraPermission() async {
  bool status = await Permission.camera.isGranted;
  if (status == true) {
    return Future.value(true);
  } else {
    return Future.value(false);
  }
}
// 카메라 권한 조회
Future<bool> _getPhotoPermission() async {
  bool status = await Permission.photos.isGranted;
  if (status == true) {
    return Future.value(true);
  } else {
    return Future.value(false);
  }
}

// // 위치 권한
// Future<bool> _requestLocationPermission(Map<Permission, PermissionStatus> statuses) async {
//   if(statuses[Permission.location]!.isGranted){
//     return Future.value(true);
//   }
//   else{
//     openAppSettings();
//     return Future.value(false);
//   }
// }

// // 카메라 권한
// Future<bool> _requestCameraPermission(Map<Permission, PermissionStatus> statuses) async {
//   if(statuses[Permission.camera]!.isGranted){
//     return Future.value(true);
//   }
//   else{
//     openAppSettings();
//     return Future.value(false);
//   }
// }

// 권한 요청 & 권한 상태 객체 생성
void _requestPermission() async{
  Map<Permission, PermissionStatus> statuses_loc =
    await [Permission.location].request();
  Map<Permission, PermissionStatus> statuses_cam =
    await [Permission.camera].request();
  Map<Permission, PermissionStatus> statuses_photos =
    await [Permission.photos].request();
  // _requestLocationPermission(statuses_loc);
  // _requestCameraPermission(statuses_cam);
}

// 사용자의 현재 위치를 받아오는 함수
double userLatitude = 37.56660;
double userLongitude = 126.97900;
Future<void> _getCurrentLocation() async {
  LocationPermission permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
  }
  try {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    userLatitude = position.latitude;
    userLongitude = position.longitude;
  } catch (e) {
    print(e);
  }
}

void main() async {
  await _initializeMap();
  _requestPermission();
  await _getCurrentLocation();
  // Kakao sdk 초기화
  _initializeKakao();
  runApp(const App());
}

final GoRouter router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomeScreen(),
      routes: [
        GoRoute(
          name: 'inform',
          path: 'inform',
          builder: (context, state) {
            return const InformScreen();
          },
        ),
      ],
    ),
    GoRoute(
      name: 'login',
      path: '/login',
      builder: (context, state) => const LoginScreen(),
    ),
  ],
);

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
      theme: ThemeData(
        fontFamily: 'pretendard',
        colorScheme: ColorScheme.fromSwatch(
          backgroundColor: Colors.white,
          accentColor: const Color(0xff0099fc),
        ),
        textTheme: const TextTheme(
          headlineLarge: TextStyle(
              fontFamily: 'pretendard',
              fontSize: 20,
              fontWeight: FontWeight.w200),
          titleMedium: TextStyle(
              fontFamily: 'pretendard',
              fontSize: 20,
              fontWeight: FontWeight.w600),
          bodyMedium: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }
}
