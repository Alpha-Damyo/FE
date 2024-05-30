import 'package:go_router/go_router.dart';
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
      child: Ink(
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
                          decoration: const BoxDecoration(color: Colors.white),
                          child: const Image(
                              image: AssetImage('assets/icons/test.png')),
                        ),
                        const SizedBox(width: 16),
                        const Text.rich(
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
                  const SizedBox(width: 80),
                  IconButton(
                    onPressed: () {
                      context.push('/special_day');
                    },
                    icon: const ImageIcon(
                      AssetImage('assets/icons/go.png'),
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
