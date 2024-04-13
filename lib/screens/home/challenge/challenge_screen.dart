import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:share_plus/share_plus.dart';

class Challenge {
  final String imageUrl;
  final String title;
  final String dateRange;

  Challenge(
      {required this.imageUrl, required this.title, required this.dateRange});
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

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    // Populate the challenges list
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
    return Scaffold(
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
            child: Column(
              children: [
                const Positioned(
                  left: 169,
                  top: 23,
                  child: Text(
                    '챌린지',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontFamily: 'Pretendard',
                      fontWeight: FontWeight.w700,
                      height: 0,
                    ),
                  ),
                ),
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
              ],
            ),
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
                            const SizedBox(height: 10),
                        ],
                      );
                    },
                  ),
                ),
                const SingleChildScrollView(
                  child: Column(
                    children: [
                      // Second tab "Ranking" content
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
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
              width: 358,
              height: 163,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                image: DecorationImage(
                  image: NetworkImage(challenge.imageUrl),
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 8, 10, 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${challenge.title} : ${challenge.dateRange}',
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
                    Share.share(
                        'Check out this challenge: ${challenge.title} running from ${challenge.dateRange}! Learn more at ${challenge.imageUrl}');
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
