import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';



class PeriodStaisticsScreen extends StatefulWidget {
  const PeriodStaisticsScreen({
    super.key,
    required this.subcategory,
  });

  final String subcategory;

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
            widget.subcategory,
          ),
          centerTitle: true,
        ),
        body: Center(
          child: Text(
            widget.subcategory,
          ),
        ),
      )
    );
  }
}