import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AddFavoriteBottomSheet extends StatefulWidget {
  final String saId;
  final String saName;
  const AddFavoriteBottomSheet(
      {super.key, required this.saName, required this.saId});

  @override
  State<AddFavoriteBottomSheet> createState() => _AddFavoriteBottomSheetState();
}

class _AddFavoriteBottomSheetState extends State<AddFavoriteBottomSheet> {
  FlutterSecureStorage secureStorage = const FlutterSecureStorage();
  List<String> favorites = [
    "새 리스트 만들기",
    "기본",
  ];
  List<int> favoritesSize = [
    0,
    0,
  ];

  int selectedFavorite = 1;

  Future<void> getFavorites() async {
    String? stringFavorites = await secureStorage.read(key: 'favoritesList');
    if (stringFavorites != null) {
      favorites += stringFavorites.toString().split(',');
      favorites.remove('');
      for (int i = 0; i < favorites.length; i++) {
        favoritesSize.add(0);
      }
    }
    for (int i = 0; i < favorites.length; i++) {
      String target = favorites[i];
      String? targetString =
          await secureStorage.read(key: 'favoritesList.id.$target');

      if (targetString != null) {
        List<String> targetList = targetString.toString().split(',');
        targetList.remove('');

        favoritesSize[i] += targetList.length;
      }
    }
    setState(() {});
  }

  Future<void> remove() async {
    await secureStorage.deleteAll();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // remove();
    getFavorites();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 667),
      builder: (context, child) => SizedBox(
        width: double.infinity,
        height: 300.h,
        child: Material(
            color: Colors.white,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Text(
                    widget.saName,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(height: 30),
                  Expanded(
                    child: ListView.separated(
                      shrinkWrap: true,
                      itemCount: favorites.length,
                      itemBuilder: (BuildContext context, int index) {
                        return InkWell(
                          onTap: () {
                            // 새 리스트 만들기
                            if (index == 0) {
                              _showInputDialog();
                            }
                            // 이외의 경우 변경
                            else {
                              setState(() {
                                selectedFavorite = index;
                              });
                            }
                          },
                          child: SizedBox(
                            width: double.infinity,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 4),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Text('${favorites[index]} '),
                                      index > 0
                                          ? Text(
                                              favoritesSize[index].toString(),
                                              style: const TextStyle(
                                                  color: Color(0xFF6F767F),
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w400),
                                            )
                                          : const Text(''),
                                    ],
                                  ),
                                  Icon(
                                    index == 0
                                        ? Icons.add_circle_outline
                                        : Icons.check_circle_outline,
                                    color: index == 0
                                        ? const Color(0xffe4e7eB)
                                        : selectedFavorite == index
                                            ? Theme.of(context)
                                                .colorScheme
                                                .primary
                                            : const Color(0xffe4e7eB),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) =>
                          const Divider(
                        color: Color(0xffe4e7eB),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  InkWell(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(16.0),
                    ),
                    onTap: () async {
                      String? tmpIdInfo = await secureStorage.read(
                          key:
                              'favoritesList.id.${favorites[selectedFavorite]}');
                      String? tmpNameInfo = await secureStorage.read(
                          key:
                              'favoritesList.name.${favorites[selectedFavorite]}');
                      if (tmpIdInfo != null) {
                        List<String> tmpList = tmpIdInfo.toString().split(',');

                        tmpList.remove('');

                        if (tmpList.contains(widget.saId)) {
                          Fluttertoast.showToast(msg: "이미 추가되어있습니다");
                        } else {
                          await secureStorage.write(
                              key:
                                  'favoritesList.id.${favorites[selectedFavorite]}',
                              value: '$tmpIdInfo,${widget.saId}');
                          await secureStorage.write(
                              key:
                                  'favoritesList.name.${favorites[selectedFavorite]}',
                              value: '$tmpNameInfo,${widget.saName}');
                          Fluttertoast.showToast(msg: "추가가 완료되었습니다");

                          setState(() {
                            Navigator.of(context).pop();
                          });
                        }
                      } else {
                        await secureStorage.write(
                            key:
                                'favoritesList.id.${favorites[selectedFavorite]}',
                            value: widget.saId);
                        await secureStorage.write(
                            key:
                                'favoritesList.name.${favorites[selectedFavorite]}',
                            value: widget.saName);
                        Fluttertoast.showToast(msg: "추가가 완료되었습니다");
                        setState(() {
                          Navigator.of(context).pop();
                        });
                      }
                    },
                    child: Ink(
                      width: double.infinity,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(16)),
                      ),
                      child: const Align(
                        alignment: Alignment.center,
                        child: Text(
                          '즐겨찾기 추가',
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
            )),
      ),
    );
  }

  String _enteredText = '';

  void _showInputDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('이름을 입력하세요'),
          content: TextField(
            onChanged: (value) {
              setState(() {
                _enteredText = value;
              });
            },
            decoration: const InputDecoration(hintText: '이름'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('취소'),
            ),
            TextButton(
              onPressed: () async {
                // String stringFavorites = "즐겨찾기1,즐겨찾기2,";
                String? tmpFavoritesList =
                    await secureStorage.read(key: 'favoritesList');
                tmpFavoritesList ??= '';
                await secureStorage.write(
                    key: 'favoritesList',
                    value: '$tmpFavoritesList,$_enteredText');

                setState(() {
                  favorites.add(_enteredText);
                  favoritesSize.add(0);
                });
                Navigator.of(context).pop();
              },
              child: const Text('확인'),
            ),
          ],
        );
      },
    );
  }
}
