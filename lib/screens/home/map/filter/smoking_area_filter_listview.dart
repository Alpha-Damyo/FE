import 'package:flutter/material.dart';

// // "1점 이상"과 같은 버튼
// class FilterContainer extends StatefulWidget {
//   final String name;
//   final List<bool> selectedCharacter;
//   final List<String> listChararcter;

//   const FilterContainer({
//     super.key,
//     required this.name,
//     required this.selectedCharacter,
//     required this.listChararcter,
//   });

//   @override
//   State<FilterContainer> createState() => _FilterContainerState();
// }

// class _FilterContainerState extends State<FilterContainer> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 29,
//       padding: const EdgeInsets.symmetric(
//         horizontal: 15,
//       ),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(16),
//         border: Border.all(
//           color: const Color(0xffE4E7EB),
//         ),
//       ),
//       child: Align(
//         alignment: Alignment.center,
//         child: Text(
//           widget.name,
//           style: const TextStyle(
//             color: Color(0xFF454D56),
//             fontSize: 12,
//             fontFamily: 'Pretendard',
//             fontWeight: FontWeight.w500,
//           ),
//         ),
//       ),
//     );
//   }
// }

// Listview
class FilterListview extends StatefulWidget {
  final List<String> characterList;
  int selectedCharacterIndex;
  FilterListview({
    super.key,
    required this.characterList,
    required this.selectedCharacterIndex,
  });

  @override
  State<FilterListview> createState() => _FilterListviewState();
}

class _FilterListviewState extends State<FilterListview> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: MediaQuery.of(context).size.width - 40,
          height: 30,
          alignment: Alignment.centerLeft,
          child: ListView.builder(
            itemCount: widget.characterList.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.only(
                    right: index == widget.characterList.length - 1
                        ? 0
                        : 15), // 마지막 아이템에는 패딩을 적용하지 않음.
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      if (widget.selectedCharacterIndex == index) {
                        widget.selectedCharacterIndex = -1;
                      } else {
                        widget.selectedCharacterIndex = index;
                      }
                    });
                  },
                  child: Container(
                    height: 29,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15,
                    ),
                    decoration: BoxDecoration(
                        color: widget.selectedCharacterIndex == index
                            ? Theme.of(context).colorScheme.onPrimary
                            : Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: widget.selectedCharacterIndex == index
                            ? Border.all(
                                color: Theme.of(context).colorScheme.primary,
                              )
                            : Border.all(
                                color: const Color(0xffE4E7EB),
                              )),
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
        ),
      ],
    );
  }
}
