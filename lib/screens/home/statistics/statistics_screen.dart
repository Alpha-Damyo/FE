import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:damyo/screens/home/statistics/statistics_screen_utill.dart';
import 'package:damyo/services/statics_service.dart';
import 'package:damyo/models/statistics/stat_date_model.dart';
import 'package:damyo/models/statistics/stat_region_model.dart';
import 'package:damyo/database/smoke_database_helper.dart';

class StatisticsScreen extends StatefulWidget {
  const StatisticsScreen({super.key});

  @override
  State<StatisticsScreen> createState() => _StatisticsScreenState();
}

class _StatisticsScreenState extends State<StatisticsScreen> {
  statDateModel? statDateInfo;
  statRegionModel? statRegionInfo;

  SmokeDatabaseHelper userDB = SmokeDatabaseHelper();
  List<Map<String, dynamic>> userSmokeList = [];

  Future<void> getStatics() async {
    try {
      var _statDateInfo = await getDateStatics();
      var _statRegionInfo = await getRegionStatics();
      setState(() {
        statDateInfo = _statDateInfo;
        statRegionInfo = _statRegionInfo;
      });
    } catch (e) {
      statDateInfo = null;
      statRegionInfo = null;
    }
  }

  @override
  void initState() {
    super.initState();
    getStatics();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 1863),
      builder: (context, child) => Scaffold(
        appBar: AppBar(
          scrolledUnderElevation: 0,
          backgroundColor: Colors.white,
          title: const Text(
            '통계',
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
                // 사용자의 정보
                StatistTap(
                  index: 0,
                  category: '사용자 정보',
                  statInfo: userDB,
                ),
                SizedBox(
                  height: 20.h,
                ),
                // 지역별 흡연 데이터 통계
                statRegionInfo == null
                    ? const CircularProgressIndicator()
                    : SizedBox(
                        height: 250,
                        child: StatistTap(
                            index: 1,
                            category: '시군구별 흡연 통계',
                            statInfo: statRegionInfo),
                      ),
                Container(
                  height: 10,
                  color: Colors.grey[200],
                ),
                statDateInfo == null
                    ? const CircularProgressIndicator()
                    : Container(
                        child: StatistTap(
                          index: 6,
                          category: '특정 기간',
                          statInfo: statDateInfo,
                        ),
                      ),
                Container(
                  height: 10,
                  color: Colors.grey[200],
                ),
                // 시간대별 흡연 데이터 통계(사용자, 전체)
                statDateInfo == null
                    ? const CircularProgressIndicator() // 로딩 중에는 로딩 인디케이터를 표시
                    : SizedBox(
                        height: 1000.h,
                        child: StatistTap(
                          index: 2,
                          category: '시간대별 평균 흡연량',
                          statInfo: [userDB, statDateInfo?.time],
                        ),
                      ),
                Container(
                  height: 10,
                  color: Colors.grey[200],
                ),
                // 기간별 흡연 데이터 통계(사용자)
                SizedBox(
                  height: 1000.h,
                  child: StatistTap(
                    index: 3,
                    category: '기간별 평균 흡연량(개인)',
                    statInfo: userDB,
                  ),
                ),
                Container(
                  height: 10,
                  color: Colors.grey[200],
                ),
                // 담배값 계산기
                statDateInfo == null
                    ? const CircularProgressIndicator() // 로딩 중에는 로딩 인디케이터를 표시
                    : SizedBox(
                        height: 500.h,
                        child: StatistTap(
                          index: 4,
                          category: '담배값 계산기',
                          statInfo: userDB,
                        ),
                      ),
                Container(
                  height: 10,
                  color: Colors.grey[200],
                ),
                // 평균 흡연량 비교 데이터 통계
                statDateInfo == null
                    ? const CircularProgressIndicator() // 로딩 중에는 로딩 인디케이터를 표시
                    : SizedBox(
                        height: 1000.h,
                        child: StatistTap(
                          index: 5,
                          category: '평균 흡연량 비교 통계',
                          statInfo: [userDB, statDateInfo],
                        ),
                      ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
