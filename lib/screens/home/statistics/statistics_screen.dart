import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class StatisticsScreen extends StatelessWidget {
  const StatisticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Center(
     child: Container(
    // width: 390,
    // height: 2279,
    clipBehavior: Clip.antiAlias,
    decoration: BoxDecoration(color: Colors.white),
    child: SingleChildScrollView(
        child: ScreenUtilInit(
            child: Row(
              children: [
                Container(

              ),
            ],
          ),
        ),
    ),
)
    );
    
  }
}
