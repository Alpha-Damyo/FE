import 'dart:io';

import 'package:damyo/http.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

const List<Text> inout = <Text>[
  Text('실내'),
  Text('실외'),
];

const List<Text> openclose = <Text>[
  Text('개방'),
  Text('폐쇄'),
];

const List<Text> goodBad = <Text>[
  Text('좋음'),
  Text('나쁨'),
];

const List<Text> cleanDirty = <Text>[
  Text('깨끗함'),
  Text('더러움'),
];

const List<Text> complex = <Text>[
  Text('혼잡함'),
  Text('한산함'),
];

const List<Text> bigSmall = <Text>[
  Text('큼'),
  Text('작음'),
];

const List<Text> ox = <Text>[
  Text('O'),
  Text('X'),
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
  final List<String> _spotInfo = ['', '', ''];
  double _starValue = 0;
  final List<bool> _selectedInOut = <bool>[false, false];
  final List<bool> _selectedOpenClose = <bool>[false, false];
  final List<bool> _selectedVentilation = <bool>[false, false];
  final List<bool> _selectedCleanliness = <bool>[false, false];
  final List<bool> _selectedIsExist = <bool>[false, false];
  final List<bool> _selectedSize = <bool>[false, false];
  final List<bool> _selectedComplex = <bool>[false, false];
  final List<bool> _selectedHasChair = <bool>[false, false];

  final List<bool> _toggleIsSelected = <bool>[
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
  ];

  bool activateInformBtn = false;

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
                      InkWell(
                        child: Container(
                          width: double.infinity,
                          height: 184.h,
                          alignment: Alignment.center,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          child: informImage(),
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "이름",
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                          Text(
                            saName,
                            style: const TextStyle(fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                      const SizedBox(height: 30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Row(
                            children: [
                              Text('별점',
                                  style:
                                      TextStyle(fontWeight: FontWeight.w600)),
                            ],
                          ),
                          ratingStars(),
                        ],
                      ),
                      const SizedBox(height: 20),
                      reviewToggle('실내 여부', inout, _selectedInOut, 0),
                      const SizedBox(height: 20),
                      reviewToggle('개방 여부', openclose, _selectedOpenClose, 1),
                      const SizedBox(height: 20),
                      reviewToggle('환기성', goodBad, _selectedVentilation, 2),
                      const SizedBox(height: 20),
                      reviewToggle('깨끗함', cleanDirty, _selectedCleanliness, 3),
                      const SizedBox(height: 20),
                      reviewToggle('크기', bigSmall, _selectedSize, 4),
                      const SizedBox(height: 20),
                      reviewToggle('혼잡도', complex, _selectedComplex, 5),
                      const SizedBox(height: 20),
                      reviewToggle('의자가 있음', ox, _selectedHasChair, 6),
                      const SizedBox(height: 20),
                      reviewToggle('존재하지 않음', ox, _selectedIsExist, 7),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
              // reviewToggle('환풍 여부', ox, _selectedVentilation, 2),
              // reviewToggle('청결도', ox, _selectedCleanliness, 3),
              InkWell(
                onTap: () {
                  print('실내 여부: ${_selectedInOut[0]}');
                  print('개방 여부: ${_selectedOpenClose[0]}');
                  print('환기 여부: ${_selectedVentilation[0]}');
                  print('깨끗함: ${_selectedCleanliness[0]}');
                  print('크기: ${_selectedSize[0]}');
                  print('혼잡도: ${_selectedComplex[0]}');
                  print('의자: ${_selectedHasChair[0]}');
                  print('존재하지 않음: ${_selectedIsExist[0]}');
                },
                child: Ink(
                  width: double.infinity,
                  height: 47.h,
                  decoration: BoxDecoration(
                    color: activateInformBtn
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
  Container informImage() {
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
            child: Icon(
              Icons.camera_alt_rounded,
              size: 60.w,
              color: const Color(0xffa9afb7),
            ),
          );
  }

  // 텍스트를 입력받는 위젯
  Row reviewTextInput(String type, String hint, int index) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(type, style: const TextStyle(fontWeight: FontWeight.w600)),
        index == 0 ? const blueStar() : const Text(""),
        const SizedBox(width: 120),
        Expanded(
          child: TextField(
            decoration: InputDecoration(
              hintText: hint,
              hintTextDirection: TextDirection.rtl,
              hintStyle: const TextStyle(
                color: Color(0xffd2d7dd),
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
              border: InputBorder.none,
            ),
            onChanged: (text) {
              setState(() {
                _spotInfo[index] = text;
              });
            },
          ),
        ),
      ],
    );
  }

  // 제보하기 버튼 활성화여부를 판단하는 함수
  void checkCanReview() {
    for (int i = 0; i < _toggleIsSelected.length; i++) {
      if (!_toggleIsSelected[i]) {
        activateInformBtn = false;
        return;
      }
    }
    if (_starValue == 0) {
      activateInformBtn = false;
      return;
    }
    activateInformBtn = true;
  }

  // 별점을 입력받는 위젯
  RatingStars ratingStars() {
    return RatingStars(
      value: _starValue,
      starBuilder: (index, color) => Icon(
        Icons.star,
        color: color,
      ),
      onValueChanged: (v) {
        setState(() {
          _starValue = v;
          checkCanReview();
        });
      },
      starCount: 5,
      starSize: 25,
      valueLabelVisibility: false,
    );
  }

  // 토글버튼으로 정보를 입력받는 위젯
  Row reviewToggle(
      String type, List<Text> children, List<bool> isSelected, int i) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Text(
              type,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ],
        ),
        Material(
          color: const Color(0xffeef1f5),
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          child: Padding(
            padding: const EdgeInsets.all(3),
            child: Row(
              children: [
                GestureDetector(
                  child: Container(
                    width: children[0].data?.length == 3 ? 55.w : 45.w,
                    height: 27.h,
                    decoration: BoxDecoration(
                      color: isSelected[0]
                          ? Colors.white
                          : const Color(0xffeef1f5),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Align(
                      alignment: Alignment.center,
                      child: children[0],
                    ),
                  ),
                  onTap: () {
                    setState(() {
                      isSelected[0] = true;
                      isSelected[1] = false;
                      _toggleIsSelected[i] = true;
                      checkCanReview();
                    });
                  },
                ),
                GestureDetector(
                  child: Container(
                    width: children[1].data?.length == 3 ? 55.w : 45.w,
                    height: 27.h,
                    decoration: BoxDecoration(
                      color: isSelected[1]
                          ? Colors.white
                          : const Color(0xffeef1f5),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Align(
                      alignment: Alignment.center,
                      child: children[1],
                    ),
                  ),
                  onTap: () {
                    setState(() {
                      isSelected[0] = false;
                      isSelected[1] = true;
                      _toggleIsSelected[i] = true;
                      checkCanReview();
                    });
                  },
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class blueStar extends StatelessWidget {
  const blueStar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: const Offset(3, -3),
      child: const Text(
        '*',
        style: TextStyle(
          color: Colors.blue,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
