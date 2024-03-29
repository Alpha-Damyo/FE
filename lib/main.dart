import 'dart:developer';

import 'package:damyo/provider/filterlist_provider.dart';
import 'package:damyo/screens/home/inform/inform_screen.dart';
import 'package:damyo/screens/home/filter/filter_screen.dart';
import 'package:damyo/screens/home/map/somking_area/smoking_area_info_screen.dart';
import 'package:damyo/screens/login/login_screen.dart';
import 'package:damyo/screens/home/home_screen.dart';
import 'package:damyo/screens/signup/signup_screen.dart';
import 'package:damyo/secret.dart';
import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';

import 'package:provider/provider.dart';

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

// 갤러리 권한 조회
Future<bool> _getPhotoPermission() async {
  bool status = await Permission.photos.isGranted;
  if (status == true) {
    return Future.value(true);
  } else {
    return Future.value(false);
  }
}

// 권한 요청 & 권한 상태 객체 생성
void _requestPermission() async {
  Map<Permission, PermissionStatus> statusesLoc =
      await [Permission.location].request();
  Map<Permission, PermissionStatus> statusesCam =
      await [Permission.camera].request();
  Map<Permission, PermissionStatus> statusesPhotos =
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
  runApp(ChangeNotifierProvider(
    create: (context) => FilterList(),
    child: const App(),
  ));
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
      path: '/',
      builder: (context, state) => const HomeScreen(),
      routes: [
        GoRoute(
          name: 'filter',
          path: 'filter',
          builder: (context, state) {
            return const FilterScreen();
          },
        ),
      ],
    ),
    GoRoute(
      name: 'sa_info',
      path: '/sa_info',
      builder: (context, state) => const SmokingAreaInfoScreen(),
    ),
    GoRoute(
      name: 'login',
      path: '/login',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      name: 'signup',
      path: '/signup',
      builder: (context, state) => const SignupScreen(),
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
          bodyLarge: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
          bodyMedium: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }
}
