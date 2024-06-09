import 'package:damyo/models/userinfo/user_info_model.dart';
import 'package:damyo/provider/islogin_provider.dart';
import 'package:damyo/provider/userInfo_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class MypageScreen extends StatefulWidget {
  const MypageScreen({super.key});

  @override
  State<MypageScreen> createState() => _MypageScreenState();
}

UserInfoModel userInfoModel = UserInfoModel(
    "c8940db5-38ae-4eed-b641-c83a38d87dd8",
    "김민제",
    "kmj200050005@gmail.com",
    "2024-06-06T07:08:11.512128",
    "https://d2wcv86mbz7x2c.cloudfront.net/c7157892-d%EB%A9%80%ED%8B%B0%ED%8C%8C%ED%8A%B8%20%ED%85%8C%EC%8A%A4%ED%8A%B8%EC%9A%A9.jpg",
    0,
    "남자",
    33,
    50,
    463,
    "google",
    "106362899132468449802");

class _MypageScreenState extends State<MypageScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<IsLoginProvider>(
      builder: (context, isLoginProvider, child) {
        return ScreenUtilInit(
          designSize: const Size(390, 667),
          builder: (context, child) => Scaffold(
            appBar: AppBar(
              scrolledUnderElevation: 0,
              backgroundColor: Colors.white,
              title: const Text(
                '마이페이지',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontFamily: 'Pretendard',
                  fontWeight: FontWeight.w700,
                ),
              ),
              centerTitle: true,
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    width: 390.w,
                    height: 600.h,
                    clipBehavior: Clip.antiAlias,
                    decoration: const BoxDecoration(color: Color(0xFFF7F8FA)),
                    child: Stack(
                      children: [
                        Positioned(
                          left: 0,
                          top: 0,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (isLoginProvider.isLogin)
                                LoggedPage()
                              else
                                LoginPage(),
                              SizedBox(height: 10.h),
                              Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 16.w, vertical: 20.h),
                                decoration:
                                    const BoxDecoration(color: Colors.white),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    GestureDetector(
                                      behavior: HitTestBehavior.opaque,
                                      onTap: () {
                                        GoRouter.of(context).push('/favorite');
                                      },
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          const Text(
                                            '즐겨찾기 관리',
                                            style: TextStyle(
                                              color: Color(0xFF262B32),
                                              fontSize: 16,
                                              fontFamily: 'Pretendard',
                                              fontWeight: FontWeight.w500,
                                            ),
                                            textAlign: TextAlign.left,
                                          ),
                                          SizedBox(width: 246.w),
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: 20.h),
                                    Container(
                                      width: 358.w,
                                      decoration: const ShapeDecoration(
                                        shape: RoundedRectangleBorder(
                                          side: BorderSide(
                                            width: 1,
                                            strokeAlign:
                                                BorderSide.strokeAlignCenter,
                                            color: Color(0xFFEEF1F4),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 20.h),
                                    SizedBox(
                                      width: 340.w,
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          const Expanded(
                                            child: SizedBox(
                                              child: Text(
                                                '흡연구역 업데이트',
                                                style: TextStyle(
                                                  color: Color(0xFF262B32),
                                                  fontSize: 16,
                                                  fontFamily: 'Pretendard',
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(width: 165.w),
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: 20.h),
                                    Container(
                                      width: 358.w,
                                      decoration: const ShapeDecoration(
                                        shape: RoundedRectangleBorder(
                                          side: BorderSide(
                                            width: 1,
                                            strokeAlign:
                                                BorderSide.strokeAlignCenter,
                                            color: Color(0xFFEEF1F4),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 20.h),
                                    GestureDetector(
                                      behavior: HitTestBehavior.opaque,
                                      onTap: () {
                                        GoRouter.of(context)
                                            .push('/achievement');
                                      },
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          const Text(
                                            '업적 & 기여도',
                                            style: TextStyle(
                                              color: Color(0xFF262B32),
                                              fontSize: 16,
                                              fontFamily: 'Pretendard',
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          SizedBox(width: 250.w),
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: 20.h),
                                    Container(
                                      width: 358.w,
                                      decoration: const ShapeDecoration(
                                        shape: RoundedRectangleBorder(
                                          side: BorderSide(
                                            width: 1,
                                            strokeAlign:
                                                BorderSide.strokeAlignCenter,
                                            color: Color(0xFFEEF1F4),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 20.h),
                                    SizedBox(
                                      width: 340.w,
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          const Expanded(
                                            child: SizedBox(
                                              child: Text(
                                                '흡연데이터 초기화',
                                                style: TextStyle(
                                                  color: Color(0xFF262B32),
                                                  fontSize: 16,
                                                  fontFamily: 'Pretendard',
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(width: 75.w),
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: 20.h),
                                    Container(
                                      width: 358.w,
                                      decoration: const ShapeDecoration(
                                        shape: RoundedRectangleBorder(
                                          side: BorderSide(
                                            width: 1,
                                            strokeAlign:
                                                BorderSide.strokeAlignCenter,
                                            color: Color(0xFFEEF1F4),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 20.h),
                                    SizedBox(
                                      width: 340.w,
                                      height: 19.h,
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          const Expanded(
                                            child: SizedBox(
                                              child: Text(
                                                '푸쉬 알림',
                                                style: TextStyle(
                                                  color: Color(0xFF262B32),
                                                  fontSize: 16,
                                                  fontFamily: 'Pretendard',
                                                  fontWeight: FontWeight.w500,
                                                  height: 0,
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(width: 57.w),
                                          Container(
                                            padding: EdgeInsets.all(3.w),
                                            decoration: ShapeDecoration(
                                              color: const Color(0xFF0099FC),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(18.r),
                                              ),
                                            ),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Container(
                                                  width: 16.w,
                                                  height: 16.h,
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 10.w,
                                                      vertical: 5.h),
                                                  clipBehavior: Clip.antiAlias,
                                                  decoration: ShapeDecoration(
                                                    color:
                                                        const Color(0xFF0099FC),
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              16.r),
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  width: 16.w,
                                                  height: 16.h,
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 10.w,
                                                      vertical: 5.h),
                                                  clipBehavior: Clip.antiAlias,
                                                  decoration: ShapeDecoration(
                                                    color: Colors.white,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              16.r),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: 20.h),
                                    Container(
                                      width: 358.w,
                                      decoration: const ShapeDecoration(
                                        shape: RoundedRectangleBorder(
                                          side: BorderSide(
                                            width: 1,
                                            strokeAlign:
                                                BorderSide.strokeAlignCenter,
                                            color: Color(0xFFEEF1F4),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 20.h),
                                    SizedBox(
                                      width: 340.w,
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          const Expanded(
                                            child: SizedBox(
                                              child: Text(
                                                '앱 버전',
                                                style: TextStyle(
                                                  color: Color(0xFF262B32),
                                                  fontSize: 16,
                                                  fontFamily: 'Pretendard',
                                                  fontWeight: FontWeight.w500,
                                                  height: 0,
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(width: 82.w),
                                          const Text(
                                            '3.4',
                                            style: TextStyle(
                                              color: Color(0xFFA8AFB6),
                                              fontSize: 14,
                                              fontFamily: 'Pretendard',
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget LoginPage() {
    return Container(
      padding: EdgeInsets.only(
        top: 20.h,
        left: 16.w,
        right: 16.w,
        bottom: 20.h,
      ),
      decoration: const BoxDecoration(color: Colors.white),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '로그인 / 회원가입',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontFamily: 'Pretendard',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 6.h),
                  const Text(
                    '담요와 함께 바른 문화를 만들어봐요 ! ',
                    style: TextStyle(
                      color: Color(0xFF6E767F),
                      fontSize: 14,
                      fontFamily: 'Pretendard',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
              SizedBox(width: 148.w),
            ],
          ),
          SizedBox(height: 24.h),
          Container(
            width: 358.w,
            padding: EdgeInsets.symmetric(horizontal: 55.w, vertical: 12.h),
            clipBehavior: Clip.antiAlias,
            decoration: ShapeDecoration(
              color: const Color(0xFFEEF1F4),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.r),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    context.push('/login');
                  },
                  child: const Text(
                    '로그인/회원가입 하러 가기',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontFamily: 'Pretendard',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget LoggedPage() {
    return Container(
      width: 390.w,
      height: 189.h,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
      decoration: const BoxDecoration(color: Colors.white),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 358.w,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: 84.h,
                      clipBehavior: Clip.antiAlias,
                      decoration: ShapeDecoration(
                        color: const Color(0xFFDEDEDE),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50.r),
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 84.w,
                            height: 84.h,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage(userInfoModel.profileUrl!),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 15.w),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          userInfoModel.name!,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontFamily: 'Pretendard',
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(height: 6.h),
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 10.w, vertical: 5.h),
                          clipBehavior: Clip.antiAlias,
                          decoration: ShapeDecoration(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              side: const BorderSide(
                                  width: 1, color: Color(0xFFDEDEDE)),
                              borderRadius: BorderRadius.circular(5.r),
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                '바른 문화 기여도: ${Provider.of<UserInfoProvider>(context).score}점',
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 12,
                                  fontFamily: 'Pretendard',
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(width: 70.w),
                IconButton(
                    onPressed: () {
                      context.push('/update_profile');
                    },
                    icon: const Icon(Icons.keyboard_arrow_right)),
                SizedBox(width: 10.w),
              ],
            ),
          ),
          SizedBox(height: 24.h),
          Container(
            width: 358.w,
            padding: EdgeInsets.symmetric(horizontal: 55.w, vertical: 12.h),
            clipBehavior: Clip.antiAlias,
            decoration: ShapeDecoration(
              color: const Color(0xFFEEF1F4),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.r),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    Provider.of<IsLoginProvider>(context, listen: false)
                        .logout();
                  },
                  child: const Text(
                    '로그아웃',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontFamily: 'Pretendard',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
