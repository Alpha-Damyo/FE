import 'dart:io';

import 'package:damyo/screens/home/map/somking_area/review/write_review_listview.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

const List<String> inout = [
  '실내',
  '실외',
];

const List<String> openclose = [
  '개방',
  '폐쇄',
];

const List<String> bigSmall = [
  '흡연실이 커요',
  '흡연실이 작아요',
];

const List<String> complex = [
  '흡연실이 혼잡해요',
  '흡연실이 한산해요',
];

const List<String> cleanDirty = [
  '흡연실이 청결해요',
  '흡연실이 더러워요',
];

const List<String> etc = [
  '의자가 있어요',
  '환기성이 좋아요',
  '존재하지 않아요',
];

class WriteReviewScreen extends StatefulWidget {
  const WriteReviewScreen({
    super.key,
  });

  @override
  State<WriteReviewScreen> createState() => _WriteReviewScreenState();
}

class _WriteReviewScreenState extends State<WriteReviewScreen> {
  XFile? _spotImage;
  final ImagePicker picker = ImagePicker();
  // 이름, 설명, 주소 순으로 저장
  double _starValue = 0;
  final List<List<bool>> _tagIndex = [
    [false, false],
    [false, false],
    [false, false],
    [false, false],
    [false, false],
    [false, false, false],
  ];

  bool activateReviewBtn = false;

  @override
  Widget build(BuildContext context) {
    // 이전 지도 페이지에서 이름을 받아옴
    final String saName = GoRouterState.of(context).extra! as String;
    // 화면을 동적으로 빌드하기 위한 사이즈

    return ScreenUtilInit(
      designSize: const Size(390, 733),
      builder: (context, child) => Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          scrolledUnderElevation: 0,
          title: Text(
            '리뷰 작성',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.only(
            left: 20,
            right: 20,
            bottom: 20,
          ),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                saName,
                                style: const TextStyle(
                                  color: Color(0xff0099fc),
                                  fontSize: 24,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              const Text(
                                '에',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                          const Text(
                            '방문했어요!',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      InkWell(
                        child: Container(
                          width: double.infinity,
                          height: 160,
                          alignment: Alignment.center,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          child: imageGetter(),
                        ),
                        onTap: () {
                          // getImage(ImageSource.camera);
                          showModalBottomSheet(
                              context: context,
                              builder: (BuildContext bc) {
                                return SafeArea(
                                  child: Wrap(
                                    children: <Widget>[
                                      ListTile(
                                          leading:
                                              const Icon(Icons.photo_camera),
                                          title: const Text('카메라에서 선택'),
                                          onTap: () {
                                            getImage(ImageSource.camera);
                                            Navigator.of(context).pop();
                                          }),
                                      ListTile(
                                        leading:
                                            const Icon(Icons.photo_library),
                                        title: const Text('갤러리에서 선택'),
                                        onTap: () {
                                          getImage(ImageSource.gallery);
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                    ],
                                  ),
                                );
                              });
                        },
                      ),
                      const SizedBox(height: 20),
                      Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(
                            width: 1,
                            color: const Color(0xFFE4E7EB),
                          ),
                        ),
                        child: Column(
                          children: [
                            const Text(
                              "만족도를 평가해주세요",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 10),
                            ratingStars()
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(
                            width: 1,
                            color: const Color(0xFFE4E7EB),
                          ),
                        ),
                        child: Column(
                          children: [
                            const Text(
                              "특징을 골라주세요",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 20),
                            selectTagColumn("실내 여부", inout, _tagIndex[0]),
                            selectTagColumn("개방 여부", openclose, _tagIndex[1]),
                            // WriteReviewListview(
                            //     characterList: inout,
                            //     selectedCharacterIndex: _tagIndex[0]),
                            // WriteReviewListview(
                            //     characterList: openclose,
                            //     selectedCharacterIndex: _tagIndex[1])
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(
                            width: 1,
                            color: const Color(0xFFE4E7EB),
                          ),
                        ),
                        child: Column(
                          children: [
                            const Text(
                              "리뷰할 태그를 선택해주세요",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 20),
                            selectTagColumn("크기", bigSmall, _tagIndex[2]),
                            selectTagColumn("혼잡도", complex, _tagIndex[3]),
                            selectTagColumn("청결도", cleanDirty, _tagIndex[4]),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  '기타',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                WriteReviewDuplicateListview(
                                  characterList: etc,
                                  selectedCharacterIndex: _tagIndex[5],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              InkWell(
                onTap: () {
                  // print('실내 여부: ${_selectedInOut[0]}');
                  // print('개방 여부: ${_selectedOpenClose[0]}');
                  // print('환기 여부: ${_selectedVentilation[0]}');
                  // print('깨끗함: ${_selectedCleanliness[0]}');
                  // print('크기: ${_selectedSize[0]}');
                  // print('혼잡도: ${_selectedComplex[0]}');
                  // print('의자: ${_selectedHasChair[0]}');
                  // print('존재하지 않음: ${_selectedIsExist[0]}');
                },
                child: Ink(
                  width: double.infinity,
                  height: 47.h,
                  decoration: BoxDecoration(
                    color: activateReviewBtn
                        ? Colors.blue
                        : const Color(0xffd2d7dd),
                    borderRadius: const BorderRadius.all(Radius.circular(16)),
                  ),
                  child: const Align(
                    alignment: Alignment.center,
                    child: Text(
                      '리뷰 작성',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Column selectTagColumn(
      String tagName, List<String> tagList, List<bool> tagIndex) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          tagName,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 10),
        WriteReviewListview(
            characterList: tagList, selectedCharacterIndex: tagIndex),
        const SizedBox(height: 15),
      ],
    );
  }

  // 이미지를 가져오는 함수
  Future getImage(ImageSource imageSource) async {
    final XFile? pickedFile = await picker.pickImage(source: imageSource);
    if (pickedFile != null) {
      setState(() {
        _spotImage = XFile(pickedFile.path);
      });
    }
  }

  // 이미지를 입력받는 위젯
  Container imageGetter() {
    return _spotImage != null
        ? Container(
            alignment: Alignment.center,
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(16)),
            ),
            child: Image.file(
              File(_spotImage!.path),
            ),
          )
        : Container(
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              color: Color(0xffeef1f5),
              borderRadius: BorderRadius.all(Radius.circular(16)),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.camera_alt_rounded,
                  size: 60.w,
                  color: const Color(0xffa9afb7),
                ),
                const Text(
                  '사진을 추가해주세요! (선택)',
                  style: TextStyle(
                    color: Color(0xff464D57),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          );
  }

  // 리뷰 작성 버튼 활성화여부를 판단하는 함수
  void checkCanReview() {
    if (_starValue == 0) {
      activateReviewBtn = false;
      return;
    }
    activateReviewBtn = true;
  }

  // 별점을 입력받는 위젯
  RatingStars ratingStars() {
    return RatingStars(
      value: _starValue,
      starBuilder: (index, color) => Icon(
        Icons.star,
        size: 38,
        color: color,
      ),
      onValueChanged: (v) {
        setState(() {
          _starValue = v;
          checkCanReview();
        });
      },
      starCount: 5,
      starSize: 38,
      starColor: Theme.of(context).colorScheme.primary,
      valueLabelVisibility: false,
    );
  }
}
