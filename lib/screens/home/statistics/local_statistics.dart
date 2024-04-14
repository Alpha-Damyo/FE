import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';



class LocalStaisticsScreen extends StatefulWidget {
  const LocalStaisticsScreen({super.key});

  @override
  State<LocalStaisticsScreen> createState() => _LocalStaisticsState();
}

class _LocalStaisticsState extends State<LocalStaisticsScreen> {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 1863),
      builder: (context, child) => Scaffold(
        appBar: AppBar(
          scrolledUnderElevation: 0,
          backgroundColor: Colors.white,
          title: Text(
            '지역별 흡연 통계',
          ),
          centerTitle: true,
        ),
        body: Center(
          child: Text('LOCAL'),
        ),
      )
    );
  }
}