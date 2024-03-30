import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

//test

class StatisticsScreen extends StatelessWidget {
  const StatisticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Center(
     child: Container(
    width: 390,
    height: 2279,
    clipBehavior: Clip.antiAlias,
    decoration: BoxDecoration(color: Colors.white),
    child: Stack(
        children: [
            Positioned(
                left: 0,
                top: 89,
                child: Container(
                    width: 390,
                    height: 292,
                    padding: const EdgeInsets.only(
                        top: 24,
                        left: 309,
                        right: 18,
                        bottom: 205,
                    ),
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(color: Color(0xFFD6ECFA)),
                    child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                            Container(
                                width: 63,
                                padding: const EdgeInsets.only(
                                    top: 22,
                                    left: 20,
                                    right: 18,
                                    bottom: 22,
                                ),
                                clipBehavior: Clip.antiAlias,
                                decoration: ShapeDecoration(
                                    color: Color(0xFF0099FC),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(38),
                                    ),
                                ),
                                child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                        Text(
                                            '4월',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 16,
                                                fontFamily: 'Pretendard',
                                                fontWeight: FontWeight.w700,
                                                height: 0,
                                            ),
                                        ),
                                    ],
                                ),
                            ),
                        ],
                    ),
                ),
            ),
            Positioned(
                left: 0,
                top: 2222,
                child: Container(
                    width: 390,
                    height: 57,
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border(
                            left: BorderSide(color: Color(0xFFDEDEDE)),
                            top: BorderSide(width: 1, color: Color(0xFFDEDEDE)),
                            right: BorderSide(color: Color(0xFFDEDEDE)),
                            bottom: BorderSide(color: Color(0xFFDEDEDE)),
                        ),
                    ),
                    child: Stack(
                        children: [
                            Positioned(
                                left: 35,
                                top: 37,
                                child: Text(
                                    '맵',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 10,
                                        fontFamily: 'Abel',
                                        fontWeight: FontWeight.w400,
                                        height: 0,
                                    ),
                                ),
                            ),
                            Positioned(
                                left: 186,
                                top: 37,
                                child: Text(
                                    '제보',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 10,
                                        fontFamily: 'Abel',
                                        fontWeight: FontWeight.w400,
                                        height: 0,
                                    ),
                                ),
                            ),
                            Positioned(
                                left: 107,
                                top: 37,
                                child: Text(
                                    '통계',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 10,
                                        fontFamily: 'Abel',
                                        fontWeight: FontWeight.w400,
                                        height: 0,
                                    ),
                                ),
                            ),
                            Positioned(
                                left: 27,
                                top: 11,
                                child: Container(
                                    child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                            Container(
                                                width: 23,
                                                height: 23,
                                                decoration: ShapeDecoration(
                                                    color: Color(0xFFD9D9D9),
                                                    shape: OvalBorder(),
                                                ),
                                            ),
                                            const SizedBox(width: 55),
                                            Container(
                                                width: 23,
                                                height: 23,
                                                decoration: ShapeDecoration(
                                                    color: Color(0xFFD9D9D9),
                                                    shape: OvalBorder(),
                                                ),
                                            ),
                                            const SizedBox(width: 55),
                                            Container(
                                                width: 23,
                                                height: 23,
                                                decoration: ShapeDecoration(
                                                    color: Color(0xFFD9D9D9),
                                                    shape: OvalBorder(),
                                                ),
                                            ),
                                            const SizedBox(width: 55),
                                            Container(
                                                width: 23,
                                                height: 23,
                                                decoration: ShapeDecoration(
                                                    color: Color(0xFFD9D9D9),
                                                    shape: OvalBorder(),
                                                ),
                                            ),
                                            const SizedBox(width: 55),
                                            Container(
                                                width: 23,
                                                height: 23,
                                                decoration: ShapeDecoration(
                                                    color: Color(0xFFD9D9D9),
                                                    shape: OvalBorder(),
                                                ),
                                            ),
                                        ],
                                    ),
                                ),
                            ),
                            Positioned(
                                left: 258,
                                top: 37,
                                child: Text(
                                    '챌린지',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 10,
                                        fontFamily: 'Abel',
                                        fontWeight: FontWeight.w400,
                                        height: 0,
                                    ),
                                ),
                            ),
                            Positioned(
                                left: 341,
                                top: 37,
                                child: Text(
                                    '마이',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 10,
                                        fontFamily: 'Abel',
                                        fontWeight: FontWeight.w400,
                                        height: 0,
                                    ),
                                ),
                            ),
                        ],
                    ),
                ),
            ),
            Positioned(
                left: 27,
                top: 113,
                child: Text.rich(
                    TextSpan(
                        children: [
                            TextSpan(
                                text: '최하영',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 24,
                                    fontFamily: 'Pretendard',
                                    fontWeight: FontWeight.w800,
                                    height: 0,
                                ),
                            ),
                            TextSpan(
                                text: ' ',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 24,
                                    fontFamily: 'Pretendard',
                                    fontWeight: FontWeight.w400,
                                    height: 0,
                                ),
                            ),
                            TextSpan(
                                text: '님의 \n담요 Report 입니다. ',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 24,
                                    fontFamily: 'Pretendard',
                                    fontWeight: FontWeight.w500,
                                    height: 0,
                                ),
                            ),
                        ],
                    ),
                ),
            ),
            Positioned(
                left: 27,
                top: 210,
                child: Text(
                    '하루 평군 흡연량',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontFamily: 'Pretendard',
                        fontWeight: FontWeight.w600,
                        height: 0,
                    ),
                ),
            ),
            Positioned(
                left: 27,
                top: 242,
                child: Text(
                    '10개 ',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontFamily: 'Pretendard',
                        fontWeight: FontWeight.w700,
                        height: 0,
                    ),
                ),
            ),
            Positioned(
                left: 199,
                top: 210,
                child: Container(
                    width: 175,
                    height: 131,
                    clipBehavior: Clip.antiAlias,
                    decoration: ShapeDecoration(
                        color: Color(0xFFDEDEDE),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                        ),
                    ),
                ),
            ),
            Positioned(
                left: 0,
                top: 500,
                child: Container(
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
            ),
            Positioned(
                left: 0,
                top: 850,
                child: Container(
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
            ),
            Positioned(
                left: 0,
                top: 1200,
                child: Container(
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
            ),
            Positioned(
                left: 4,
                top: 1550,
                child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 30),
                    decoration: BoxDecoration(color: Colors.white),
                    child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                            Text(
                                '내가 제보한 흡연구역',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontFamily: 'AppleSDGothicNeoB00',
                                    fontWeight: FontWeight.w400,
                                    height: 0,
                                ),
                            ),
                            const SizedBox(height: 16),
                            Container(
                                child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                        Container(
                                            child: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                    Container(
                                                        child: Column(
                                                            mainAxisSize: MainAxisSize.min,
                                                            mainAxisAlignment: MainAxisAlignment.start,
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: [
                                                                Container(
                                                                    width: 175,
                                                                    height: 140,
                                                                    clipBehavior: Clip.antiAlias,
                                                                    decoration: ShapeDecoration(
                                                                        color: Color(0xFFDEDEDE),
                                                                        shape: RoundedRectangleBorder(
                                                                            borderRadius: BorderRadius.circular(15),
                                                                        ),
                                                                    ),
                                                                ),
                                                                const SizedBox(height: 8),
                                                                SizedBox(
                                                                    width: 175,
                                                                    child: Text(
                                                                        '국민대 도서관',
                                                                        style: TextStyle(
                                                                            color: Colors.black,
                                                                            fontSize: 14,
                                                                            fontFamily: 'AppleSDGothicNeoB00',
                                                                            fontWeight: FontWeight.w400,
                                                                            height: 0,
                                                                        ),
                                                                    ),
                                                                ),
                                                                const SizedBox(height: 8),
                                                                SizedBox(
                                                                    width: 175,
                                                                    child: Text(
                                                                        '어쩌구 저쩌구 해설 짧은 글  어쩌구 저쩌구 해설 짧은 글   어쩌구 저쩌구 해설 짧은 글    어쩌구 저쩌구 해설 짧은 글   어쩌구 저쩌구 해설 짧은 글 ',
                                                                        style: TextStyle(
                                                                            color: Colors.black,
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
                                                    const SizedBox(width: 8),
                                                    Container(
                                                        child: Column(
                                                            mainAxisSize: MainAxisSize.min,
                                                            mainAxisAlignment: MainAxisAlignment.start,
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: [
                                                                Container(
                                                                    width: 175,
                                                                    height: 140,
                                                                    clipBehavior: Clip.antiAlias,
                                                                    decoration: ShapeDecoration(
                                                                        color: Color(0xFFDEDEDE),
                                                                        shape: RoundedRectangleBorder(
                                                                            borderRadius: BorderRadius.circular(15),
                                                                        ),
                                                                    ),
                                                                ),
                                                                const SizedBox(height: 8),
                                                                SizedBox(
                                                                    width: 175,
                                                                    child: Text(
                                                                        '국민대 도서관',
                                                                        style: TextStyle(
                                                                            color: Colors.black,
                                                                            fontSize: 14,
                                                                            fontFamily: 'AppleSDGothicNeoB00',
                                                                            fontWeight: FontWeight.w400,
                                                                            height: 0,
                                                                        ),
                                                                    ),
                                                                ),
                                                                const SizedBox(height: 8),
                                                                SizedBox(
                                                                    width: 175,
                                                                    child: Text(
                                                                        '어쩌구 저쩌구 해설 짧은 글  어쩌구 저쩌구 해설 짧은 글   어쩌구 저쩌구 해설 짧은 글    어쩌구 저쩌구 해설 짧은 글   어쩌구 저쩌구 해설 짧은 글 ',
                                                                        style: TextStyle(
                                                                            color: Colors.black,
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
                                        const SizedBox(height: 16),
                                        Container(
                                            child: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                    Container(
                                                        child: Column(
                                                            mainAxisSize: MainAxisSize.min,
                                                            mainAxisAlignment: MainAxisAlignment.start,
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: [
                                                                Container(
                                                                    width: 175,
                                                                    height: 140,
                                                                    clipBehavior: Clip.antiAlias,
                                                                    decoration: ShapeDecoration(
                                                                        color: Color(0xFFDEDEDE),
                                                                        shape: RoundedRectangleBorder(
                                                                            borderRadius: BorderRadius.circular(15),
                                                                        ),
                                                                    ),
                                                                ),
                                                                const SizedBox(height: 8),
                                                                SizedBox(
                                                                    width: 175,
                                                                    child: Text(
                                                                        '국민대 도서관',
                                                                        style: TextStyle(
                                                                            color: Colors.black,
                                                                            fontSize: 14,
                                                                            fontFamily: 'AppleSDGothicNeoB00',
                                                                            fontWeight: FontWeight.w400,
                                                                            height: 0,
                                                                        ),
                                                                    ),
                                                                ),
                                                                const SizedBox(height: 8),
                                                                SizedBox(
                                                                    width: 175,
                                                                    child: Text(
                                                                        '어쩌구 저쩌구 해설 짧은 글  어쩌구 저쩌구 해설 짧은 글   어쩌구 저쩌구 해설 짧은 글    어쩌구 저쩌구 해설 짧은 글   어쩌구 저쩌구 해설 짧은 글 ',
                                                                        style: TextStyle(
                                                                            color: Colors.black,
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
                                                    const SizedBox(width: 8),
                                                    Container(
                                                        child: Column(
                                                            mainAxisSize: MainAxisSize.min,
                                                            mainAxisAlignment: MainAxisAlignment.start,
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: [
                                                                Container(
                                                                    width: 175,
                                                                    height: 140,
                                                                    clipBehavior: Clip.antiAlias,
                                                                    decoration: ShapeDecoration(
                                                                        color: Color(0xFFDEDEDE),
                                                                        shape: RoundedRectangleBorder(
                                                                            borderRadius: BorderRadius.circular(15),
                                                                        ),
                                                                    ),
                                                                ),
                                                                const SizedBox(height: 8),
                                                                SizedBox(
                                                                    width: 175,
                                                                    child: Text(
                                                                        '국민대 도서관',
                                                                        style: TextStyle(
                                                                            color: Colors.black,
                                                                            fontSize: 14,
                                                                            fontFamily: 'AppleSDGothicNeoB00',
                                                                            fontWeight: FontWeight.w400,
                                                                            height: 0,
                                                                        ),
                                                                    ),
                                                                ),
                                                                const SizedBox(height: 8),
                                                                SizedBox(
                                                                    width: 175,
                                                                    child: Text(
                                                                        '어쩌구 저쩌구 해설 짧은 글  어쩌구 저쩌구 해설 짧은 글   어쩌구 저쩌구 해설 짧은 글    어쩌구 저쩌구 해설 짧은 글   어쩌구 저쩌구 해설 짧은 글 ',
                                                                        style: TextStyle(
                                                                            color: Colors.black,
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
                                    ],
                                ),
                            ),
                        ],
                    ),
                ),
            ),
            Positioned(
                left: 0,
                top: 0,
                child: Container(
                    padding: const EdgeInsets.only(left: 2, right: 3, bottom: 42),
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border(
                            left: BorderSide(color: Color(0xFFEEF1F4)),
                            top: BorderSide(color: Color(0xFFEEF1F4)),
                            right: BorderSide(color: Color(0xFFEEF1F4)),
                            bottom: BorderSide(width: 1, color: Color(0xFFEEF1F4)),
                        ),
                    ),
                    child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                            Container(
                                height: double.infinity,
                                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 13),
                                child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                        Text(
                                            '9:41',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 15,
                                                fontFamily: 'AppleSDGothicNeoB00',
                                                fontWeight: FontWeight.w400,
                                                height: 0,
                                                letterSpacing: -0.17,
                                            ),
                                        ),
                                        const SizedBox(width: 250),
                                        Container(
                                            width: 68,
                                            height: 13,
                                            clipBehavior: Clip.antiAlias,
                                            decoration: BoxDecoration(),
                                            child: Stack(
                                                children: [
                                                    Positioned(
                                                        left: 42.50,
                                                        top: 0.56,
                                                        child: Container(
                                                            width: 24.50,
                                                            height: 11.50,
                                                            child: Stack(
                                                                children: [
                                                                    Positioned(
                                                                        left: 0,
                                                                        top: 0,
                                                                        child: Container(
                                                                            width: 24.50,
                                                                            height: 11.50,
                                                                            decoration: BoxDecoration(
                                                                                image: DecorationImage(
                                                                                    image: NetworkImage("https://via.placeholder.com/24x11"),
                                                                                    fit: BoxFit.fill,
                                                                                ),
                                                                            ),
                                                                        ),
                                                                    ),
                                                                    Positioned(
                                                                        left: 2,
                                                                        top: 1.92,
                                                                        child: Container(
                                                                            width: 18,
                                                                            height: 7.67,
                                                                            decoration: ShapeDecoration(
                                                                                color: Colors.black,
                                                                                shape: RoundedRectangleBorder(
                                                                                    borderRadius: BorderRadius.circular(1.60),
                                                                                ),
                                                                            ),
                                                                        ),
                                                                    ),
                                                                ],
                                                            ),
                                                        ),
                                                    ),
                                                    Positioned(
                                                        left: 0,
                                                        top: 1,
                                                        child: Container(
                                                            width: 17.10,
                                                            height: 10.70,
                                                            decoration: BoxDecoration(
                                                                image: DecorationImage(
                                                                    image: NetworkImage("https://via.placeholder.com/17x11"),
                                                                    fit: BoxFit.fill,
                                                                ),
                                                            ),
                                                        ),
                                                    ),
                                                    Positioned(
                                                        left: 22.10,
                                                        top: 0.80,
                                                        child: Container(
                                                            width: 15.40,
                                                            height: 11.06,
                                                            decoration: BoxDecoration(
                                                                image: DecorationImage(
                                                                    image: NetworkImage("https://via.placeholder.com/15x11"),
                                                                    fit: BoxFit.fill,
                                                                ),
                                                            ),
                                                        ),
                                                    ),
                                                ],
                                            ),
                                        ),
                                    ],
                                ),
                            ),
                        ],
                    ),
                ),
            ),
            Positioned(
                left: 178,
                top: 56,
                child: Text(
                    '통계',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontFamily: 'Pretendard',
                        fontWeight: FontWeight.w700,
                        height: 0,
                    ),
                ),
            ),
            Positioned(
                left: 360,
                top: 61,
                child: Container(
                    width: 12,
                    height: 12,
                    child: Stack(children: [
                    //
                    ]),
                ),
            ),
        ],
    ),
)
    );
    
  }
}
