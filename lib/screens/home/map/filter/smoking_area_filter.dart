import 'package:damyo/screens/home/map/filter/smoking_area_filter_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Future<dynamic> filterScreen(BuildContext context) {
  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (BuildContext context) {
      return ScreenUtilInit(
        designSize: const Size(390, 667),
        builder: (context, child) => SizedBox(
          width: double.infinity,
          height: 527.h,
          child: Material(
            color: Colors.white,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  SizedBox(height: 14.h),
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      width: 35.w,
                      height: 5.h,
                      decoration: BoxDecoration(
                          color: const Color(0xffe4e7eB),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: const Color(0xffE4E7EB))),
                    ),
                  ),
                  SizedBox(height: 36.h),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "별점",
                            style: Theme.of(context).textTheme.displaySmall,
                          ),
                          const SizedBox(height: 20),
                          FilterListview(
                            characterList: const [
                              '1점 이상',
                              '2점 이상',
                              '3점 이상',
                              '4점 이상',
                              '5점 이상'
                            ],
                            selectedCharacterIndex: -1,
                          ),
                          const SizedBox(height: 20),
                          Text(
                            "실내 여부",
                            style: Theme.of(context).textTheme.displaySmall,
                          ),
                          const SizedBox(height: 20),
                          FilterListview(
                            characterList: const [
                              '실내',
                              '실외',
                            ],
                            selectedCharacterIndex: -1,
                          ),
                          const SizedBox(height: 20),
                          Text(
                            "개방 여부",
                            style: Theme.of(context).textTheme.displaySmall,
                          ),
                          const SizedBox(height: 20),
                          FilterListview(
                            characterList: const [
                              '개방형',
                              '폐쇄형',
                            ],
                            selectedCharacterIndex: -1,
                          ),
                          const SizedBox(height: 20),
                          Text(
                            "기타",
                            style: Theme.of(context).textTheme.displaySmall,
                          ),
                          const SizedBox(height: 20),
                          FilterListview(
                            characterList: const [
                              '흡연구역이 커요',
                              '흡연구역이 작아요',
                            ],
                            selectedCharacterIndex: -1,
                          ),
                          const SizedBox(height: 20),
                          FilterListview(
                            characterList: const [
                              '흡연실이 청결해요',
                            ],
                            selectedCharacterIndex: -1,
                          ),
                          const SizedBox(height: 20),
                          FilterListview(
                            characterList: const [
                              '흡연실이 한산해요',
                            ],
                            selectedCharacterIndex: -1,
                          ),
                          const SizedBox(height: 20),
                          FilterListview(
                            characterList: const [
                              '의자가 있어요',
                            ],
                            selectedCharacterIndex: -1,
                          ),
                          const SizedBox(height: 20),
                          FilterListview(
                            characterList: const [
                              '환기성이 좋아요',
                            ],
                            selectedCharacterIndex: -1,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  InkWell(
                    onTap: () {},
                    child: Ink(
                      width: double.infinity,
                      height: 47.h,
                      decoration: const BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.all(Radius.circular(16)),
                      ),
                      child: const Align(
                        alignment: Alignment.center,
                        child: Text(
                          '적용하기',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      );
    },
  );
}
