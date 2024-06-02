import 'package:damyo/models/stat_region_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class localInfo extends StatefulWidget {
  const localInfo({
    super.key,
    required this.GuInfo,
  });
  final statRegionModel? GuInfo;

  @override
  State<localInfo> createState() => _localInfoState();
}

class _localInfoState extends State<localInfo>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  List<dynamic>? _GuList, _areaList;

  void setRegionInfo(){
    setState(() {
      _GuList = widget.GuInfo?.allRegion;
      _areaList = widget.GuInfo?.areaTop;
    });
  }

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
    print(widget.GuInfo?.areaTop[0].runtimeType);
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
            padding: const EdgeInsets.symmetric(horizontal: 16),
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
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TabBarView(
                controller: _tabController,
                children: [
                  _tapContentsGu(),
                  _tapContentsSmokeArea(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // 가장 인기있는 흡연구역(지역)
  Widget _tapContentsGu() {
    return Column(
      children: [
        _Gu(widget.GuInfo?.allRegion[0], 0),
        _Gu(widget.GuInfo?.allRegion[1], 1),
        _Gu(widget.GuInfo?.allRegion[2], 2),
      ],
    );
  }

  // 가장 인기있는 흡연구역(흡연구역)
  Widget _tapContentsSmokeArea() {
    return Column(
      children: [
        _Gu(widget.GuInfo?.allRegion[0], 0),
        _Gu(widget.GuInfo?.allRegion[1], 1),
        _Gu(widget.GuInfo?.allRegion[2], 2),
      ],
    );
  }
}

  Widget _Gu(Map<String, dynamic> _GuInfo, int rank) {
    return Container(
      height: 50,
      child: Row(
        // mainAxisSize: MainAxisSize.min,
        // mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            '${rank + 1}등',
            style: const TextStyle(
              color: Color(0xFF0099FC),
              fontSize: 12,
              fontFamily: 'Pretendard',
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${_GuInfo.keys}',
                style: const TextStyle(
                  color: Color(0xFF10151B),
                  fontSize: 14,
                  fontFamily: 'Pretendard',
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                '${_GuInfo.values}회',
                style: const TextStyle(
                  color: Color(0xFF454D56),
                  fontSize: 12,
                  fontFamily: 'Pretendard',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  
