import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class WeekStaisticsScreen extends StatefulWidget {
  const WeekStaisticsScreen({
    super.key,
    required this.subcategory,
  });

  final String subcategory;

  @override
  State<WeekStaisticsScreen> createState() => _WeekStaisticsState();
}

class _WeekStaisticsState extends State<WeekStaisticsScreen> {
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