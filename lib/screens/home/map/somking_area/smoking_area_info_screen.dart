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

class _SmokingAreaInfoScreenState extends State<SmokingAreaInfoScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    final String smokingAreaId = GoRouterState.of(context).extra! as String;
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
                  SizedBox(
                    width: 50,
                    height: 50,
                    child: CircularProgressIndicator(),
                  ),
                ],
              ),
            );
          } else if (snapshot.hasError) {
            return Scaffold(appBar: AppBar(), body: const Text("에러가 발생하였습니다"));
          } else {
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
                            builder: (context) => const ImageScreen(
                                'assets/images/smoking_area_default_image.png'),
                          ),
                        );
                      },
                      child: Image.asset(
                        'assets/images/smoking_area_default_image.png',
                        fit: BoxFit.cover,
                        width: 390.w,
                        height: 266,
                      ),
                    ),
                    // Image.network(
                    //   'https://www.sisain.co.kr/news/photo/202203/47046_84952_2317.jpg',
                    //   fit: BoxFit.cover,
                    //   width: 390.w,
                    //   height: 266,
                    // ),
                    Padding(
                      padding: const EdgeInsets.all(padding),
                      child: Column(
                        children: [
                          Text(
                            snapshot.data.name,
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          const SizedBox(height: 5),
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SAInfoScreenStar(starValue: 4),
                              SizedBox(width: 10),
                              Text(
                                '(17건)',
                                style: TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                          const SizedBox(height: 25),
                          Padding(
                            padding: EdgeInsets.only(left: 60.w, right: 60.w),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SAInfoScreenBtn(
                                  context: context,
                                  icon: Icons.star,
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
                                  icon: Icons.ios_share,
                                  name: '공유',
                                  onPressed: () {},
                                ),
                                SAInfoScreenBtn(
                                  context: context,
                                  icon: Icons.rate_review_rounded,
                                  name: '리뷰작성',
                                  onPressed: () {
                                    context.push('/sa_info/write_review',
                                        extra: '국민대 도서관 $smokingAreaId');
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SAInfoScreenGrayContainer(),
                    const Padding(
                      padding: EdgeInsets.all(padding),
                      child: Column(
                        children: [
                          SizedBox(height: 5),
                          Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(right: 10.0),
                                child: Icon(
                                  Icons.location_on_sharp,
                                  size: 25,
                                ),
                              ),
                              Text("서울특별시 성북구 정릉로 77")
                            ],
                          ),
                          SizedBox(height: 20),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              '특징',
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w600),
                            ),
                          ),
                          SAInfoScreenCharacteristic(name: '개방', count: 16),
                          SAInfoScreenCharacteristic(name: '실내', count: 8),
                          SAInfoScreenCharacteristic(name: '큼', count: 6),
                          SAInfoScreenCharacteristic(name: '혼잡함', count: 4),
                          SAInfoScreenCharacteristic(name: '청결함', count: 3),
                          SAInfoScreenCharacteristic(name: '의자가 있음', count: 1),
                        ],
                      ),
                    ),
                    const SAInfoScreenGrayContainer(),
                    Padding(
                      padding: const EdgeInsets.all(padding),
                      child: Column(
                        children: [
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '사진 (6)',
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.w600),
                              ),
                              Text(
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
