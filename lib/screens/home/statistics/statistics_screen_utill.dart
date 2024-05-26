import 'package:flutter/material.dart';
import 'package:damyo/screens/home/statistics/userinfo_statistics.dart';
import 'package:damyo/screens/home/statistics/time_statistics.dart';
import 'package:damyo/screens/home/statistics/calculate_statistics.dart';
import 'package:damyo/screens/home/statistics/periodsingle_statistics.dart';
import 'package:damyo/screens/home/statistics/local_statistics.dart';
import 'package:damyo/screens/home/statistics/periodcompare_statistics.dart';

class StatistTap extends StatefulWidget {
  const StatistTap({
    super.key,
    required this.index,
    required this.category,
  });

  final int index;
  final String category;

  @override
  State<StatistTap> createState() => _StatistTapState();
}

class _StatistTapState extends State<StatistTap> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //인덱스 별 통계 페이지 생성
    switch (widget.index) {
      case 0:
        // 유저 정보 화면
        return const userInfo();
      case 1:
        // 지역별 통계 화면
        return const localInfo();
      case 2:
        // 시간대별 평균 흡연량
        return const timeAverInfo();
      case 3:
        // 기간별 통계 화면(개인 총 흡연량)
        return const periodSumInfo();
      case 4:
        // 담배값 계산기
        return const calculatePrice();
      case 5:
        // 기간별 평균 흡연량 비교
        return const periodCompareInfo();
      default:
        return Container();
    }
  }
}
