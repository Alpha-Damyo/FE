import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';



class TimeStaisticsScreen extends StatefulWidget {
  const TimeStaisticsScreen({super.key});

  @override
  State<TimeStaisticsScreen> createState() => _TimeStaisticsState();
}

class _TimeStaisticsState extends State<TimeStaisticsScreen> {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 1863),
      builder: (context, child) => Scaffold(
        appBar: AppBar(
          scrolledUnderElevation: 0,
          backgroundColor: Colors.white,
          title: Text(
            '시간별 흡연 통계',
          ),
          centerTitle: true,
        ),
        body: Center(
          child: Text('Time'),
        ),
      )
    );
  }
}