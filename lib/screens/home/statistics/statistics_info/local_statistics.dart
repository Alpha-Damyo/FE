import 'dart:async';
import 'dart:io';

import 'package:damyo/models/statistics/stat_region_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:damyo/services/smoking_area_service.dart';
import 'package:damyo/models/smoking_area/sa_detail_model.dart';
import 'package:go_router/go_router.dart';
import 'package:path/path.dart';

class localInfo extends StatefulWidget {
  const localInfo({
    super.key,
    required this.RegionInfo,
  });
  final statRegionModel? RegionInfo;

  @override
  State<localInfo> createState() => _localInfoState();
}

class _localInfoState extends State<localInfo>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  List<dynamic>? _GuList, _areaList;
  List<SaDetailModel>? _SaList;
  bool _isLoading = true;

  void setRegionInfo() {
    setState(() {
      _GuList = widget.RegionInfo?.allRegion;
      _areaList = widget.RegionInfo?.areaTop;
      getSaModle(_areaList);
    });
  }

  Future<void> getSaModle(List<dynamic>? areaList) async {
    List<SaDetailModel> area = [];
    if (areaList != null) {
      for (int i = 0; i < areaList.length; i++) {
        SaDetailModel popArea =
            await SmokingAreaService.getDetailModelById(areaList[i].keys.first);
        area.add(popArea);
      }
    }
    setState(() {
      _SaList = area;
    });
  }

  Future<void> _loadData(int term) async {
    Timer(Duration(milliseconds: term), () {
      setState(() {
        _isLoading = false;
      });
    });
  }

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    setRegionInfo();
    _loadData(500);
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
    return Container(
      child: _isLoading
          ? const Align(
              alignment: Alignment.center,
              child: SizedBox(
                width: 50.0, // 원하는 너비
                height: 50.0, // 원하는 높이
                child: CircularProgressIndicator(),
              ),
            )
          : Column(
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
                        _tapContentsSmokeArea(context),
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
    if (_GuList == null || _GuList!.isEmpty) {
      return const Center(child: Text('No Data Available'));
    }
    return Column(
        children: List.generate(
      _GuList!.length,
      (index) {
        return _Gu(_GuList?[index], index);
      },
    ));
  }

  // 가장 인기있는 흡연구역(흡연구역)
  Widget _tapContentsSmokeArea(BuildContext context) {
    if (_areaList == null || _areaList!.isEmpty) {
      return const Center(child: Text('No Data Available'));
    }
    return Column(
        children: List.generate(
      _GuList!.length,
      (index) {
        return _Sa(_areaList?[index], _SaList![index], index, context);
      },
    ));
  }
}

Widget _Gu(Map<String, dynamic> GuInfo, int rank) {
  String key = GuInfo.keys.first;
  dynamic value = GuInfo[key];
  return SizedBox(
    height: 55,
    child: Row(
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
              key,
              style: const TextStyle(
                color: Color(0xFF10151B),
                fontSize: 14,
                fontFamily: 'Pretendard',
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              '$value회',
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

Widget _Sa(Map<String, dynamic> SaInfo, SaDetailModel SaModel, int rank,
    BuildContext context) {
  String key = SaInfo.keys.first;
  dynamic value = SaInfo[key];
  return Ink(
    height: 55,
    child: InkWell(
      onTap: () {
        context.push('/sa_info', extra: '${SaModel.id},${SaModel.name}');
      },
      child: Row(
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
                SaModel.name,
                style: const TextStyle(
                  color: Color(0xFF10151B),
                  fontSize: 14,
                  fontFamily: 'Pretendard',
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                '$value회',
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
    ),
  );
}
