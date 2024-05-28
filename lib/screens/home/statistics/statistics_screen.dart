import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:damyo/screens/home/statistics/statistics_screen_utill.dart';
import 'package:damyo/services/get_date_statics_service.dart';

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
                ElevatedButton(
                    onPressed: () async {
                      await getDateStatics();
                    },
                    child: Text('test')),
                SizedBox(
                  height: 20.h,
                ),
                // 사용자의 정보
                const SizedBox(
                  child: StatistTap(
                    index: 0,
                    category: '사용자 정보',
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                // 지역별 흡연 데이터 통계
                SizedBox(
                  height: 600.h,
                  child: const StatistTap(
                    index: 1,
                    category: '시군구별 흡연 통계',
                  ),
                ),
                Container(
                  height: 20.h,
                  color: Colors.grey[200],
                ),
                const SizedBox(
                  child: StatistTap(
                    index: 6,
                    category: '특정 기간',
                  ),
                ),
                Container(
                  height: 20.h,
                  color: Colors.grey[200],
                ),
                // 시간대별 흡연 데이터 통계(사용자, 전체)
                SizedBox(
                  height: 1000.h,
                  child: const StatistTap(
                    index: 2,
                    category: '시간대별 평균 흡연량',
                  ),
                ),
                Container(
                  height: 20.h,
                  color: Colors.grey[200],
                ),
                // 기간별 흡연 데이터 통계(사용자)
                SizedBox(
                  height: 1000.h,
                  child: const StatistTap(
                    index: 3,
                    category: '기간별 평균 흡연량(개인)',
                  ),
                ),
                Container(
                  height: 20.h,
                  color: Colors.grey[200],
                ),
                // 담배값 계산기
                SizedBox(
                  height: 500.h,
                  child: PageView(
                    scrollDirection: Axis.horizontal,
                    children: const [
                      StatistTap(
                        index: 4,
                        category: '담배값 계산기',
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 20.h,
                  color: Colors.grey[200],
                ),
                // 평균 흡연량 비교 데이터 통계
                SizedBox(
                  height: 1000.h,
                  child: const StatistTap(
                    index: 5,
                    category: '평균 흡연량 비교 통계',
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
