import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:damyo/screens/home/statistics/statistics_screen_utill.dart';

class StatisticsScreen extends StatefulWidget {
  const StatisticsScreen({super.key});

  @override
  State<StatisticsScreen> createState() => _StatisticsScreenState();
}

class _StatisticsScreenState extends State<StatisticsScreen> {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 1863),
      builder: (context, child) => Scaffold(
        appBar: AppBar(
          scrolledUnderElevation: 0,
          backgroundColor: Colors.white,
          title: const Text(
            '제보',
          ),
          centerTitle: true,
        ),
        body: Center(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                SizedBox(
                  height: 20.h,
                ),
                // 지역별 흡연 데이터 통계
                SizedBox(
                  width: 390,
                  height: 469,
                  child: PageView(
                    scrollDirection: Axis.horizontal,
                    children: const [
                      StatistTap(
                        index: 0,
                        category: '시군구별 흡연 통계',
                      ),
                      StatistTap(
                        index: 0,
                        category: '가장 많이 흡연한 구역(개인)',
                      ),
                      StatistTap(
                        index: 0,
                        category: '가장 많이 흡연한 구역(전체)',
                      ),
                      StatistTap(
                        index: 0,
                        category: '지역별 흡연 목록',
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 390.w,
                  height: 20.h,
                ),
                // 시간대별 흡연 데이터 통계
                SizedBox(
                  width: 390,
                  height: 469,
                  child: PageView(
                    scrollDirection: Axis.horizontal,
                    children: const [
                      StatistTap(
                        index: 1,
                        category: '시간대별 평균 흡연량(개인)',
                      ),
                      StatistTap(
                        index: 1,
                        category: '시간대별 평균 흡연량(전체)',
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 390.w,
                  height: 20.h,
                ),
                // 기간별 흡연 데이터 통계
                SizedBox(
                  width: 390,
                  height: 469,
                  child: PageView(
                    scrollDirection: Axis.horizontal,
                    children: const [
                      StatistTap(
                        index: 2,
                        category: '기간별 평균 흡연량(개인)',
                      ),
                      StatistTap(
                        index: 2,
                        category: '기간별 평균 흡연량(전체)',
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 390.w,
                  height: 20.h,
                ),
                // 요일별 흡연 데이터 통계
                SizedBox(
                  width: 390,
                  height: 469,
                  child: PageView(
                    scrollDirection: Axis.horizontal,
                    children: const [
                      StatistTap(
                        index: 3,
                        category: '요일별 평균 흡연량(개인)',
                      ),
                      StatistTap(
                        index: 3,
                        category: '요일별 평균 흡연량(전체)',
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 390.w,
                  height: 20.h,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
