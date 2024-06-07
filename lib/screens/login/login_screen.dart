import 'package:damyo/provider/islogin_provider.dart';
import 'package:damyo/services/login_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_naver_login/flutter_naver_login.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (Provider.of<IsLoginProvider>(context, listen: false).isLogin) {
        GoRouter.of(context).pop();
      }
    });
  }

  void checkLoginState(dynamic userInfo) {
    print(userInfo.statusCode);
    if (userInfo.statusCode != null) {
      context.push('/login/signup');
    } else {
      context.pop();
    }
  }

  FlutterSecureStorage storage = const FlutterSecureStorage();

  void signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    if (googleUser != null) {
      print('name = ${googleUser.displayName}');
      print('email = ${googleUser.email}');
      print('id = ${googleUser.id}');

      await storage.write(key: 'userID', value: googleUser.email);
      await storage.write(key: 'sns', value: "google");
      // 읽고 싶을 때는
      // String? id = await storage.read(key: 'userID');
      Provider.of<IsLoginProvider>(context, listen: false).login();
      //checkLoginState();
    }
  }

  void signInWithNaver() async {
    NaverLoginResult naverUser = await FlutterNaverLogin.logIn();
    // final NaverLoginResult User = await FlutterNaverLogin.logIn();
    NaverAccessToken naverToken = await FlutterNaverLogin.currentAccessToken;
    dynamic userInfo;

    // print(naverUser.accessToken);
    if (naverUser != null) {
      print('name = ${naverUser.account.name}');
      print('email = ${naverUser.account.email}');
      print('id = ${naverUser.account.id}');
      await storage.write(key: 'userID', value: naverUser.account.email);
      await storage.write(key: 'sns', value: "naver");
      Provider.of<IsLoginProvider>(context, listen: false).login();
      userInfo = await login(naverToken.toString());
      checkLoginState(userInfo);
    }
    setState(() {});
  }

  void signOutWithNaver() async {
    FlutterNaverLogin.logOut();
  }

  void signInWithKakao() async {
    dynamic userInfo;
    if (await isKakaoTalkInstalled()) {
      try {
        OAuthToken token = await UserApi.instance.loginWithKakaoTalk();
        String accessToken = token.accessToken;
        print(accessToken);
        print('카카오톡으로 로그인 성공');
        try {
          User user = await UserApi.instance.me();
          print('사용자 정보 요청 성공'
              '\n회원번호: ${user.id}'
              '\n닉네임: ${user.kakaoAccount?.profile?.nickname}'
              '\n이메일: ${user.kakaoAccount?.email}');
          await storage.write(key: 'userID', value: ("${user.id}@kakao.com"));
          await storage.write(key: 'logintoken', value: token.toString());
          await storage.write(key: 'sns', value: "kakao");
          //Provider.of<IsLoginProvider>(context, listen: false).login();
          //login(token.toString());
          userInfo = await login("${user.id}@kakao.com");
          print(userInfo);
          checkLoginState(userInfo);
        } catch (error) {
          print('사용자 정보 요청 실패1 $error');
        }
      } catch (error) {
        print('카카오톡으로 로그인 실패1 $error');
        // 사용자가 카카오톡 설치 후 디바이스 권한 요청 화면에서 로그인을 취소한 경우,
        // 의도적인 로그인 취소로 보고 카카오계정으로 로그인 시도 없이 로그인 취소로 처리 (예: 뒤로 가기)
        if (error is PlatformException && error.code == 'CANCELED') {
          return;
        }
        // 카카오톡에 연결된 카카오계정이 없는 경우, 카카오계정으로 로그인
        try {
          OAuthToken token = await UserApi.instance.loginWithKakaoAccount();
          String accessToken = token.accessToken;
          print('카카오계정으로 로그인 성공2');
          try {
            User user = await UserApi.instance.me();
            print('사용자 정보 요청 성공'
                '\n회원번호: ${user.id}'
                '\n닉네임: ${user.kakaoAccount?.profile?.nickname}'
                '\n이메일: ${user.kakaoAccount?.email}');
            await storage.write(key: 'userID', value: ("${user.id}@kakao.com"));
            await storage.write(key: 'logintoken', value: token.toString());
            await storage.write(key: 'sns', value: "kakao");
            userInfo = await login("${user.id}@kakao.com");
            print(userInfo);
            checkLoginState(userInfo);
          } catch (error) {
            print('사용자 정보 요청 실패2 $error');
          }
        } catch (error) {
          print('카카오계정으로 로그인 실패2 $error');
        }
      }
    } else {
      try {
        OAuthToken token = await UserApi.instance.loginWithKakaoAccount();
        String accessToken = token.accessToken;
        print(accessToken);
        print('카카오계정으로 로그인 성공3');
        try {
          User user = await UserApi.instance.me();
          print('사용자 정보 요청 성공'
              '\n회원번호: ${user.id}'
              '\n닉네임: ${user.kakaoAccount?.profile?.nickname}'
              '\n이메일: ${user.kakaoAccount?.email}');
          await storage.write(key: 'userID', value: ("${user.id}@kakao.com"));
          await storage.write(key: 'logintoken', value: token.toString());
          await storage.write(key: 'sns', value: "kakao");
          userInfo = await login("${user.id}@kakao.com");
          print(userInfo);
          checkLoginState(userInfo);
        } catch (error) {
          print('사용자 정보 요청 실패3 $error');
        }
      } catch (error) {
        print('카카오계정으로 로그인 실패3 $error');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 667),
      builder: (context, child) => Scaffold(
        appBar: AppBar(
          scrolledUnderElevation: 0,
          centerTitle: true,
          foregroundColor: Colors.black,
          title: const Text('로그인',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 28,
                  fontFamily: 'Pretendard',
                  fontWeight: FontWeight.w700)),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              GoRouter.of(context).pop();
            },
          ),
        ),
        body: Container(
          width: 390.w,
          height: 600.h,
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 89.h),
              Container(
                width: 158.w,
                height: 161.h,
                padding: EdgeInsets.all(4.w),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.r),
                  color: Colors.white,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 150.w,
                      height: 150.h,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/icons/login_logo.png'),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 15.h),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 15.h),
                  const Text(
                    '담요의 재미있는 서비스와 혜택을 누려보세요 !',
                    style: TextStyle(
                      color: Color(0xFF6E767F),
                      fontSize: 14,
                      fontFamily: 'Pretendard',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 60.h),
              GestureDetector(
                onTap: signInWithGoogle,
                child: buildLoginButton(
                  text: '구글로 계속하기',
                  backgroundColor: Colors.white,
                  imageUrl: "assets/icons/google.png",
                ),
              ),
              SizedBox(height: 15.h),
              GestureDetector(
                onTap: signInWithKakao,
                child: buildLoginButton(
                  text: '카카오로 계속하기',
                  backgroundColor: const Color(0xFFF9E000),
                  imageUrl: "assets/icons/kakao.png",
                ),
              ),
              SizedBox(height: 15.h),
              GestureDetector(
                onTap: signInWithNaver,
                child: buildLoginButton(
                  text: '네이버로 계속하기',
                  backgroundColor: const Color(0xFF00C73C),
                  imageUrl: "assets/icons/naver.png",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildLoginButton({
    required String text,
    required Color backgroundColor,
    required String imageUrl,
  }) {
    return Container(
      width: 240.w,
      height: 50.h,
      decoration: BoxDecoration(
        color: backgroundColor,
        border: Border.all(
          color: Colors.black,
          width: 0.1,
        ),
        borderRadius: BorderRadius.circular(25.r),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            // width: 24.w,
            // height: 24.h,
            padding: EdgeInsets.all(2.w),
            decoration: BoxDecoration(
              color: backgroundColor,
              shape: BoxShape.circle,
            ),
            child: Container(
              width: 20.w,
              height: 20.h,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(imageUrl),
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
          SizedBox(width: 6.w),
          Text(
            text,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 14,
              fontFamily: 'Pretendard',
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
