import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class localInfo extends StatefulWidget {
  const localInfo({
    super.key,
  });

  @override
  State<localInfo> createState() => _localInfoState();
}

class _localInfoState extends State<localInfo>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  // 지역 정보 위젯
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  child: Text(
                    '가장 인기있는 흡연구역',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontFamily: 'Pretendard',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: TabBar(
              controller: _tabController,
              indicatorSize: TabBarIndicatorSize.tab,
              indicatorColor: Colors.black,
              tabs: const [
                Tab(text: '지역'),
                Tab(text: '흡연구역'),
              ],
              labelColor: Colors.black,
              unselectedLabelColor: Colors.grey,
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: TabBarView(
                controller: _tabController,
                children: [
                  _tapContents(),
                  const Center(child: Text('탭 2의 콘텐츠')),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // 가장 인기있는 흡연구역(지역)
  Widget _tapContents() {
    return Column(
      children: [
        Container(
          height: 50,
          decoration: BoxDecoration(
            border: Border.all(
              width: 1.0,
            ),
          ),
          child: const Row(
            // mainAxisSize: MainAxisSize.min,
            // mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                '1등',
                style: TextStyle(
                  color: Color(0xFF0099FC),
                  fontSize: 12,
                  fontFamily: 'Pretendard',
                  fontWeight: FontWeight.w500,
                  height: 0,
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '광진구',
                    style: TextStyle(
                      color: Color(0xFF10151B),
                      fontSize: 14,
                      fontFamily: 'Pretendard',
                      fontWeight: FontWeight.w600,
                      height: 0,
                    ),
                  ),
                  Text(
                    '23,948 회',
                    style: TextStyle(
                      color: Color(0xFF454D56),
                      fontSize: 12,
                      fontFamily: 'Pretendard',
                      fontWeight: FontWeight.w400,
                      height: 0,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
