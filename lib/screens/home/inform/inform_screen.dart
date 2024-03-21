import 'package:damyo/http.dart';
import 'package:damyo/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:go_router/go_router.dart';

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
  final List<bool> _selectedInOut = <bool>[false, false];
  final List<bool> _selectedOpenClose = <bool>[false, false];
  final List<bool> _selectedVentilation = <bool>[false, false];
  final List<bool> _selectedCleanliness = <bool>[false, false];
  final List<bool> _toggleIsSelected = <bool>[false, false, false, false];
  double _starValue = 0;
  String _spotName = '';

  bool activateInformBtn = false;

  @override
  Widget build(BuildContext context) {
    // 이전 지도 페이지에서 좌표를 받아옴
    final String coords = GoRouterState.of(context).extra! as String;
    // 화면을 동적으로 빌드하기 위한 사이즈
    final Size size = MediaQuery.of(context).size;
    final double margin = size.width * 0.05;
    

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          '제보',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(margin),
        child: Column(
          children: [
            Flexible(
              flex: 4,
              child: GestureDetector(
                child: Container(
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    color: Color(0xffd2d7dd),
                    borderRadius: BorderRadius.all(Radius.circular(16)),
                  ),
                  child: const Text('사진을 업로드 해주세요'),
                ),
                onTap: (){
                  // if(!_getCameraPermission()){}
                  
                },
              ),
            ),
            const SizedBox(height: 20),
            Flexible(
              flex: 1,
              fit: FlexFit.tight,
              child: Row(
                children: [
                  const Text('이름',
                      style: TextStyle(fontWeight: FontWeight.w600)),
                  const SizedBox(width: 150),
                  Expanded(
                    child: TextField(
                      decoration: const InputDecoration(
                        hintText: '이름을 입력해주세요',
                        hintStyle: TextStyle(
                          color: Color(0xffd2d7dd),
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                        border: InputBorder.none,
                      ),
                      onChanged: (text) {
                        setState(() {
                          _spotName = text;
                          checkCanInform();
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
            Flexible(
              flex: 1,
              fit: FlexFit.tight,
              child: Row(
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
                        return Text(
                          snapshot.data.toString(),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
            Flexible(
              flex: 1,
              fit: FlexFit.tight,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('별점',
                      style: TextStyle(fontWeight: FontWeight.w600)),
                  ratingStars(),
                ],
              ),
            ),
            InformToggle('실내 여부', inout, _selectedInOut, 0),
            InformToggle('개방 여부', openclose, _selectedOpenClose, 1),
            InformToggle('환풍 여부', ox, _selectedVentilation, 2),
            InformToggle('청결도', ox, _selectedCleanliness, 3),
            const SizedBox(height: 20),
            Flexible(
              flex: 1,
              fit: FlexFit.tight,
              child: InkWell(
                onTap: () {
                  activateInformBtn ? null : null;
                },
                child: Ink(
                  decoration: BoxDecoration(
                    color: activateInformBtn
                        ? Colors.blue
                        : const Color(0xffd2d7dd),
                    borderRadius: const BorderRadius.all(Radius.circular(16)),
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
            ),
          ],
        ),
      ),
    );
  }

  // 제보하기 버튼을 활성화여부를 판단하는 함수
  void checkCanInform() {
    for (int i = 0; i < _toggleIsSelected.length; i++) {
      if (!_toggleIsSelected[i]) {
        return;
      }
    }
    if (_starValue == 0 || _spotName == '') {
      return;
    }
    activateInformBtn = true;
  }

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

  Flexible InformToggle(
      String type, List<Widget> children, List<bool> isSelected, int i) {
    return Flexible(
      flex: 1,
      fit: FlexFit.tight,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            type,
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
          ToggleButtons(
            isSelected: isSelected,
            borderRadius: const BorderRadius.all(Radius.circular(16)),
            onPressed: (int index) {
              setState(() {
                for (int i = 0; i < isSelected.length; i++) {
                  isSelected[i] = i == index;
                }
                _toggleIsSelected[i] = true;
                checkCanInform();
              });
            },
            constraints: const BoxConstraints(
              minHeight: 30.0,
              minWidth: 60.0,
            ),
            children: children,
          ),
        ],
      ),
    );
  }
}
