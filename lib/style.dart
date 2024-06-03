import 'package:flutter/material.dart';

Text textFormat(String text, double fontsize, var color, FontWeight fontWeight){
  return Text(
    text,
    style: TextStyle(
      fontSize: fontsize,
      fontFamily: 'Pretendard',
      fontWeight: fontWeight,
      color: color,
    ),
  );
}