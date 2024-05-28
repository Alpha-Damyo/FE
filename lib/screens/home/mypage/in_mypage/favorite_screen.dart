import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  FlutterSecureStorage secureStorage = const FlutterSecureStorage();
  List<String> favorites = [
    "기본",
  ];
  List<List<List<dynamic>>> favoritesDetail = [];

  Future<void> getFavorites() async {
    String? stringFavorites = await secureStorage.read(key: 'favoritesList');
    if (stringFavorites != null) {
      favorites += stringFavorites.toString().split(',');
      favorites.remove('');
    }
    for (int i = 0; i < favorites.length; i++) {
      String target = favorites[i];
      String? targetIdString =
          await secureStorage.read(key: 'favoritesList.id.$target');

      if (targetIdString != null) {
        List<String> targetIdList = targetIdString.toString().split(',');
        targetIdList.remove('');
        String? targetNameString =
            await secureStorage.read(key: 'favoritesList.name.$target');
        List<String> targetNameList = targetNameString.toString().split(',');

        List<List<dynamic>> tmpList = [];

        for (int j = 0; j < targetIdList.length; j++) {
          tmpList.add([targetIdList[j], targetNameList[j]]);
        }
        favoritesDetail.add(tmpList);
      } else {
        favoritesDetail.add([]);
      }
    }
  }

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
        body: FutureBuilder(
            future: getFavorites(),
            builder: (
              BuildContext context,
              AsyncSnapshot snapshot,
            ) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return const Text("Error");
              } else {
                // print(favorites);
                // print(favoritesDetail);
                // print(favoritesDetail[0]);
                // print(favoritesDetail[0][0]);
                // print(favoritesDetail[0][0][1]);
                return SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        for (int i = 0; i < favorites.length; i++)
                          _buildExpansionTile(index: i),
                      ],
                    ),
                  ),
                );
              }
            }));
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
                  title: Row(
                    children: [
                      Text(
                        favorites[index],
                        style: const TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 16),
                      ),
                      Text(
                        ' ${favoritesDetail[index].length}',
                        style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                            color: Color(0xFF6F767F)),
                      )
                    ],
                  ),
                  children: [
                    for (int j = 0; j < favoritesDetail[index].length; j++)
                      if (favoritesDetail[index][j][1] != null)
                        Text(favoritesDetail[index][j][1])
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
}
