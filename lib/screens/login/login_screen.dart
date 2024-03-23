import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_naver_login/flutter_naver_login.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  FlutterSecureStorage storage = const FlutterSecureStorage();

  void signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    if (googleUser != null) {
      print('name = ${googleUser.displayName}');
      print('email = ${googleUser.email}');
      print('id = ${googleUser.id}');

      await storage.write(key: 'userID', value: googleUser.email);
      // 읽고 싶을 때는
      // String? id = await storage.read(key: 'userID');
    }
  }

  void signInWithNaver() async {
    NaverLoginResult naverUser = await FlutterNaverLogin.logIn();
    // final NaverLoginResult User = await FlutterNaverLogin.logIn();
    NaverAccessToken naverToken = await FlutterNaverLogin.currentAccessToken;

    // print(naverUser.accessToken);
    print('name = ${naverUser.account.name}');
    print('email = ${naverUser.account.email}');
    print('id = ${naverUser.account.id}');
    setState(() {});
  }

  void signOutWithNaver() async {
    FlutterNaverLogin.logOut();
  }

  void signInWithKakao() async {
    if (await isKakaoTalkInstalled()) {
      try {
        await UserApi.instance.loginWithKakaoTalk();
        print('카카오톡으로 로그인 성공');
      } catch (error) {
        print('카카오톡으로 로그인 실패 $error');
        // 사용자가 카카오톡 설치 후 디바이스 권한 요청 화면에서 로그인을 취소한 경우,
        // 의도적인 로그인 취소로 보고 카카오계정으로 로그인 시도 없이 로그인 취소로 처리 (예: 뒤로 가기)
        if (error is PlatformException && error.code == 'CANCELED') {
          return;
        }
        // 카카오톡에 연결된 카카오계정이 없는 경우, 카카오계정으로 로그인
        try {
          await UserApi.instance.loginWithKakaoAccount();
          print('카카오계정으로 로그인 성공');
        } catch (error) {
          print('카카오계정으로 로그인 실패 $error');
        }
      }
    } else {
      try {
        await UserApi.instance.loginWithKakaoAccount();
        print('카카오계정으로 로그인 성공');
      } catch (error) {
        print('카카오계정으로 로그인 실패 $error');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Flexible(
            flex: 1,
            fit: FlexFit.tight,
            child: Text(''),
          ),
          Flexible(
            flex: 1,
            child: Container(
              alignment: Alignment.center,
              child: const Text(
                '로그인',
                style: TextStyle(fontSize: 100),
              ),
            ),
          ),
          Flexible(
            flex: 2,
            child: Container(
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () {
                      signInWithGoogle();
                    },
                    icon: const Icon(
                      Icons.g_mobiledata,
                      size: 130,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      signInWithKakao();
                    },
                    icon: const Icon(
                      Icons.chat_bubble_outline,
                      size: 100,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      signInWithNaver();
                    },
                    icon: const Icon(
                      Icons.adb,
                      size: 100,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
