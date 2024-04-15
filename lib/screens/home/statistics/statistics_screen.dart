import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StatisticsScreen extends StatefulWidget {
  const StatisticsScreen({super.key});

  @override
  State<StatisticsScreen> createState() => _StatisticsScreenState();
}


class _StatisticsScreenState extends State<StatisticsScreen> {
  @override
  Widget build(BuildContext context) {

    return  ScreenUtilInit(
      designSize: const Size(390, 1863),
      builder: (context, child) => Scaffold(
        appBar: AppBar(
          scrolledUnderElevation: 0,
          backgroundColor: Colors.white,
          title: Text(
            '제보',
          ),
          centerTitle: true,
        ),
        body: Center(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                // 지역별 흡연 데이터 통계 
                // Ink 없애려면 Ink - Container로 Inkwell - GestureDetector로
                Ink(
                  child: InkWell(
                    child: Text(
                      '지역별 흡연 데이터',
                      textAlign: TextAlign.center,
                    ),
                    onTap: () {
                      // 지역별 통계 상세 페이지로 이동
                      print('지역별 흡연 데이터');
                    },
                  ),
                  width: 358,
                  height: 469,
                  // clipBehavior: Clip.antiAlias,
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 2,
                        strokeAlign: BorderSide.strokeAlignOutside,
                        color: Color(0xFFEEF1F4),
                      ),
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
                SizedBox(
                  width: 390,
                  height: 20,
                ),
                // 시간대별 흡연 데이터 통계
                Ink(
                  child: InkWell(
                    child: Text(
                      '시간대별 흡연 데이터',
                      textAlign: TextAlign.center,
                    ),
                    onTap: () {
                      // 시간대별 통계 상세 페이지로 이동

                      print('시간대별 흡연 데이터');
                    },
                  ),
                  width: 358,
                  height: 469,
                  // clipBehavior: Clip.antiAlias,
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 2,
                        strokeAlign: BorderSide.strokeAlignOutside,
                        color: Color(0xFFEEF1F4),
                      ),
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
                SizedBox(
                  width: 390,
                  height: 20,
                ),
                // 기간별 흡연 데이터 통계
                Ink(
                  child: InkWell(
                    child: Text(
                      '기간별 흡연 데이터',
                      textAlign: TextAlign.center,
                    ),
                    onTap: () {
                      // 기간별 통계 상세 페이지로 이동
                      print('기간별 흡연 데이터');
                    },
                    borderRadius: BorderRadius.circular(15),
                  ),
                  width: 358,
                  height: 469,
                  // clipBehavior: Clip.antiAlias,
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 2,
                        strokeAlign: BorderSide.strokeAlignOutside,
                        color: Color(0xFFEEF1F4),
                      ),
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
                SizedBox(
                  width: 390,
                  height: 20,
                ),
                Ink(
                  child:InkWell(
                    onTap: () {
                      
                    },
                    child: Text(
                      'Test',
                      textAlign: TextAlign.center,
                    ),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  width: 358,
                  height: 469,
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 2,
                        strokeAlign: BorderSide.strokeAlignOutside,
                        color: Color(0xFFEEF1F4),
                      ),
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      
  );
    
  }
}
