import 'package:flutter/material.dart';
import 'package:damyo/screens/home/statistics/statistics_info/userinfo_statistics.dart';
import 'package:damyo/screens/home/statistics/statistics_info/time_statistics.dart';
import 'package:damyo/screens/home/statistics/statistics_info/calculate_statistics.dart';
import 'package:damyo/screens/home/statistics/statistics_info/periodsingle_statistics.dart';
import 'package:damyo/screens/home/statistics/statistics_info/local_statistics.dart';
import 'package:damyo/screens/home/statistics/statistics_info/periodcompare_statistics.dart';
import 'package:damyo/screens/home/statistics/statistics_info/special_statistics.dart';


class StatistTap extends StatefulWidget {
  const StatistTap({
    super.key,
    required this.index,
    required this.category,
    required this.statInfo,
  });

  final int index;
  final String category;
  final dynamic statInfo;

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
        return localInfo(GuInfo: widget.statInfo);
      case 2:
        // 시간대별 평균 흡연량
        return const timeAverInfo();
      case 3:
        // 기간별 통계 화면(개인 총 흡연량)
        return const periodSingleInfo();
      case 4:
        // 담배값 계산기
        return const calculatePrice();
      case 5:
        // 기간별 평균 흡연량 비교
        return const periodCompareInfo();
      case 6:
        // 특정 기간에 대한 페이지
        return const SpecialDays();
      default:
        return Container();
    }
  }
}
