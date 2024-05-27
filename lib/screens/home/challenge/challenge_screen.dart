import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:share_plus/share_plus.dart';

class Challenge {
  final String imageUrl;
  final String title;
  final String dateRange;

  Challenge(
      {required this.imageUrl, required this.title, required this.dateRange});
}

class Rank {
  final String name;
  final String imageUrl;
  final int likeCount;
  final int rank;

  Rank(
      {required this.name,
      required this.imageUrl,
      required this.likeCount,
      required this.rank});
}

class ChallengeScreen extends StatefulWidget {
  const ChallengeScreen({super.key});

  @override
  State<ChallengeScreen> createState() => _ChallengeScreenState();
}

class _ChallengeScreenState extends State<ChallengeScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;
  List<Challenge> challenges = [];
  List<Rank> ranks = List.generate(
    12,
    (index) => Rank(
      name: 'User ${index + 1}',
      imageUrl: "https://via.placeholder.com/52x52",
      likeCount: 1000 - index * 100,
      rank: index + 1,
    ),
  );

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    challenges = [
      Challenge(
          imageUrl: "https://via.placeholder.com/358x163",
          title: '사진 콘테스트1',
          dateRange: '2024.1.1 ~ 2024.6.30'),
      Challenge(
          imageUrl: "https://via.placeholder.com/358x163",
          title: '사진 콘테스트2',
          dateRange: '2024.7.1 ~ 2024.12.31'),
      // Add more challenges as needed
    ];
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 667),
      builder: (context, child) => Scaffold(
        appBar: AppBar(
          scrolledUnderElevation: 0,
          backgroundColor: Colors.white,
          title: Text(
            '챌린지',
            style: TextStyle(
              color: Colors.black,
              fontSize: 20.sp,
              fontFamily: 'Pretendard',
              fontWeight: FontWeight.w700,
              height: 0,
            ),
          ),
          centerTitle: true,
        ),
        body: Column(
          children: [
            TabBar(
              labelColor: Colors.black,
              indicatorColor: Colors.black,
              indicatorWeight: 3,
              indicatorSize: TabBarIndicatorSize.tab,
              unselectedLabelColor: const Color(0xFF6E767F),
              overlayColor: MaterialStateProperty.all(Colors.transparent),
              controller: _tabController,
              tabs: const [
                Tab(text: '챌린지'),
                Tab(text: '랭킹'),
              ],
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  SingleChildScrollView(
                    child: ListView.builder(
                      shrinkWrap: true,
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      itemCount: challenges.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            challengeWidget(challenges[index]),
                            if (index < challenges.length - 1)
                              SizedBox(height: 10.h),
                          ],
                        );
                      },
                    ),
                  ),
                  SingleChildScrollView(
                    child: Column(
                      children: [
                        rankingWidget(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget challengeWidget(Challenge challenge) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              // Navigate to the challenge detail screen
              GoRouter.of(context)
                  .push('/details', extra: {'title': challenge.title});
            },
            child: Container(
              width: 358.w,
              height: 163.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.r),
                image: DecorationImage(
                  image: NetworkImage(challenge.imageUrl),
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(10.w, 8.h, 10.w, 8.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${challenge.title} : ${challenge.dateRange}',
                  style: TextStyle(
                    color: const Color(0xFF262B32),
                    fontSize: 14.sp,
                    fontFamily: 'Pretendard',
                    fontWeight: FontWeight.w500,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.share),
                  onPressed: () {
                    Share.share(challenge.imageUrl);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget rankingWidget() {
    return ScreenUtilInit(
      designSize: const Size(390, 769),
      builder: (context, child) => Container(
        width: 390.w,
        height: 769.h,
        padding: EdgeInsets.only(
          top: 20.h,
        ),
        clipBehavior: Clip.antiAlias,
        decoration: const BoxDecoration(color: Colors.white),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 370.w,
              height: 748.h,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 78.w,
                            height: 90.h,
                            child: Stack(
                              children: [
                                Positioned(
                                  left: 0.w,
                                  top: 12.h,
                                  child: Container(
                                    width: 78.w,
                                    height: 78.h,
                                    clipBehavior: Clip.antiAlias,
                                    decoration: ShapeDecoration(
                                      color: const Color(0xFFDEDEDE),
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(39.r),
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          width: 78.w,
                                          height: 78.h,
                                          decoration: const BoxDecoration(
                                            image: DecorationImage(
                                              image: NetworkImage(
                                                  "https://via.placeholder.com/78x78"),
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Positioned(
                                  left: 27.w,
                                  top: 0.h,
                                  child: SizedBox(
                                    width: 24.w,
                                    height: 24.h,
                                    child: Stack(
                                      children: [
                                        Container(
                                          width: 24.w,
                                          height: 24.h,
                                          decoration: const ShapeDecoration(
                                            color: Color(0xFF262B32),
                                            shape: OvalBorder(),
                                          ),
                                          child: Center(
                                            child: Text(
                                              '2',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 16.sp,
                                                fontFamily:
                                                    'AppleSDGothicNeoEB00',
                                                fontWeight: FontWeight.w400,
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 8.h),
                          Text(
                            ranks[1].name,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16.sp,
                              fontFamily: 'Pretendard',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: 8.h),
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10.w, vertical: 5.h),
                            clipBehavior: Clip.antiAlias,
                            decoration: ShapeDecoration(
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                    width: 1.w, color: const Color(0xFFF5F5F5)),
                                borderRadius: BorderRadius.circular(5.r),
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  '좋아요 ${ranks[1].likeCount}개',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 12.sp,
                                    fontFamily: 'Pretendard',
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(width: 26.w),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 100.w,
                            height: 116.h,
                            child: Stack(
                              children: [
                                Positioned(
                                  left: 0.w,
                                  top: 16.h,
                                  child: Container(
                                    width: 100.w,
                                    height: 100.h,
                                    clipBehavior: Clip.antiAlias,
                                    decoration: ShapeDecoration(
                                      color: const Color(0xFFDEDEDE),
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(50.r),
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          width: 100.w,
                                          height: 100.h,
                                          decoration: const BoxDecoration(
                                            image: DecorationImage(
                                              image: NetworkImage(
                                                  "https://via.placeholder.com/100x100"),
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Positioned(
                                  left: 34.w,
                                  top: 0.h,
                                  child: SizedBox(
                                    width: 32.w,
                                    height: 32.h,
                                    child: Stack(
                                      children: [
                                        Container(
                                          width: 32.w,
                                          height: 32.h,
                                          decoration: const ShapeDecoration(
                                            color: Color(0xFF262B32),
                                            shape: OvalBorder(),
                                          ),
                                          child: Center(
                                            child: Text(
                                              '1',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 20.sp,
                                                fontFamily:
                                                    'AppleSDGothicNeoEB00',
                                                fontWeight: FontWeight.w400,
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 8.h),
                          Text(
                            ranks[0].name,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16.sp,
                              fontFamily: 'Pretendard',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: 8.h),
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10.w, vertical: 5.h),
                            clipBehavior: Clip.antiAlias,
                            decoration: ShapeDecoration(
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                    width: 1.w, color: const Color(0xFFF5F5F5)),
                                borderRadius: BorderRadius.circular(5.r),
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  '좋아요 ${ranks[0].likeCount}개',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 12.sp,
                                    fontFamily: 'Pretendard',
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(width: 26.w),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 78.w,
                            height: 90.h,
                            child: Stack(
                              children: [
                                Positioned(
                                  left: 0.w,
                                  top: 12.h,
                                  child: Container(
                                    width: 78.w,
                                    height: 78.h,
                                    clipBehavior: Clip.antiAlias,
                                    decoration: ShapeDecoration(
                                      color: const Color(0xFFDEDEDE),
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(39.r),
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          width: 78.w,
                                          height: 78.h,
                                          decoration: const BoxDecoration(
                                            image: DecorationImage(
                                              image: NetworkImage(
                                                  "https://via.placeholder.com/78x78"),
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Positioned(
                                  left: 27.w,
                                  top: 0.h,
                                  child: SizedBox(
                                    width: 24.w,
                                    height: 24.h,
                                    child: Stack(
                                      children: [
                                        Container(
                                          width: 24.w,
                                          height: 24.h,
                                          decoration: const ShapeDecoration(
                                            color: Color(0xFF262B32),
                                            shape: OvalBorder(),
                                          ),
                                          child: Center(
                                            child: Text(
                                              '3',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 16.sp,
                                                fontFamily:
                                                    'AppleSDGothicNeoEB00',
                                                fontWeight: FontWeight.w400,
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 8.h),
                          Text(
                            ranks[2].name,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16.sp,
                              fontFamily: 'Pretendard',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: 8.h),
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10.w, vertical: 5.h),
                            clipBehavior: Clip.antiAlias,
                            decoration: ShapeDecoration(
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                    width: 1.w, color: const Color(0xFFF5F5F5)),
                                borderRadius: BorderRadius.circular(5.r),
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  '좋아요 ${ranks[2].likeCount}개',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 12.sp,
                                    fontFamily: 'Pretendard',
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 10.h),
                  Expanded(
                    child: ListView.builder(
                      itemCount: ranks.length - 3,
                      itemBuilder: (context, index) {
                        return _buildRankList(ranks[index + 3], index + 3);
                      },
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRankList(Rank rank, int index) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 390.w,
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 15.h),
          decoration: ShapeDecoration(
            color: index == 3 ? const Color(0xFFF7F8FA) : Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.r),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 52.w,
                    clipBehavior: Clip.antiAlias,
                    decoration: ShapeDecoration(
                      color: const Color(0xFFD1D6DC),
                      shape: CircleBorder(),
                      // RoundedRectangleBorder(
                      //   borderRadius: BorderRadius.circular(39.r),
                      // ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: 52.w,
                          height: 52.h,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(rank.imageUrl),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        rank.name,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16.sp,
                          fontFamily: 'Pretendard',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 3.h),
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 10.w, vertical: 5.h),
                        clipBehavior: Clip.antiAlias,
                        decoration: ShapeDecoration(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                                width: 1.w, color: const Color(0xFFEEF1F4)),
                            borderRadius: BorderRadius.circular(5.r),
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              '좋아요 ${rank.likeCount}개',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 12.sp,
                                fontFamily: 'Pretendard',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const Spacer(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 5.h),
                clipBehavior: Clip.antiAlias,
                decoration: ShapeDecoration(
                  color: const Color(0xFF454D56),
                  shape: RoundedRectangleBorder(
                    side:
                        BorderSide(width: 1.w, color: const Color(0xFFEEF1F4)),
                    borderRadius: BorderRadius.circular(15.r),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      '${rank.rank}등',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12.sp,
                        fontFamily: 'Pretendard',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 6.h),
      ],
    );
  }
}
