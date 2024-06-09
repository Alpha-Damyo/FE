import 'package:damyo/screens/home/map/filter/smoking_area_filter_listview.dart';
import 'package:damyo/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

Future<dynamic> filterScreen(BuildContext context,
    Map<String, dynamic> searchFilterMap, Function applyFilter) {
  List<int> filterIndexList = [-1, -1, -1, -1, -1, -1, -1, -1];

  // 실내 실외
  if (searchFilterMap['indoor'] == true) {
    filterIndexList[1] = 0;
  } else if (searchFilterMap['indoor'] == false) {
    filterIndexList[1] = 1;
  }
  // 개방 폐쇄
  if (searchFilterMap['opened'] == true) {
    filterIndexList[2] = 0;
  } else if (searchFilterMap['opened'] == false) {
    filterIndexList[2] = 1;
  }
  // 커요 작아요
  if (searchFilterMap['big'] == true) {
    filterIndexList[3] = 0;
  } else if (searchFilterMap['big'] == false) {
    filterIndexList[3] = 1;
  }
  // 청결해요
  if (searchFilterMap['hygiene'] == true) {
    filterIndexList[4] = 0;
  }
  // 한산해요
  if (searchFilterMap['quite'] == true) {
    filterIndexList[5] = 0;
  }
  // 의자가 있어요
  if (searchFilterMap['chair'] == true) {
    filterIndexList[6] = 0;
  }
  // 환기성이 좋아요
  if (searchFilterMap['airOut'] == true) {
    filterIndexList[7] = 0;
  }

  void setIndex(int index, int value) {
    filterIndexList[index] = value;
  }

  void setFilter() {
    // 실내 실외
    if (filterIndexList[1] == 0) {
      searchFilterMap['indoor'] = true;
      searchFilterMap['outdoor'] = false;
    } else if (filterIndexList[1] == 1) {
      searchFilterMap['indoor'] = false;
      searchFilterMap['outdoor'] = true;
    } else {
      searchFilterMap['indoor'] = null;
      searchFilterMap['outdoor'] = null;
    }
    // 개방 폐쇄
    if (filterIndexList[2] == 0) {
      searchFilterMap['opened'] = true;
      searchFilterMap['closed'] = false;
    } else if (filterIndexList[2] == 1) {
      searchFilterMap['opened'] = false;
      searchFilterMap['closed'] = true;
    } else {
      searchFilterMap['opened'] = null;
      searchFilterMap['closed'] = null;
    }
    // 커요 작아요
    if (filterIndexList[3] == 0) {
      searchFilterMap['big'] = true;
      searchFilterMap['small'] = false;
    } else if (filterIndexList[3] == 1) {
      searchFilterMap['big'] = false;
      searchFilterMap['small'] = true;
    } else {
      searchFilterMap['big'] = null;
      searchFilterMap['small'] = null;
    }
    // 청결해요
    if (filterIndexList[4] == 0) {
      searchFilterMap['hygiene'] = true;
    } else {
      searchFilterMap['hygiene'] = null;
    }
    // 한산해요
    if (filterIndexList[5] == 0) {
      searchFilterMap['quite'] = true;
    } else {
      searchFilterMap['quite'] = null;
    }
    // 의자가 있어요
    if (filterIndexList[6] == 0) {
      searchFilterMap['chair'] = true;
    } else {
      searchFilterMap['chair'] = null;
    }
    // 환기성이 좋아요
    if (filterIndexList[7] == 0) {
      searchFilterMap['airOut'] = true;
    } else {
      searchFilterMap['airOut'] = null;
    }
  }

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
              padding: const EdgeInsets.symmetric(horizontal: 16),
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
                          // Text(
                          //   "별점",
                          //   style: Theme.of(context).textTheme.displaySmall,
                          // ),
                          // const SizedBox(height: 20),
                          // FilterListview(
                          //   characterList: const [
                          //     '1점 이상',
                          //     '2점 이상',
                          //     '3점 이상',
                          //     '4점 이상',
                          //     '5점 이상'
                          //   ],
                          //   selectedCharacterIndex: -1,
                          // ),
                          const SizedBox(height: 20),
                          textFormat(
                            text: "실내 여부",
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                          const SizedBox(height: 20),
                          FilterListview(
                            characterList: const [
                              '실내',
                              '실외',
                            ],
                            selectedCharacterIndex: filterIndexList[1],
                            setIndex: (v) {
                              setIndex(1, v);
                            },
                          ),
                          const SizedBox(height: 20),
                          textFormat(
                            text: "개방 여부",
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                          const SizedBox(height: 20),
                          FilterListview(
                            characterList: const [
                              '개방형',
                              '폐쇄형',
                            ],
                            selectedCharacterIndex: filterIndexList[2],
                            setIndex: (v) {
                              setIndex(2, v);
                            },
                          ),
                          const SizedBox(height: 20),
                          textFormat(
                            text: "기타",
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                          const SizedBox(height: 20),
                          FilterListview(
                            characterList: const [
                              '흡연구역이 커요',
                              '흡연구역이 작아요',
                            ],
                            selectedCharacterIndex: filterIndexList[3],
                            setIndex: (v) {
                              setIndex(3, v);
                            },
                          ),
                          const SizedBox(height: 20),
                          FilterListview(
                            characterList: const [
                              '흡연실이 청결해요',
                            ],
                            selectedCharacterIndex: filterIndexList[4],
                            setIndex: (v) {
                              setIndex(4, v);
                            },
                          ),
                          const SizedBox(height: 20),
                          FilterListview(
                            characterList: const [
                              '흡연실이 한산해요',
                            ],
                            selectedCharacterIndex: filterIndexList[5],
                            setIndex: (v) {
                              setIndex(5, v);
                            },
                          ),
                          const SizedBox(height: 20),
                          FilterListview(
                            characterList: const [
                              '의자가 있어요',
                            ],
                            selectedCharacterIndex: filterIndexList[6],
                            setIndex: (v) {
                              setIndex(6, v);
                            },
                          ),
                          const SizedBox(height: 20),
                          FilterListview(
                            characterList: const [
                              '환기성이 좋아요',
                            ],
                            selectedCharacterIndex: filterIndexList[7],
                            setIndex: (v) {
                              setIndex(7, v);
                            },
                          ),
                          const SizedBox(height: 10),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  InkWell(
                    onTap: () async {
                      setFilter();
                      applyFilter();
                      context.pop();
                    },
                    borderRadius: BorderRadius.circular(26),
                    child: Ink(
                      width: double.infinity,
                      height: 60,
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(26),
                      ),
                      child: Align(
                        alignment: Alignment.center,
                        child: textFormat(
                          text: '적용하기',
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
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
