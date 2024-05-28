import 'package:flutter/material.dart';

class SpecialDays extends StatefulWidget {
  const SpecialDays({super.key});

  @override
  State<SpecialDays> createState() => _SpecialDaysState();
}

class _SpecialDaysState extends State<SpecialDays> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 390,
      height: 84,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
      decoration: const BoxDecoration(color: Colors.white),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 54,
                        height: 54,
                        padding: const EdgeInsets.only(
                            top: 5, left: 9, right: 8, bottom: 5),
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(color: Colors.white),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: 37,
                              height: 44,
                              child: Stack(
                                children: [
                                  Positioned(
                                    left: 0,
                                    top: 2,
                                    child: Container(
                                      width: 31,
                                      height: 42,
                                      decoration: ShapeDecoration(
                                        color: Color(0xFFEEF1F4),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(1)),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    left: 3,
                                    top: 0,
                                    child: Text(
                                      'TEST',
                                      style: TextStyle(
                                        color: Color(0xFF0099FC),
                                        fontSize: 10,
                                        fontFamily: 'Pretendard',
                                        fontWeight: FontWeight.w600,
                                        height: 0.19,
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    left: 3,
                                    top: 18,
                                    child: Container(
                                      width: 7,
                                      height: 7,
                                      decoration: BoxDecoration(
                                          color: Color(0xFF0099FC)),
                                    ),
                                  ),
                                  Positioned(
                                    left: 13,
                                    top: 18,
                                    child: Container(
                                      width: 15,
                                      height: 7.10,
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            width: 15,
                                            height: 1.50,
                                            decoration: BoxDecoration(
                                                color: Color(0xFFD1D6DC)),
                                          ),
                                          const SizedBox(height: 1.30),
                                          Container(
                                            width: 15,
                                            height: 1.50,
                                            decoration: BoxDecoration(
                                                color: Color(0xFFD1D6DC)),
                                          ),
                                          const SizedBox(height: 1.30),
                                          Container(
                                            width: 15,
                                            height: 1.50,
                                            decoration: BoxDecoration(
                                                color: Color(0xFFD1D6DC)),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    left: 3,
                                    top: 30,
                                    child: Container(
                                      width: 7,
                                      height: 7,
                                      decoration: BoxDecoration(
                                          color: Color(0xFF0099FC)),
                                    ),
                                  ),
                                  Positioned(
                                    left: 13,
                                    top: 30,
                                    child: Container(
                                      width: 15,
                                      height: 7.10,
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            width: 15,
                                            height: 1.50,
                                            decoration: BoxDecoration(
                                                color: Color(0xFFD1D6DC)),
                                          ),
                                          const SizedBox(height: 1.30),
                                          Container(
                                            width: 15,
                                            height: 1.50,
                                            decoration: BoxDecoration(
                                                color: Color(0xFFD1D6DC)),
                                          ),
                                          const SizedBox(height: 1.30),
                                          Container(
                                            width: 15,
                                            height: 1.50,
                                            decoration: BoxDecoration(
                                                color: Color(0xFFD1D6DC)),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    left: 33,
                                    top: 11,
                                    child: Container(
                                      width: 4,
                                      height: 24,
                                      decoration: BoxDecoration(
                                          color: Color(0xFFD1D6DC)),
                                    ),
                                  ),
                                  Positioned(
                                    left: 33,
                                    top: 35,
                                    child: Container(
                                      width: 4,
                                      height: 7,
                                      child: Stack(
                                        children: [
                                          Positioned(
                                            left: 0,
                                            top: 1,
                                            child: Container(
                                              width: 4,
                                              height: 1,
                                              decoration: BoxDecoration(
                                                  color: Color(0xFF0099FC)),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    left: 33,
                                    top: 11,
                                    child: Container(
                                      width: 4,
                                      height: 7,
                                      decoration: ShapeDecoration(
                                        color: Color(0xFF0099FC),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.only(
                                            bottomLeft: Radius.circular(5),
                                            bottomRight: Radius.circular(5),
                                          ),
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
                      const SizedBox(width: 16),
                      Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: '중간고사 기간 \n',
                              style: TextStyle(
                                color: Color(0xFF0099FC),
                                fontSize: 16,
                                fontFamily: 'Pretendard',
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            TextSpan(
                              text: '대학생 흡연율 통계 보러가기',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontFamily: 'Pretendard',
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 123),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
