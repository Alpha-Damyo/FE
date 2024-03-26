import 'dart:io';

import 'package:damyo/http.dart';
import 'package:damyo/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
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

const List<Widget> bigsmall = <Widget>[
  Text('크다'),
  Text('작다'),
];

const List<Widget> density = <Widget>[
  Text('혼잡'),
  Text('한산'),
];


class FilterScreen extends StatefulWidget {
  const FilterScreen({
    super.key,
  });

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  final List<bool> _selectedInOut = <bool>[false, false];
  final List<bool> _selectedOpenClose = <bool>[false, false];
  final List<bool> _selectedVentilation = <bool>[false, false];
  final List<bool> _selectedCleanliness = <bool>[false, false];
  final List<bool> _selectedBigSmall = <bool>[false, false];
  final List<bool> _selectedDenisty = <bool>[false, false];
  final List<bool> _toggleIsSelected = <bool>[false, false, false, false, false, false];

  bool activateInformBtn = false;

  @override
  Widget build(BuildContext context) {
    // 화면을 동적으로 빌드하기 위한 사이즈
    final Size size = MediaQuery.of(context).size;
    final double margin = size.width * 0.05;
    

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          '필터',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(margin),
        child: Column(
          children: [
            Flexible(
              flex: 10,
              fit: FlexFit.tight,
              child: Column(
                children: [
                  informToggle('실내 여부', inout, _selectedInOut, 0),
                  informToggle('개방 여부', openclose, _selectedOpenClose, 1),
                  informToggle('환풍 여부', ox, _selectedVentilation, 2),
                  informToggle('청결함 여부', ox, _selectedCleanliness, 3),
                  informToggle('크기', bigsmall, _selectedBigSmall, 4),
                  informToggle('혼잡도', density, _selectedDenisty, 5),
                ],
              ) ,
            ),
            Flexible(
              flex: 1,
              fit: FlexFit.tight,
              child: InkWell(
                onTap: () {
                  
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
                      '설정하기',
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

  // 토글버튼으로 정보를 입력받는 위젯
  Flexible informToggle(
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

  // 설정하기 버튼 활성화여부를 판단하는 함수
  void checkCanInform() {
  for (int i = 0; i < _toggleIsSelected.length; i++) {
    if (!_toggleIsSelected[i]) {
      activateInformBtn = false;
      return;
    }
  }
  activateInformBtn = true;
  }
}



