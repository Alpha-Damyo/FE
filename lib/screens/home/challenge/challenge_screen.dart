import 'package:damyo/models/challenge_model.dart';
import 'package:damyo/models/challenge_rank_model.dart';
import 'package:damyo/services/contest_ranking_service.dart';
import 'package:damyo/services/get_challenge_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:share_plus/share_plus.dart';

class ChallengeScreen extends StatefulWidget {
  const ChallengeScreen({super.key});

  @override
  State<ChallengeScreen> createState() => _ChallengeScreenState();
}

class _ChallengeScreenState extends State<ChallengeScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;
  List<Challenge> challenges = [];
  List<User> topRanks = [];
  List<User> nearRanks = [];
  bool isLoading = true;
  String? errorMessage;
  String token =
      "eyJhbGciOiJIUzUxMiJ9.eyJlbWFpbCI6IndhaXRpbmdAZ21haWwuY29tIiwiaWF0IjoxNzE3NzY2OTY0LCJleHAiOjE3MTc4NTMzNjR9.8BUz8YlHjXzMRt8BpqrVgJ2i7gcucEUfwThgRJ-4O8olbSRXJa8Xv-tlG1H7r-J_uLlNDlOXLGTIKnfOKfMwoQ";

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _challengeTest();
    fetchRanking();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _challengeTest() async {
    try {
      challenges = await getCurrentChallenge(token);
    } catch (e) {
      setState(() {
        errorMessage = e.toString();
      });
    }
    print(challenges);
  }

  Future<void> fetchRanking() async {
    try {
      RankResponse response = await contestRanking(token);
      setState(() {
        topRanks = response.topRankResponse;
        nearRanks = response.nearRankResponse;
      });
    } catch (e) {
      setState(() {
        errorMessage = e.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 667),
      builder: (context, child) => Scaffold(
        appBar: AppBar(
          scrolledUnderElevation: 0,
          backgroundColor: Colors.white,
          title: const Text(
            '챌린지',
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
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
              overlayColor: WidgetStateProperty.all(Colors.transparent),
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
    final DateFormat dateFormat = DateFormat('yyyy-MM-dd');

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              // Navigate to the challenge detail screen
              GoRouter.of(context)
                  .push('/details', extra: {'title': challenge.name});
            },
            child: Container(
              width: 358.w,
              height: 163.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.r),
                image: DecorationImage(
                  image: NetworkImage(challenge.bannerImgUrl),
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
                  '${challenge.name} : ${dateFormat.format(challenge.startTime)} ~ ${dateFormat.format(challenge.endTime)}',
                  style: const TextStyle(
                    color: Color(0xFF262B32),
                    fontSize: 14,
                    fontFamily: 'Pretendard',
                    fontWeight: FontWeight.w500,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.share),
                  onPressed: () {
                    Share.share(challenge.detailImgUrl);
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
        padding: EdgeInsets.only(top: 20.h),
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
                      _buildTopRankUser(1),
                      SizedBox(width: 26.w),
                      _buildTopRankUser(0),
                      SizedBox(width: 26.w),
                      _buildTopRankUser(2),
                    ],
                  ),
                  SizedBox(height: 10.h),
                  Expanded(
                    child: ListView.builder(
                      itemCount: nearRanks.length,
                      itemBuilder: (context, index) {
                        return _buildRankList(nearRanks[index], index);
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

  Widget _buildTopRankUser(int index) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: index == 0 ? 100.w : 78.w,
          height: index == 0 ? 116.h : 90.h,
          child: Stack(
            children: [
              Positioned(
                left: 0.w,
                top: index == 0 ? 16.h : 12.h,
                child: Container(
                  width: index == 0 ? 100.w : 78.w,
                  height: index == 0 ? 100.h : 78.h,
                  clipBehavior: Clip.antiAlias,
                  decoration: const ShapeDecoration(
                    color: Color(0xFFDEDEDE),
                    shape: CircleBorder(),
                  ),
                  child: topRanks[index].profileUrl != null
                      ? Image.network(topRanks[index].profileUrl!,
                          errorBuilder: (context, error, stackTrace) {
                          return Image.asset(
                              'assets/images/smoking_area_default_image.png');
                        }, fit: BoxFit.fill)
                      : Image.asset(
                          'assets/images/smoking_area_default_image.png'),
                ),
              ),
              Positioned(
                left: index == 0 ? 34.w : 27.w,
                top: 0.h,
                child: SizedBox(
                  width: index == 0 ? 32.w : 24.w,
                  height: index == 0 ? 32.h : 24.h,
                  child: Container(
                    decoration: const ShapeDecoration(
                      color: Color(0xFF262B32),
                      shape: CircleBorder(),
                    ),
                    child: Center(
                      child: Text(
                        (index + 1).toString(),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: index == 0 ? 20 : 16,
                          fontFamily: 'AppleSDGothicNeoEB00',
                          fontWeight: FontWeight.w400,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 8.h),
        Text(
          topRanks[index].name,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontFamily: 'Pretendard',
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 8.h),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
          clipBehavior: Clip.antiAlias,
          decoration: ShapeDecoration(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              side: BorderSide(width: 1.w, color: const Color(0xFFF5F5F5)),
              borderRadius: BorderRadius.circular(5.r),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                '좋아요 ${topRanks[index].likeCount ?? 0}개',
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 12,
                  fontFamily: 'Pretendard',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildRankList(User rank, int index) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 390.w,
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 15.h),
          decoration: ShapeDecoration(
            color: index == 0 ? const Color(0xFFF7F8FA) : Colors.white,
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
                    decoration: const ShapeDecoration(
                      color: Color(0xFFD1D6DC),
                      shape: CircleBorder(),
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
                              image: NetworkImage(
                                rank.profileUrl ?? '',
                                headers: const {
                                  "User-Agent":
                                      "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/110.0.0.0 Safari/537.36",
                                },
                              ),
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
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 16,
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
                              '좋아요 ${rank.likeCount ?? 0}개',
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 12,
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
                      '${rank.ranking}등',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
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
