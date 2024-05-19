import 'package:flutter/material.dart';

// Listview
class WriteReviewListview extends StatefulWidget {
  final List<String> characterList;
  List<bool> selectedCharacterIndex;
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
    return SizedBox(
      width: double.infinity,
      child: SingleChildScrollView(
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
                    if (i == 0) {
                      widget.selectedCharacterIndex[1] = false;
                    } else {
                      widget.selectedCharacterIndex[0] = false;
                    }
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
      ),
    );
  }
}

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
    return SizedBox(
      width: double.infinity,
      child: SingleChildScrollView(
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
      ),
    );
  }
}
