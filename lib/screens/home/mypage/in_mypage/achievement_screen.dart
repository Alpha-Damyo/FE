import 'dart:async';

import 'package:damyo/models/userinfo/user_info_model.dart';
import 'package:damyo/screens/home/mypage/in_mypage/updateprofile_screen.dart';
import 'package:damyo/services/user_controller_service.dart';
import 'package:damyo/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:damyo/style.dart';

List<int> contributionPoint = [5, 50, 100, 500];

class AchievementScreen extends StatefulWidget {
  const AchievementScreen({super.key});

  @override
  State<AchievementScreen> createState() => _AchievementScreen();
}

class _AchievementScreen extends State<AchievementScreen> {
  int? contributionScore;
  int? contributionGap;
  double? contributionPecentage;
  String? profileUrl;
  String? name;
  bool _isLoading = true;

  // 유저 정보를 가져오는 함수
  Future<UserInfoModel?> getUser() async {
    UserInfoModel? user = await getUserInfo();
    if (user != null) {
      setState(() {
        contributionScore = user.contribution;
        contributionGap = user.gap;
        contributionPecentage = user.percentage;
        profileUrl = user.profileUrl;
      });
    } else {
      setState(() {
        contributionScore = 0;
        contributionGap = null;
        contributionPecentage = 100;
        profileUrl = null;
      });
    }
  }

  Future<void> _loadData(int term) async {
    Timer(Duration(milliseconds: term), () {
      setState(() {
        _isLoading = false;
      });
    });
  }

  @override
  void initState() {
    _loadData(500);
    getUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 755),
      builder: (context, child) => Scaffold(
        appBar: AppBar(
          scrolledUnderElevation: 0,
          backgroundColor: Colors.white,
          title: textFormat(
              text: '나의 기여도', fontSize: 20, fontWeight: FontWeight.w700),
          centerTitle: true,
        ),
        body: _isLoading
            ? const Align(
              alignment: Alignment.center,
              child: SizedBox(
                width: 50.0, // 원하는 너비
                height: 50.0, // 원하는 높이
                child: CircularProgressIndicator(),
              ),
            )
            : Column(
                children: [
                  SizedBox(height: 10.h),
                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Column(
                        children: [
                          UserInfo(contributionScore!, contributionPecentage!,
                              contributionGap, profileUrl),
                          badgeList(contributionScore!),
                          explane(),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}

Widget badgeList(int contributionScore) {
  return Container(
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(color: Colors.white),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                decoration: ShapeDecoration(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: SizedBox(
                        child: textFormat(
                            text: '기여도 뱃지',
                            fontSize: 16,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 15),
              SizedBox(
                  width: double.infinity,
                  child: textFormat(
                      text: '기여도가 올라갈 수록 뱃지가 생겨요. 기여도를 올려 뱃지를 모아보세요 !',
                      fontSize: 12,
                      fontWeight: FontWeight.w500)),
            ],
          ),
        ),
        const SizedBox(height: 24),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: List.generate(contributionPoint.length, (index) {
            return Container(
              width: 80,
              clipBehavior: Clip.antiAlias,
              decoration: ShapeDecoration(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    child: Image.asset(
                        'assets/icons/achievement_screen/contribution_${contributionPoint[index]}.png'),
                  ),
                ],
              ),
            );
          }),
        ),
      ],
    ),
  );
}

