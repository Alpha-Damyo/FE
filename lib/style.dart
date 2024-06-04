import 'package:flutter/material.dart';

Text textFormat(
    {required String text,
    double fontsize = 14,
    Color? color = Colors.black,
    FontWeight fontWeight = FontWeight.normal,
    TextOverflow? textoverflow}) {
  return Text(
    text,
    style: TextStyle(
      fontSize: fontsize,
      fontFamily: 'Pretendard',
      fontWeight: fontWeight,
      color: color,
    ),
    textScaler: TextScaler.noScaling,
    overflow: textoverflow,
  );
}
