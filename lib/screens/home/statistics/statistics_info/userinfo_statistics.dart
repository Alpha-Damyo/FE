import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

// 날짜 정보를 가져오기 위해
DateTime now = DateTime.now();

class userInfo extends StatefulWidget {
  const userInfo({super.key});

  final String userName = '최하영';
  @override
  State<userInfo> createState() => _userInfoState();
}

class _userInfoState extends State<userInfo>
    with SingleTickerProviderStateMixin {
  late ScrollController _controller;
  late AnimationController _animationController;

  @override
  void initState() {
    _controller = ScrollController();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 5), // 애니메이션 지속 시간 설정
    )..repeat();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  // 사용자 정보 위젯
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        top: 25,
        left: 16,
        right: 16,
        bottom: 20,
      ),
      //그라데이션
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment(0.00, -1.00),
          end: Alignment(0, 1),
          colors: [Color(0xFFD6ECFA), Colors.white],
        ),
      ),
      child: Column(
        // mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: SizedBox(
                  child: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: widget.userName,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontFamily: 'Pretendard',
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const TextSpan(
                          text: ' ',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontFamily: 'Pretendard',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const TextSpan(
                          text: '님을\n분석해봤어요',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontFamily: 'Pretendard',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 30),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                child: Text(
                  '가장 많이 방문한 곳 ',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontFamily: 'Pretendard',
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Container(
                width: 390,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    _mostSmokingArea(1, '국민대 도서관', 23129),
                    _mostSmokingArea(2, '정릉역 2번출구', 13023),
                    _mostSmokingArea(3, '국민대 공학관', 10322),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // 많이 방문한 흡연구역
  Widget _mostSmokingArea(int rank, String place, int cnt) {
    return Center(
      child: InkWell(
        onTap: () {
          print(place);
          print(now.weekday);
          context.push('/sa_info', extra: '1');
        },
        child: Container(
          width: 120,
          height: 120,
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(width: 1, color: const Color(0xFFEEF1F4)),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '$rank등',
                style: const TextStyle(
                  color: Color(0xFF0099FC),
                  fontSize: 12,
                  fontFamily: 'Pretendard',
                  fontWeight: FontWeight.w500,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    place,
                    style: const TextStyle(
                      color: Color(0xFF10151B),
                      fontSize: 14,
                      fontFamily: 'Pretendard',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '$cnt 회',
                    style: const TextStyle(
                      color: Color(0xFF6E767F),
                      fontSize: 10,
                      fontFamily: 'Pretendard',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      _buildTag('실외'),
                      const SizedBox(
                        width: 10,
                      ),
                      _buildTag('개방형'),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTag(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: const Color(0xFFD6ECFA),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Color(0xFF0E6AA6),
          fontSize: 10,
          fontFamily: 'Pretendard',
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
