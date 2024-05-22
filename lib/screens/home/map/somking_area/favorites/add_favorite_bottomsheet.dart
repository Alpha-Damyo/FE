import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AddFavoriteBottomSheet extends StatefulWidget {
  final String saName;
  const AddFavoriteBottomSheet({super.key, required this.saName});

  @override
  State<AddFavoriteBottomSheet> createState() => _AddFavoriteBottomSheetState();
}

class _AddFavoriteBottomSheetState extends State<AddFavoriteBottomSheet> {
  FlutterSecureStorage secureStorage = const FlutterSecureStorage();
  List<String> favorites = [
    "기본",
  ];

  int selectedFavorite = 1;

  Future<void> getFavorites() async {
    String? stringFavorites = await secureStorage.read(key: 'favoritesList');
    // String stringFavorites = "즐겨찾기1,즐겨찾기2,";
    if (stringFavorites != null) {
      favorites += stringFavorites.toString().split(',');
      favorites.remove('');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
                    "국민대 도서관 ${widget.saName}",
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(height: 30),
                  Expanded(
                    child: ListView.separated(
                      shrinkWrap: true,
                      itemCount: favorites.length + 1,
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
                                  Text(
                                    index == 0
                                        ? "새 리스트 만들기"
                                        : favorites[index - 1],
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
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
                    onTap: () {},
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
              onPressed: () {
                Navigator.of(context).pop();
                // 입력된 텍스트를 사용하여 필요한 작업을 수행
              },
              child: const Text('확인'),
            ),
          ],
        );
      },
    );
  }
}
