import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StatistTap extends StatefulWidget {
  const StatistTap({
    super.key,
    required this.index,
    required this.category,
  });

  final int index;
  final String category;

  @override
  State<StatistTap> createState() => _StatistTapState();
}

class _StatistTapState extends State<StatistTap> {
  
  // 페이지 라우트 경로들을 리스트로 관리
  List<String> routePaths = [
    '/local_statistics',
    '/time_statistics',
    '/period_statistics',
    '/week_statistics',
  ];

  @override
  Widget build(BuildContext context) {
    return Ink(
      child:InkWell(
        onTap: () {
          context.push(
            routePaths[widget.index],
            extra: widget.category,
          );
        },
        child: Text(
          widget.category,
          textAlign: TextAlign.center,
        ),
        borderRadius: BorderRadius.circular(15),
      ),
      width: 390,
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
    );
  }
}