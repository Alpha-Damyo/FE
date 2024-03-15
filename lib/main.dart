import 'dart:developer';

import 'package:damyo/screens/home/inform/inform_screen.dart';
import 'package:damyo/screens/login/login_screen.dart';
import 'package:damyo/screens/home/home_screen.dart';
import 'package:damyo/secret.dart';
import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
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

// 위치 권한 요청
Future<bool> _requestLocationPermission() async {
  Map<Permission, PermissionStatus> statuses =
      await [Permission.storage, Permission.location].request();
  if (statuses[Permission.storage]!.isGranted) {
    return Future.value(true);
  } else {
    openAppSettings();
    return Future.value(false);
  }
}

void main() async {
  await _initializeMap();
  // await _requestLocationPermission();
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
