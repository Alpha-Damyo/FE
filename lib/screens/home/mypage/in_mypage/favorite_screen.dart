import 'package:damyo/main.dart';
import 'package:damyo/screens/home/home_screen.dart';
import 'package:damyo/screens/home/map/map_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  FlutterSecureStorage secureStorage = const FlutterSecureStorage();
  bool removeGroup = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFFF7F8FA),
        appBar: AppBar(
          scrolledUnderElevation: 0,
          title: const Text(
            '즐겨찾기',
          ),
          centerTitle: true,
        ),
        body: Column(
          children: [
            Container(
              alignment: Alignment.centerRight,
              color: Colors.white,
              child: InkWell(
                onTap: () {
                  setState(() {
                    removeGroup = !removeGroup;
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.only(right: 16.0, bottom: 16),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(
                          color: const Color(0xFFEEF1F5),
                        )),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: const Text(
                      "삭제",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    for (int i = 0; i < favorites.length; i++)
                      _buildExpansionTile(index: i),
                  ],
                ),
              ),
            ),
          ],
        ));
  }

  Widget _buildExpansionTile({required int index}) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16.0),
            child: Material(
              type: MaterialType.transparency,
              child: Theme(
                data: ThemeData(),
                child: ExpansionTile(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  trailing: removeGroup
                      ? GestureDetector(
                          onTap: () {
                            _showDeleteGroupDialog(index);
                          },
                          child: Container(
                            padding: const EdgeInsets.all(5),
                            child: const Text(
                              "삭제",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFFBC6065),
                                  fontSize: 16),
                            ),
                          ),
                        )
                      : null,
                  title: Row(
                    children: [
                      Text(
                        favorites[index],
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        ' ${favoritesDetail[index].length}',
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                          color: Color(0xFF6F767F),
                        ),
                      )
                    ],
                  ),
                  children: [
                    for (int j = 0; j < favoritesDetail[index].length; j++)
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 10.0,
                          bottom: 10,
                          left: 15,
                          right: 15,
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    context.go('/');
                                    screenIndex = 0;
                                    homePageController.jumpToPage(0);
                                    moveCameraById(
                                      favoritesDetail[index][j][0],
                                    );
                                  });
                                },
                                child: Text(favoritesDetail[index][j][1]),
                              ),
                            ),
                            IconButton(
                              icon: const Icon(
                                Icons.star,
                                color: Color(0xFFFFC226),
                              ),
                              onPressed: () {
                                _showDeleteFavoriteDialog(index, j);
                              },
                            ),
                          ],
                        ),
                      )
                  ],
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  void _showDeleteGroupDialog(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            "정말 삭제하시겠습니까?",
            style: TextStyle(fontSize: 16),
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
                if (favorites[index] == "기본") {
                  Fluttertoast.showToast(msg: "기본 그룹은 삭제할 수 없습니다");
                } else {
                  await secureStorage.delete(
                      key: 'favoritesList.id.${favorites[index]}');
                  await secureStorage.delete(
                      key: 'favoritesList.name.${favorites[index]}');
                  favorites.removeAt(index);
                  favoritesDetail.removeAt(index);

                  String tmpFavorites = '';
                  for (int i = 1; i < favorites.length; i++) {
                    tmpFavorites += '${favorites[i]},';
                  }
                  await secureStorage.write(
                      key: 'favoritesList', value: tmpFavorites);
                  setState(() {});
                }
                Navigator.of(context).pop();
              },
              child: const Text('확인'),
            ),
          ],
        );
      },
    );
  }

  void _showDeleteFavoriteDialog(int index1, int index2) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            "정말 삭제하시겠습니까?",
            style: TextStyle(fontSize: 16),
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
                favoritesDetail[index1].removeAt(index2);

                String tmpId = '';
                String tmpName = '';
                for (int i = 0; i < favoritesDetail[index1].length; i++) {
                  tmpId += favoritesDetail[index1][i][0] + ',';
                  tmpName += favoritesDetail[index1][i][1] + ',';
                }
                await secureStorage.write(
                    key: 'favoritesList.id.${favorites[index1]}', value: tmpId);
                await secureStorage.write(
                    key: 'favoritesList.name${favorites[index1]}',
                    value: tmpName);
                Navigator.of(context).pop();
                setState(() {});
              },
              child: const Text('확인'),
            ),
          ],
        );
      },
    );
  }
}
