import 'package:damyo/screens/home/challenge/challenge_screen.dart';
import 'package:damyo/screens/home/inform/inform_screen.dart';
import 'package:damyo/screens/home/map/map_screen.dart';
import 'package:damyo/screens/home/mypage/mypage_screen.dart';
import 'package:damyo/screens/home/statistics/statistics_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final pageController = PageController();

  // 페이지 인덱스
  int _screenIndex = 0;

  // 사용될 화면들
  final List<Widget> _screens = [
    const MapScreen(),
    const StatisticsScreen(),
    // InformScreen(),
    const ChallengeScreen(),
    const MypageScreen(),
  ];

  // 화면을 이동시킬 함수
  void _onTap(int index) {
    pageController.jumpToPage(index);
  }

  // 페이지를 업데이트하는 함수
  void _onPageChanged(int index) {
    setState(() {
      _screenIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: PageView(
        controller: pageController,
        onPageChanged: _onPageChanged,
        physics: const NeverScrollableScrollPhysics(),
        children: _screens, // 슬라이딩으로 화면넘기기 X
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed, // 탭 고정
        onTap: _onTap,
        currentIndex: _screenIndex,
        items: const [
          BottomNavigationBarItem(
            label: '맵',
            icon: Icon(Icons.map_outlined),
          ),
          BottomNavigationBarItem(
            label: '통계',
            icon: Icon(Icons.bar_chart_rounded),
          ),
          // BottomNavigationBarItem(
          //   label: '제보',
          //   icon: Icon(Icons.add),
          // ),
          BottomNavigationBarItem(
            label: '챌린지',
            icon: Icon(Icons.military_tech),
          ),
          BottomNavigationBarItem(
            label: '마이페이지',
            icon: Icon(Icons.person),
          ),
        ],
      ),
    );
  }
}
