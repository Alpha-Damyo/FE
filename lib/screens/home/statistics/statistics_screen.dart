import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
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
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Container(
              width: 390,
              height: 350,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 30),
              decoration: BoxDecoration(color: Color(0xFF636363)),
              child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                      Text(
                          '기간별 흡연량',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontFamily: 'AppleSDGothicNeoB00',
                              fontWeight: FontWeight.w400,
                              height: 0,
                          ),
                      ),
                      const SizedBox(height: 16),
                      Container(
                          width: 358,
                          height: 204,
                          clipBehavior: Clip.antiAlias,
                          decoration: ShapeDecoration(
                              color: Color(0xFFDEDEDE),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                              ),
                          ),
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                          width: 358,
                          child: Text(
                              '어쩌구 저쩌구 해설 짧은 글  어쩌구 저쩌구 해설 짧은 글   어쩌구 저쩌구 해설 짧은 글    어쩌구 저쩌구 해설 짧은 글   어쩌구 저쩌구 해설 짧은 글 ',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontFamily: 'AppleSDGothicNeoM00',
                                  fontWeight: FontWeight.w400,
                                  height: 0,
                              ),
                          ),
                      ),
                  ],
              ),
            ),
            Container(
              width: 390,
              height: 350,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 30),
              decoration: BoxDecoration(color: Color(0xFF383838)),
              child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                      Text(
                          '위치별 흡연량',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontFamily: 'AppleSDGothicNeoB00',
                              fontWeight: FontWeight.w400,
                              height: 0,
                          ),
                      ),
                      const SizedBox(height: 16),
                      Container(
                          width: 358,
                          height: 204,
                          clipBehavior: Clip.antiAlias,
                          decoration: ShapeDecoration(
                              color: Color(0xFFDEDEDE),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                              ),
                          ),
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                          width: 358,
                          child: Text(
                              '어쩌구 저쩌구 해설 짧은 글  어쩌구 저쩌구 해설 짧은 글   어쩌구 저쩌구 해설 짧은 글    어쩌구 저쩌구 해설 짧은 글   어쩌구 저쩌구 해설 짧은 글 ',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontFamily: 'AppleSDGothicNeoM00',
                                  fontWeight: FontWeight.w400,
                                  height: 0,
                              ),
                          ),
                      ),
                  ],
              ),
            ),
            Container(
              width: 390,
              height: 350,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 30),
              decoration: BoxDecoration(color: Color(0xFF636363)),
              child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                      Text(
                          '시간대별 흡연량',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontFamily: 'AppleSDGothicNeoB00',
                              fontWeight: FontWeight.w400,
                              height: 0,
                          ),
                      ),
                      const SizedBox(height: 16),
                      Container(
                          width: 358,
                          height: 204,
                          clipBehavior: Clip.antiAlias,
                          decoration: ShapeDecoration(
                              color: Color(0xFFDEDEDE),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                              ),
                          ),
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                          width: 358,
                          child: Text(
                              '어쩌구 저쩌구 해설 짧은 글  어쩌구 저쩌구 해설 짧은 글   어쩌구 저쩌구 해설 짧은 글    어쩌구 저쩌구 해설 짧은 글   어쩌구 저쩌구 해설 짧은 글 ',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontFamily: 'AppleSDGothicNeoM00',
                                  fontWeight: FontWeight.w400,
                                  height: 0,
                              ),
                          ),
                      ),
                  ],
              ),
            ),
          ],
        ),
      ),
  );
    
  }
}
