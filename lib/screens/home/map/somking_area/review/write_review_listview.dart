import 'package:flutter/material.dart';

// Listview
class WriteReviewListview extends StatefulWidget {
  final List<String> characterList;
  int selectedCharacterIndex;
  WriteReviewListview({
    super.key,
    required this.characterList,
    required this.selectedCharacterIndex,
  });

  @override
  State<WriteReviewListview> createState() => _WriteReviewListview();
}

class _WriteReviewListview extends State<WriteReviewListview> {
  @override
  Widget build(BuildContext context) {
    // int index = widget.selectedCharacterIndex;
    return Row(children: <Widget>[
      for (int i = 0; i < widget.characterList.length; i++)
        Padding(
          padding: const EdgeInsets.only(right: 7.5),
          child: GestureDetector(
            onTap: () {
              setState(() {
                if (widget.selectedCharacterIndex == i) {
                  widget.selectedCharacterIndex = -1;
                } else {
                  widget.selectedCharacterIndex = i;
                }
              });
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: widget.selectedCharacterIndex == i
                    ? Theme.of(context).colorScheme.onPrimary
                    : Colors.white,
                border: Border.all(
                  color: widget.selectedCharacterIndex == i
                      ? Theme.of(context).colorScheme.primary
                      : const Color(0xFFE4E7EB),
                ),
                borderRadius: BorderRadius.circular(36),
              ),
              child: Text(
                widget.characterList[i],
                style: const TextStyle(
                  fontSize: 12,
                ),
              ),
            ),
          ),
        ),
    ]);
  }
}

// Listview
class WriteReviewDuplicateListview extends StatefulWidget {
  final List<String> characterList;
  List<bool> selectedCharacterIndex;
  WriteReviewDuplicateListview({
    super.key,
    required this.characterList,
    required this.selectedCharacterIndex,
  });

  @override
  State<WriteReviewDuplicateListview> createState() =>
      _WriteReviewDuplicateListview();
}

class _WriteReviewDuplicateListview
    extends State<WriteReviewDuplicateListview> {
  @override
  Widget build(BuildContext context) {
    // int index = widget.selectedCharacterIndex;
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(children: <Widget>[
        for (int i = 0; i < widget.characterList.length; i++)
          Padding(
            padding: const EdgeInsets.only(right: 7.5),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  widget.selectedCharacterIndex[i] =
                      !widget.selectedCharacterIndex[i];
                });
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: widget.selectedCharacterIndex[i]
                      ? Theme.of(context).colorScheme.onPrimary
                      : Colors.white,
                  border: Border.all(
                    color: widget.selectedCharacterIndex[i]
                        ? Theme.of(context).colorScheme.primary
                        : const Color(0xFFE4E7EB),
                  ),
                  borderRadius: BorderRadius.circular(36),
                ),
                child: Text(
                  widget.characterList[i],
                  style: const TextStyle(
                    fontSize: 12,
                  ),
                ),
              ),
            ),
          ),
      ]),
    );
  }
}
      // widget.characterList
      //     .map(
      //       (character) => Padding(
      //         padding: const EdgeInsets.symmetric(horizontal: 7.5),
      //         child: Container(
      //           height: 36,
      //           padding: const EdgeInsets.symmetric(horizontal: 15),
      //           alignment: Alignment.center,
      //           decoration: BoxDecoration(
      //             color: Theme.of(context).colorScheme.onPrimary,
      //             border: Border.all(
      //               color: Theme.of(context).colorScheme.primary,
      //             ),
      //             borderRadius: BorderRadius.circular(36),
      //           ),
      //           child: Text(character),
      //         ),
      //       ),
      //     )
      //     .toList(),
      // Container(
      //   height: 29,
      //   padding: const EdgeInsets.symmetric(
      //     horizontal: 15,
      //   ),
      //   decoration: BoxDecoration(
      //       color: widget.selectedCharacterIndex == index
      //           ? Theme.of(context).colorScheme.onPrimary
      //           : Colors.white,
      //       borderRadius: BorderRadius.circular(16),
      //       border: widget.selectedCharacterIndex == index
      //           ? Border.all(
      //               color: Theme.of(context).colorScheme.primary,
      //             )
      //           : Border.all(
      //               color: const Color(0xffE4E7EB),
      //             )),
      //   child: Align(
      //     alignment: Alignment.center,
      //     child: Text(
      //       widget.characterList[index],
      //       style: const TextStyle(
      //         color: Color(0xFF464D57),
      //         fontSize: 12,
      //         fontFamily: 'Pretendard',
      //         fontWeight: FontWeight.w500,
      //       ),
      //     ),
      //   ),
      // ),
