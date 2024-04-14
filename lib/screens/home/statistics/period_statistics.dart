import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';



class PeriodStaisticsScreen extends StatefulWidget {
  const PeriodStaisticsScreen({super.key});

  @override
  State<PeriodStaisticsScreen> createState() => _PeriodStaisticsState();
}

class _PeriodStaisticsState extends State<PeriodStaisticsScreen> {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 1863),
      builder: (context, child) => Scaffold(
        appBar: AppBar(
          scrolledUnderElevation: 0,
          backgroundColor: Colors.white,
          title: Text(
            '기간별 흡연 통계',
          ),
          centerTitle: true,
        ),
        body: Center(
          child: Text('Period'),
        ),
      )
    );
  }
}