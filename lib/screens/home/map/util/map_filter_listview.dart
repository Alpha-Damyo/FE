import 'package:flutter/material.dart';

class MapFilterListview extends StatefulWidget {
  final List<String> characterList;
  final Future<void> filterOnClick;
  Map<String, dynamic> searchFilterMap;
  MapFilterListview({
    super.key,
    required this.characterList,
    required this.filterOnClick,
    required this.searchFilterMap,
  });

  @override
  State<MapFilterListview> createState() => _MapFilterListviewState();
}

class _MapFilterListviewState extends State<MapFilterListview> {
  int _selectedIndex = -1;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 70,
      height: 35,
      alignment: Alignment.centerLeft,
      child: ListView.builder(
        itemCount: widget.characterList.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.only(
              right: index == widget.characterList.length - 1 ? 5 : 10,
              bottom: 5,
            ), // 마지막 아이템에는 패딩을 적용하지 않음.
            child: GestureDetector(
              onTap: () async {
                setState(() {
                  if (_selectedIndex == index) {
                    _selectedIndex = -1;
                    if (index == 1) {
                      widget.searchFilterMap['outdoor'] = null;
                    } else if (index == 2) {
                      widget.searchFilterMap['opened'] = null;
                    } else if (index == 3) {
                      widget.searchFilterMap['quite'] = null;
                    } else if (index == 4) {
                      widget.searchFilterMap['hygiene'] = null;
                    } else {
                      widget.searchFilterMap['chair'] = null;
                    }
                  } else {
                    _selectedIndex = index;
                    if (index == 1) {
                      widget.searchFilterMap['outdoor'] = true;
                    } else if (index == 2) {
                      widget.searchFilterMap['opened'] = true;
                    } else if (index == 3) {
                      widget.searchFilterMap['quite'] = true;
                    } else if (index == 4) {
                      widget.searchFilterMap['hygiene'] = true;
                    } else {
                      widget.searchFilterMap['chair'] = true;
                    }
                  }
                });
                // await widget.filterOnClick;
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                ),
                decoration: BoxDecoration(
                  color: _selectedIndex == index
                      ? Theme.of(context).colorScheme.onPrimary
                      : Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: _selectedIndex == index
                      ? Border.all(
                          color: Theme.of(context).colorScheme.primary,
                        )
                      : Border.all(
                          color: const Color(0xffE4E7EB),
                        ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 0,
                      blurRadius: 2.0,
                      offset: const Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    widget.characterList[index],
                    style: const TextStyle(
                      color: Color(0xFF464D57),
                      fontSize: 12,
                      fontFamily: 'Pretendard',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
