import 'package:flutter/material.dart';

class MapFilterListview extends StatefulWidget {
  final List<String> characterList;
  const MapFilterListview({
    super.key,
    required this.characterList,
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
              right: index == widget.characterList.length - 1 ? 0 : 10,
              bottom: 5,
            ), // 마지막 아이템에는 패딩을 적용하지 않음.
            child: GestureDetector(
              onTap: () {
                setState(() {
                  if (_selectedIndex == index) {
                    _selectedIndex = -1;
                  } else {
                    _selectedIndex = index;
                  }
                });
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
                      offset: const Offset(3, 3), // changes position of shadow
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
