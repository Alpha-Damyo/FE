import 'dart:io';

import 'package:damyo/services/get_smoking_area_service.dart';
import 'package:damyo/services/get_address_service.dart';
import 'package:damyo/services/inform_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

const List<Widget> inout = <Widget>[
  Text('실내'),
  Text('실외'),
];

const List<Widget> openclose = <Widget>[
  Text('개방'),
  Text('폐쇄'),
];

const List<Widget> ox = <Widget>[
  Text('O'),
  Text('X'),
];

class InformScreen extends StatefulWidget {
  const InformScreen({
    super.key,
  });

  @override
  State<InformScreen> createState() => _InformScreenState();
}

class _InformScreenState extends State<InformScreen> {
  XFile? _spotImage;
  final ImagePicker picker = ImagePicker();
  // 이름, 설명, 주소 순으로 저장
  final List<String> _spotInfo = ['', '', ''];
  double _starValue = 0;
  final List<bool> _selectedInOut = <bool>[false, false];
  final List<bool> _selectedOpenClose = <bool>[false, false];
  final List<bool> _selectedVentilation = <bool>[false, false];
  final List<bool> _selectedCleanliness = <bool>[false, false];
  final List<bool> _toggleIsSelected = <bool>[false, false];

  bool activateInformBtn = false;

  @override
  Widget build(BuildContext context) {
    // 이전 지도 페이지에서 좌표를 받아옴
    final String coords = GoRouterState.of(context).extra! as String;
    // 화면을 동적으로 빌드하기 위한 사이즈

    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        title: const Text(
          '제보',
        ),
        centerTitle: true,
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    FocusScope.of(context).unfocus();
                  },
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        InkWell(
                          child: Container(
                            width: double.infinity,
                            height: 184,
                            alignment: Alignment.center,
                            decoration: const BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
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
                                            title: const Text(
                                              '카메라에서 선택',
                                              style: TextStyle(fontSize: 18),
                                            ),
                                            onTap: () {
                                              getImage(ImageSource.camera);
                                              Navigator.of(context).pop();
                                            }),
                                        ListTile(
                                          leading:
                                              const Icon(Icons.photo_library),
                                          title: const Text(
                                            '갤러리에서 선택',
                                            style: TextStyle(fontSize: 18),
                                          ),
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
                        informTextInput('이름', '이름을 입력해주세요', 0),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('주소',
                                style: TextStyle(fontWeight: FontWeight.w600)),
                            // Text('서울특별시 중구 남산동2가 2'),
                            FutureBuilder(
                              future: GetAddress(coords),
                              builder: (
                                BuildContext context,
                                AsyncSnapshot snapshot,
                              ) {
                                // 데이터가 없을 때
                                if (snapshot.hasData == false) {
                                  return const Text('...');
                                } else if (snapshot.hasError) {
                                  return const Text('주소를 불러올 수 없습니다');
                                } else {
                                  _spotInfo[2] = snapshot.data.toString();
                                  return Text(
                                    _spotInfo[2],
                                  );
                                }
                              },
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        informTextInput('상세주소', '상세주소를 입력해주세요', 1),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Row(
                              children: [
                                Text('별점',
                                    style:
                                        TextStyle(fontWeight: FontWeight.w600)),
                                blueStar(),
                              ],
                            ),
                            ratingStars(),
                          ],
                        ),
                        const SizedBox(height: 20),
                        informToggle('실내 여부', inout, _selectedInOut, 0),
                        const SizedBox(height: 20),
                        informToggle('개방 여부', openclose, _selectedOpenClose, 1),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              InkWell(
                onTap: () async {
                  Map<String, dynamic> informData = {
                    'name': _spotInfo[0],
                    'createdAt': DateTime.now().toString().substring(0, 10),
                    'description': _spotInfo[1],
                    'latitude': coords.split(',')[1],
                    'longitude': coords.split(',')[0],
                    'score': _starValue.toString(),
                    'opened': _selectedInOut[0].toString(),
                    'closed': _selectedInOut[1].toString(),
                    'hygiene': '',
                    'dirty': '',
                    'airOut': '',
                    'indoor': _selectedInOut[0].toString(),
                    'outdoor': _selectedInOut[1].toString(),
                    'big': '',
                    'small': '',
                    'crowded': '',
                    'quite': '',
                    'chair': '',
                  };

                  await informSmokingArea(informData);
                },
                child: Ink(
                  width: double.infinity,
                  height: 47,
                  decoration: BoxDecoration(
                    color: activateInformBtn
                        ? Colors.blue
                        : const Color(0xffd2d7dd),
                    borderRadius: const BorderRadius.all(Radius.circular(26)),
                  ),
                  child: const Align(
                    alignment: Alignment.center,
                    child: Text(
                      '제보하기',
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
            child: const Icon(
              Icons.camera_alt_rounded,
              size: 60,
              color: Color(0xffa9afb7),
            ),
          );
  }

  // 텍스트를 입력받는 위젯
  Row informTextInput(String type, String hint, int index) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(type, style: const TextStyle(fontWeight: FontWeight.w600)),
        index == 0 ? const blueStar() : const Text(""),
        const SizedBox(width: 50),
        Expanded(
          child: TextField(
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.right,
            // enableSuggestions: false,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              hintText: hint,
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
                checkCanInform();
              });
            },
          ),
        ),
      ],
    );
  }

  // 제보하기 버튼 활성화여부를 판단하는 함수
  void checkCanInform() {
    for (int i = 0; i < _toggleIsSelected.length; i++) {
      if (!_toggleIsSelected[i]) {
        activateInformBtn = false;
        return;
      }
    }
    if (_starValue == 0 || _spotInfo[0] == '') {
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
          checkCanInform();
        });
      },
      starCount: 5,
      starSize: 25,
      valueLabelVisibility: false,
    );
  }

  // 토글버튼으로 정보를 입력받는 위젯
  Row informToggle(
      String type, List<Widget> children, List<bool> isSelected, int i) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Text(
              type,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
            const blueStar(),
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
                    width: 45,
                    height: 27,
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
                      checkCanInform();
                    });
                  },
                ),
                GestureDetector(
                  child: Container(
                    width: 45,
                    height: 27,
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
                      checkCanInform();
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
