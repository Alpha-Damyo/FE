import 'package:damyo/screens/home/map/somking_area/smoking_area_util.dart';
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
    final String smokingAreaId = GoRouterState.of(context).extra! as String;
    return ScreenUtilInit(
      designSize: const Size(390, 1112),
      builder: (context, child) => Scaffold(
        appBar: AppBar(
          scrolledUnderElevation: 0,
          backgroundColor: Colors.white,
          title: Text(
            '국민대 도서관 $smokingAreaId',
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Image.network(
                'https://s3-alpha-sig.figma.com/img/cad7/c4fe/43ae8f3f6705d2bc870f650c659320c5?Expires=1712534400&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=i13Cyw-~-yI90u-3GGTbYHp5rwBDj9mKw8OEvCOdljMPzi1ReeXyJ0Xtres~o0Fw-5eb~2N0OCRBRYSf3-lbK3x7BDcV3CPavm~al5FuVroVm~WaGljbmdA2qAGcBY3YCvfHGKQ99NXzTxGtf1gvAoCQi0f2IDi-oDs-YfzpCe67w2Rvm2UxuLPd45kYShyB86AoJughj8oyX9RMntlS9b9q-jeP5J70vOlR8wx6t3C~poSb2w8vkKkNZGYlge9vtSKjedSb7rChtFfFa1D1tkueR1zZKM4uNkHEL91IILguXsOU0AVpBsufW2a6NO3qJQg-XN-Z890cUBy18a9ppQ__',
                fit: BoxFit.cover,
                width: 390.w,
                height: 266,
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Text(
                      '국민대 도서관 $smokingAreaId',
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
                          ),
                          SAInfoScreenBtn(
                            context: context,
                            icon: Icons.ios_share,
                            name: '공유',
                          ),
                          SAInfoScreenBtn(
                              context: context,
                              icon: Icons.rate_review_rounded,
                              name: '리뷰작성'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SAInfoScreenGrayContainer(),
              const Padding(
                padding: EdgeInsets.all(20.0),
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
                padding: const EdgeInsets.all(20.0),
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
      ),
    );
  }
}
