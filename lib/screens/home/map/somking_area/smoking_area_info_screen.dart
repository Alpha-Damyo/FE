import 'package:damyo/custom_icons_icons.dart';
import 'package:damyo/screens/home/map/somking_area/add_favorites/add_favorite_bottomsheet.dart';
import 'package:damyo/screens/home/map/somking_area/smoking_area_image_screen.dart';
import 'package:damyo/screens/home/map/somking_area/smoking_area_util.dart';
import 'package:damyo/services/smoking_area_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class SmokingAreaInfoScreen extends StatefulWidget {
  const SmokingAreaInfoScreen({super.key});

  @override
  State<SmokingAreaInfoScreen> createState() => _SmokingAreaInfoScreenState();
}

class _SmokingAreaInfoScreenState extends State<SmokingAreaInfoScreen> {
  @override
  Widget build(BuildContext context) {
    String data = GoRouterState.of(context).extra! as String;
    final String smokingAreaId = data.split(',')[0];
    final String smokingAreaName = data.split(',')[1];

    const double padding = 16;
    return ScreenUtilInit(
      designSize: const Size(390, 1112),
      builder: (context, child) => FutureBuilder(
        future: SmokingAreaService.getDetailModelById(smokingAreaId),
        builder: (
          BuildContext context,
          AsyncSnapshot snapshot,
        ) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Scaffold(
              appBar: AppBar(),
              body: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 20),
                    child: SizedBox(
                      width: 50,
                      height: 50,
                      child: CircularProgressIndicator(),
                    ),
                  ),
                ],
              ),
            );
          } else if (snapshot.hasError) {
            return Scaffold(appBar: AppBar(), body: const Text("에러가 발생하였습니다"));
          } else {
            String? smokingAreaImage;
            if (snapshot.data.pictureList.length > 0) {
              smokingAreaImage = snapshot.data.pictureList[0]['pictureUrl'];
            }
            List<String> photoUrlList = [];
            for (int i = 0; i < snapshot.data.pictureList.length; i++) {
              photoUrlList.add(snapshot.data.pictureList[i]['pictureUrl']);
            }
            return Scaffold(
              appBar: AppBar(
                scrolledUnderElevation: 0,
                backgroundColor: Colors.white,
                title: Text(
                  snapshot.data.name,
                ),
                centerTitle: true,
              ),
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ImageScreen(smokingAreaImage),
                          ),
                        );
                      },
                      child: snapshot.data.pictureList.isEmpty
                          ? Image.asset(
                              'assets/images/smoking_area_default_image.png',
                              fit: BoxFit.cover,
                              width: 390.w,
                              height: 266,
                            )
                          : Image.network(
                              snapshot.data.pictureList[0]['pictureUrl'],
                              fit: BoxFit.cover,
                              width: 390.w,
                              height: 266,
                            ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(padding),
                      child: Column(
                        children: [
                          Text(
                            snapshot.data.name,
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          const SizedBox(height: 5),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              SAInfoScreenStar(starValue: snapshot.data.score),
                            ],
                          ),
                          const SizedBox(height: 25),
                          Padding(
                            padding: const EdgeInsets.only(left: 30, right: 30),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SAInfoScreenBtn(
                                  context: context,
                                  icon: (Image.asset(
                                    'assets/icons/map_screen/bookmark.png',
                                    width: 30,
                                  )),
                                  name: '즐겨찾기',
                                  onPressed: () {
                                    showModalBottomSheet(
                                        context: context,
                                        builder: (context) {
                                          return AddFavoriteBottomSheet(
                                            saName: snapshot.data.name,
                                            saId: snapshot.data.id,
                                          );
                                        });
                                  },
                                ),
                                SAInfoScreenBtn(
                                  context: context,
                                  icon: const Icon(
                                    CustomIcons.share,
                                    color: Colors.white,
                                  ),
                                  name: '공유',
                                  onPressed: () {},
                                ),
                                SAInfoScreenBtn(
                                  context: context,
                                  icon: Image.asset(
                                    'assets/icons/map_screen/write_review.png',
                                    width: 30,
                                  ),
                                  name: '리뷰작성',
                                  onPressed: () {
                                    context.push('/sa_info/write_review',
                                        extra:
                                            '$smokingAreaId,$smokingAreaName');
                                  },
                                ),
                                SAInfoScreenBtn(
                                  context: context,
                                  icon: const Icon(
                                    Icons.check_box,
                                    color: Colors.white,
                                  ),
                                  name: '흡연완료',
                                  onPressed: () {
                                    // 흡연 완료 로직 처리
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SAInfoScreenGrayContainer(),
                    Padding(
                      padding: const EdgeInsets.all(padding),
                      child: Column(
                        children: [
                          const SizedBox(height: 5),
                          Row(
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(right: 10.0),
                                child: Icon(
                                  Icons.location_on_sharp,
                                  size: 25,
                                ),
                              ),
                              Text(snapshot.data.address)
                            ],
                          ),
                          const SizedBox(height: 20),
                          const Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              '특징',
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w600),
                            ),
                          ),
                          SAInfoScreenCharacteristic(
                              name: '개방', count: snapshot.data.openedCount),
                          SAInfoScreenCharacteristic(
                              name: '폐쇄', count: snapshot.data.closedCount),
                          SAInfoScreenCharacteristic(
                              name: '실내', count: snapshot.data.indoorCount),
                          SAInfoScreenCharacteristic(
                              name: '실외', count: snapshot.data.outdoorCount),
                          SAInfoScreenCharacteristic(
                              name: '흡연실이 커요', count: snapshot.data.bigCount),
                          SAInfoScreenCharacteristic(
                              name: '흡연실이 작아요',
                              count: snapshot.data.smallCount),
                          SAInfoScreenCharacteristic(
                              name: '흡연실이 한산해요',
                              count: snapshot.data.quiteCount),
                          SAInfoScreenCharacteristic(
                              name: '흡연실이 혼잡해요',
                              count: snapshot.data.crowdedCount),
                          SAInfoScreenCharacteristic(
                              name: '흡연실이 청결해요',
                              count: snapshot.data.hygieneCount),
                          SAInfoScreenCharacteristic(
                              name: '흡연실이 더러워요',
                              count: snapshot.data.dirtyCount),
                          SAInfoScreenCharacteristic(
                              name: '의자가 있어요', count: snapshot.data.chairCount),
                          SAInfoScreenCharacteristic(
                              name: '환기성이 좋아요',
                              count: snapshot.data.airOutCount),
                          SAInfoScreenCharacteristic(
                              name: '존재하지 않아요',
                              count: snapshot.data.noExistCount),
                        ],
                      ),
                    ),
                    const SAInfoScreenGrayContainer(),
                    Padding(
                      padding: const EdgeInsets.all(padding),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '사진 (${snapshot.data.pictureList.length})',
                                style: const TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.w600),
                              ),
                              const Text(
                                '전체보기 >',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xff6f767f),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          SAInfoScreenPhotos(photoUrlList: photoUrlList)
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