Widget badge(String achieve, BuildContext context) {
  return Center(
    child: Column(
      children: [
        Ink(
          width: 87,
          height: 87,
          // clipBehavior: Clip.antiAlias,
          decoration: ShapeDecoration(
            color: Color(0xFFEEF1F4),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
          child: InkWell(
            borderRadius: BorderRadius.circular(30),
            onTap: () {
              _showBadgeDialog(context, achieve);
            },
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        textFormat(text: achieve, fontSize: 16, fontWeight: FontWeight.w500),
      ],
    ),
  );
}

// 각 배지의 속성을 나타냄
void _showBadgeDialog(BuildContext context, String achieve) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        contentPadding: EdgeInsets.zero,
        content: Container(
          width: 350,
          height: 310,
          clipBehavior: Clip.antiAlias,
          decoration: ShapeDecoration(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          child: Center(
            child: Column(
              // mainAxisSize: MainAxisSize.min,
              // mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      onPressed: () {
                        context.pop();
                      },
                      icon: const Icon(Icons.close),
                    ),
                  ],
                ),
                //배지 이미지 입력 자리
                Container(
                  width: 96,
                  height: 96,
                  clipBehavior: Clip.antiAlias,
                  decoration: ShapeDecoration(
                    color: Color(0xFFD6ECFA),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
                const SizedBox(height: 25),
                //배지의 설명 입력 자리
                Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    textFormat(
                        text: achieve,
                        fontSize: 20,
                        fontWeight: FontWeight.w600),
                    const SizedBox(height: 12),
                    textFormat(
                        text: '획득 방법 :\n흡연구역에서 첫 흡연을 하고 인증 버튼을 눌러보세요.',
                        textAlign: TextAlign.center),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}

Widget UserInfo(int contributionScore, double contributionPecentage,
    int? contributionGap, String? profileUrl) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
    decoration: BoxDecoration(color: Colors.white),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          decoration: ShapeDecoration(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: SizedBox(
                  child: Row(
                    children: [
                      textFormat(
                          text: '최하영',
                          fontSize: 16,
                          fontWeight: FontWeight.w700),
                      textFormat(
                          text: ' 님의 기여도',
                          fontSize: 16,
                          fontWeight: FontWeight.w500),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 16),
              textFormat(
                  text: '$contributionScore점',
                  fontSize: 16,
                  fontWeight: FontWeight.w700),
            ],
          ),
        ),
        const SizedBox(height: 24),
        Container(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  textFormat(
                      text: '상위',
                      color: Color(0xFF0099FC),
                      fontSize: 20,
                      fontWeight: FontWeight.w700),
                  textFormat(
                      text: ' $contributionPecentage%',
                      color: Color(0xFF0099FC),
                      fontSize: 24,
                      fontWeight: FontWeight.w700)
                ],
              ),
              const SizedBox(height: 6),
              (contributionGap != null)
                  ? textFormat(
                      text: '1등과 $contributionGap점 차이가 나요. 조금만 더 노력해보세요!',
                      color: Color(0xFF6E767F),
                      fontWeight: FontWeight.w500)
                  : textFormat(
                      text: '사용자 정보를 불러오지 못했습니다.',
                      color: Color(0xFF6E767F),
                      fontWeight: FontWeight.w500),
            ],
          ),
        ),
        const SizedBox(height: 24),
        Container(
          // padding: EdgeInsets.only(
          //     right: (340 * (1 - ((contributionPecentage ?? 0) * 0.01)))),
          // clipBehavior: Clip.antiAlias,

          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 340 * (contributionPecentage * 0.01),
                height: 10,
                decoration: ShapeDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment(1.00, 0.00),
                    end: Alignment(-1, 0),
                    colors: [Color(0xFFBFE5FF), Color(0xFF0099FC)],
                  ),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(3)),
                ),
              ),
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: (profileUrl != null)
                        ? NetworkImage(profileUrl) as ImageProvider
                        : const AssetImage(
                            'assets/icons/achievement_screen/defalut.png'),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Container(
                width: 340 * (1 - (contributionPecentage * 0.01)),
                height: 10,
                decoration: ShapeDecoration(
                  color: Color(0xFFEEF1F4),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(3)),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget explane() {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
    decoration: BoxDecoration(color: Colors.white),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: double.infinity,
          child: Text(
            '기여도 획득 방법',
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontFamily: 'Pretendard',
              fontWeight: FontWeight.w600,
              height: 0,
            ),
          ),
        ),
        const SizedBox(height: 30),
        Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '제보하기',
                    style: TextStyle(
                      color: Color(0xFF0099FC),
                      fontSize: 16,
                      fontFamily: 'Pretendard',
                      fontWeight: FontWeight.w600,
                      height: 0,
                    ),
                  ),
                  const SizedBox(width: 23),
                  Expanded(
                    child: SizedBox(
                      child: Text(
                        '흡연 구역 하나를 제보해 주실 때마다 20의 기여도를 얻을 수 있어요',
                        style: TextStyle(
                          color: Color(0xFF262B32),
                          fontSize: 12,
                          fontFamily: 'Pretendard',
                          fontWeight: FontWeight.w500,
                          height: 0,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Container(
              decoration: const ShapeDecoration(
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                    width: 1,
                    strokeAlign: BorderSide.strokeAlignCenter,
                    color: Color(0xFFF7F8FA),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            const SizedBox(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '리뷰하기',
                    style: TextStyle(
                      color: Color(0xFF0099FC),
                      fontSize: 16,
                      fontFamily: 'Pretendard',
                      fontWeight: FontWeight.w600,
                      height: 0,
                    ),
                  ),
                  SizedBox(width: 23),
                  Expanded(
                    child: SizedBox(
                      child: Text(
                        '흡연 구역 하나를 리뷰해 주실 때마다 5의 기여도를 얻을 수 있어요',
                        style: TextStyle(
                          color: Color(0xFF262B32),
                          fontSize: 12,
                          fontFamily: 'Pretendard',
                          fontWeight: FontWeight.w500,
                          height: 0,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Container(
              decoration: ShapeDecoration(
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                    width: 1,
                    strokeAlign: BorderSide.strokeAlignCenter,
                    color: Color(0xFFF7F8FA),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 56,
                    child: Text(
                      '챌린지   ',
                      style: TextStyle(
                        color: Color(0xFF0099FC),
                        fontSize: 16,
                        fontFamily: 'Pretendard',
                        fontWeight: FontWeight.w600,
                        height: 0,
                      ),
                    ),
                  ),
                  const SizedBox(width: 23),
                  Expanded(
                    child: SizedBox(
                      child: Text(
                        '챌린지에 참여하여 좋아요를 누르고 받을떄마다 기여도를 얻을 수 있어요.\n3등안에 들면 더 높은 기여도를 획득해요 !',
                        style: TextStyle(
                          color: Color(0xFF262B32),
                          fontSize: 12,
                          fontFamily: 'Pretendard',
                          fontWeight: FontWeight.w500,
                          height: 0,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 30),
        Center(
          child: Container(
            padding: const EdgeInsets.only(
              top: 10,
              left: 16,
              right: 16,
              bottom: 10,
            ),
            clipBehavior: Clip.antiAlias,
            decoration: ShapeDecoration(
              color: Color(0xFFF7F8FA),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  '기여도를 획득해서\n총 4개의 뱃지를 얻어 보아요!',
                  style: TextStyle(
                    color: Color(0xFF0099FC),
                    fontSize: 14,
                    fontFamily: 'Pretendard',
                    fontWeight: FontWeight.w700,
                    height: 0,
                  ),
                ),
                const SizedBox(width: 30),
                Container(
                  width: 75,
                  height: 75,
                  padding: const EdgeInsets.all(16),
                  clipBehavior: Clip.antiAlias,
                  decoration: ShapeDecoration(
                    color: Color(0xFFD6ECFA),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child:
                      Image.asset('assets/icons/achievement_screen/lock.png'),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}
