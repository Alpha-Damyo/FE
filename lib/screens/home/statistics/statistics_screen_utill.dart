import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:damyo/provider/userinfo_provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fl_chart/fl_chart.dart';

// 페이지 라우트 경로들을 리스트로 관리
List<String> routePaths = [
  '/local_statistics',
  '/time_statistics',
  '/period_statistics',
  '/week_statistics',
];

class StatistTap extends StatefulWidget {
  const StatistTap({
    super.key,
    required this.index,
    required this.category,
  });

  final int index;
  final String category;
  final String userName = '최하영';

  @override
  State<StatistTap> createState() => _StatistTapState();
}

class _StatistTapState extends State<StatistTap>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  // 날짜 정보를 가져오기 위해
  DateTime now = DateTime.now();

  //각 페이지 마다 필요한 변수
  //index 3
  final List<bool> _isPeriodtype = [true, false, false];
  String periodType = '일';
  //index 2
  bool timeCheck = true;
  //index 5
  final List<bool> _isComparetype = [true, false, false];
  String compareType = '일';
  bool compareCheck = true;

  @override
  Widget build(BuildContext context) {
    //인덱스 별 통계 페이지 생성
    switch (widget.index) {
      case 0:
        // 유저 정보 화면
        return _userInfo();
      case 1:
        // 지역별 통계 화면
        return _localInfo();
      case 2:
        // 시간대별 평균 흡연량
        return _timeAverInfo();
      case 3:
        // 기간별 통계 화면(개인 총 흡연량)
        return _periodSumInfo();
      case 4:
        // 담배값 계산기
        return _calculatePrice();
      case 5:
        // 기간별 평균 흡연량 비교
        return _periodCompareInfo();
      default:
        return Container();
    }
  }

  // 사용자 정보 위젯
  Widget _userInfo() {
    return Container(
      height: 300,
      padding: const EdgeInsets.only(
        top: 27,
        left: 16,
        right: 16,
        bottom: 20,
      ),
      //그라데이션
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment(0.00, -1.00),
          end: Alignment(0, 1),
          colors: [Color(0xFFD6ECFA), Colors.white],
        ),
      ),
      child: Column(
        // mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: SizedBox(
                  child: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: widget.userName,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontFamily: 'Pretendard',
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const TextSpan(
                          text: ' ',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontFamily: 'Pretendard',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const TextSpan(
                          text: '님',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontFamily: 'Pretendard',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 99),
              const Text(
                '라이트 스모커',
                style: TextStyle(
                  color: Color(0xFF0099FC),
                  fontSize: 20,
                  fontFamily: 'Pretendard',
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 30),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                child: Text(
                  '가장 많이 방문한 곳 ',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontFamily: 'Pretendard',
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    _mostSmokingArea(1, '국민대 도서관', 23129),
                    _mostSmokingArea(2, '정릉역 2번출구', 13023),
                    _mostSmokingArea(3, '국민대 공학관', 10322),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // 많이 방문한 흡연구역
  Widget _mostSmokingArea(int rank, String place, int cnt) {
    return InkWell(
      onTap: () {
        print(place);
        print(now.weekday);
      },
      child: Container(
        width: 120,
        height: 120,
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(width: 1, color: const Color(0xFFEEF1F4)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              '$rank등',
              style: const TextStyle(
                color: Color(0xFF0099FC),
                fontSize: 12,
                fontFamily: 'Pretendard',
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 8),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  place,
                  style: const TextStyle(
                    color: Color(0xFF10151B),
                    fontSize: 14,
                    fontFamily: 'Pretendard',
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  '$cnt 회',
                  style: const TextStyle(
                    color: Color(0xFF6E767F),
                    fontSize: 10,
                    fontFamily: 'Pretendard',
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildTag('실외'),
                    _buildTag('개방형'),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTag(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: const Color(0xFFD6ECFA),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Color(0xFF0E6AA6),
          fontSize: 10,
          fontFamily: 'Pretendard',
          fontWeight: FontWeight.w600,
        ),
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

  // 지역 정보 위젯
  Widget _localInfo() {
    return ScreenUtilInit(
      designSize: const Size(390, 300),
      child: Ink(
        width: 390.w,
        height: 300.h,
        decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            side: const BorderSide(
              width: 2,
              strokeAlign: BorderSide.strokeAlignOutside,
              color: Color(0xFFEEF1F4),
            ),
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        child: InkWell(
          onTap: () {
            context.push(
              routePaths[widget.index],
              extra: widget.category,
            );
          },
          borderRadius: BorderRadius.circular(15),
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 20.0),
                child: SizedBox(
                  width: 322,
                  child: Text(
                    '가장 인기있는 흡연구역',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontFamily: 'Pretendard',
                      fontWeight: FontWeight.w600,
                      height: 0,
                    ),
                  ),
                ),
              ),
              TabBar(
                controller: _tabController,
                tabs: const [
                  Tab(text: '지역'),
                  Tab(text: '흡연구역'),
                ],
              ),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    _tapContents(),
                    const Center(child: Text('탭 2의 콘텐츠')),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  //시간대별 정보
  Widget _timeAverInfo() {
    return ScreenUtilInit(
      designSize: const Size(390, 500),
      child: Ink(
        width: 390.w,
        height: 500.h,
        decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            side: const BorderSide(
              width: 2,
              strokeAlign: BorderSide.strokeAlignOutside,
              color: Color(0xFFEEF1F4),
            ),
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        child: InkWell(
          onTap: () {
            context.push(
              routePaths[widget.index],
              extra: widget.category,
            );
          },
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.only(
                  top: 20.0,
                ),
                child: SizedBox(
                  width: 322,
                  child: Text(
                    '시간별 평균 흡연량',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontFamily: 'Pretendard',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      setState(() {
                        timeCheck = true;
                      });
                    },
                    child: Text(
                      '나',
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        color: timeCheck
                            ? const Color(0xFF0099FC)
                            : const Color(0xFFD1D6DC),
                        fontSize: 12,
                        fontFamily: 'Pretendard',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        timeCheck = false;
                      });
                    },
                    child: Text(
                      '전체',
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        color: timeCheck
                            ? const Color(0xFFD1D6DC)
                            : const Color(0xFF0099FC),
                        fontSize: 12,
                        fontFamily: 'Pretendard',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: LineChart(
                    timeSmokeAver,
                    duration: const Duration(milliseconds: 250),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  LineChartData get timeSmokeAver => LineChartData(
        lineTouchData: lineTouchData,
        gridData: gridData,
        titlesData: timetitlesData,
        borderData: curveborderData,
        lineBarsData: lineBarsData,
        minX: 0,
        maxX: 24,
        maxY: 30,
        minY: 0,
      );

  LineTouchData get lineTouchData => LineTouchData(
        handleBuiltInTouches: true,
        touchTooltipData: LineTouchTooltipData(
          getTooltipColor: (touchedSpot) => Colors.blueGrey.withOpacity(0.8),
        ),
      );

  FlTitlesData get timetitlesData => FlTitlesData(
        bottomTitles: AxisTitles(
          sideTitles: bottomTitles,
        ),
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        leftTitles: AxisTitles(
          sideTitles: leftTitles(),
        ),
      );

  List<LineChartBarData> get lineBarsData => [
        lineChartBarDataUser,
        lineChartBarDataEvery,
      ];

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 10,
    );
    int text;
    switch (value.toInt()) {
      case 5:
        text = 5;
        break;
      case 10:
        text = 10;
        break;
      case 15:
        text = 15;
        break;
      case 20:
        text = 20;
        break;
      case 25:
        text = 25;
        break;
      default:
        return Container();
    }

    return Text('$text', style: style, textAlign: TextAlign.center);
  }

  SideTitles leftTitles() => SideTitles(
        getTitlesWidget: leftTitleWidgets,
        showTitles: true,
        interval: 1,
        reservedSize: 20,
      );

  Widget timeLineWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 12,
    );
    Widget text;
    switch (value.toInt()) {
      case 0:
        text = const Text('00시', style: style);
        break;
      case 3:
        text = const Text('03시', style: style);
        break;
      case 6:
        text = const Text('06시', style: style);
        break;
      case 9:
        text = const Text('09시', style: style);
        break;
      case 12:
        text = const Text('12시', style: style);
        break;
      case 15:
        text = const Text('15시', style: style);
        break;
      case 18:
        text = const Text('18시', style: style);
        break;
      case 21:
        text = const Text('21시', style: style);
        break;
      default:
        text = const Text('');
        break;
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 10,
      child: text,
    );
  }

  SideTitles get bottomTitles => SideTitles(
        showTitles: true,
        reservedSize: 32,
        interval: 1,
        getTitlesWidget: timeLineWidgets,
      );

  FlGridData get gridData => const FlGridData(
        show: true,
        drawHorizontalLine: true,
        drawVerticalLine: false,
      );

  FlBorderData get curveborderData => FlBorderData(
        show: true,
        border: const Border(
          bottom: BorderSide(color: Colors.grey, width: 2),
          left: BorderSide(color: Colors.transparent),
          right: BorderSide(color: Colors.transparent),
          top: BorderSide(color: Colors.transparent),
        ),
      );

  LineChartBarData get lineChartBarDataUser => LineChartBarData(
        isCurved: true,
        gradient: LinearGradient(
          colors: timeCheck
              ? [
                  const Color(0xFFD6ECFA),
                  const Color(0xFF0099FC),
                ]
              : [
                  const Color(0xFFD2D7DD),
                  const Color(0xFFD2D7DD),
                ],
        ),
        barWidth: 4,
        isStrokeCapRound: true,
        dotData: const FlDotData(show: false),
        belowBarData: BarAreaData(show: false),
        spots: [
          const FlSpot(0, 10),
          const FlSpot(3, 12.3),
          const FlSpot(6, 4),
          const FlSpot(9, 3),
          const FlSpot(12, 7),
          const FlSpot(15, 4),
          const FlSpot(18, 10),
          const FlSpot(21, 4),
          const FlSpot(24, 8),
        ],
      );

  LineChartBarData get lineChartBarDataEvery => LineChartBarData(
        isCurved: true,
        gradient: LinearGradient(
          colors: timeCheck
              ? [
                  const Color(0xFFD2D7DD),
                  const Color(0xFFD2D7DD),
                ]
              : [
                  const Color(0xFFD6ECFA),
                  const Color(0xFF0099FC),
                ],
        ),
        barWidth: 4,
        isStrokeCapRound: true,
        dotData: const FlDotData(show: false),
        belowBarData: BarAreaData(show: false),
        spots: const [
          FlSpot(0, 1),
          FlSpot(3, 2.8),
          FlSpot(6, 4.2),
          FlSpot(9, 9.8),
          FlSpot(12, 7.6),
          FlSpot(15, 10.9),
          FlSpot(18, 15.9),
          FlSpot(21, 23.9),
          FlSpot(24, 10.9),
        ],
      );

  // 기간별 총 흡연량(개인)
  Widget _periodSumInfo() {
    return ScreenUtilInit(
      designSize: const Size(390, 500),
      child: Ink(
        width: 390.w,
        height: 500.h,
        decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            side: const BorderSide(
              width: 2,
              strokeAlign: BorderSide.strokeAlignOutside,
              color: Color(0xFFEEF1F4),
            ),
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        child: InkWell(
          onTap: () {
            context.push(
              routePaths[widget.index],
              extra: widget.category,
            );
          },
          borderRadius: BorderRadius.circular(15),
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.only(
                  top: 20.0,
                ),
                child: SizedBox(
                  width: 322,
                  child: Text(
                    '나의 기간별 흡연량',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontFamily: 'Pretendard',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 358,
                child: Text(
                  '개수',
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    color: Color(0xFFD1D6DC),
                    fontSize: 12,
                    fontFamily: 'Pretendard',
                    fontWeight: FontWeight.w500,
                    height: 0,
                  ),
                ),
              ),
              Expanded(
                child: (periodType == '일')
                    ? BarChart(
                        BarChartData(
                          barTouchData: barTouchData,
                          titlesData: titlesData,
                          borderData: borderData,
                          barGroups: barGroups,
                          gridData: const FlGridData(show: false),
                          alignment: BarChartAlignment.spaceAround,
                          maxY: 20,
                        ),
                      )
                    : (periodType == '주')
                        ? BarChart(
                            BarChartData(
                              barTouchData: barTouchData,
                              titlesData: titlesData,
                              borderData: borderData,
                              barGroups: barGroups,
                              gridData: const FlGridData(show: false),
                              alignment: BarChartAlignment.spaceAround,
                              maxY: 100,
                            ),
                          )
                        : BarChart(
                            //월
                            BarChartData(
                              barTouchData: barTouchData,
                              titlesData: titlesData,
                              borderData: borderData,
                              barGroups: barGroups,
                              gridData: const FlGridData(show: false),
                              alignment: BarChartAlignment.spaceAround,
                              maxY: 500,
                            ),
                          ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ToggleButtons(
                  disabledColor: Colors.white,
                  selectedColor: const Color(0xFFEEF1F4),
                  borderRadius: BorderRadius.circular(10),
                  isSelected: _isPeriodtype,
                  onPressed: (int index) {
                    setState(() {
                      _isPeriodtype[index] = true;
                      for (int i = 0; i < _isPeriodtype.length; i++) {
                        if (i != index) {
                          _isPeriodtype[i] = false;
                        }
                      }
                      if (_isPeriodtype[index]) {
                        switch (index) {
                          case 0:
                            periodType = '일';
                            break;
                          case 1:
                            periodType = '주';
                            break;
                          case 2:
                            periodType = '월';
                            break;
                          default:
                            break;
                        }
                      }
                    });
                  },
                  children: [
                    Container(
                      width: 61,
                      height: 30,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      clipBehavior: Clip.antiAlias,
                      decoration: ShapeDecoration(
                        color: const Color(0xFFEEF1F4),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            '일',
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 12,
                              fontFamily: 'Pretendard',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 61,
                      height: 30,
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      clipBehavior: Clip.antiAlias,
                      decoration: ShapeDecoration(
                        color: const Color(0xFFEEF1F4),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            '주',
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 12,
                              fontFamily: 'Pretendard',
                              fontWeight: FontWeight.w600,
                              height: 0,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 61,
                      height: 30,
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      clipBehavior: Clip.antiAlias,
                      decoration: ShapeDecoration(
                        color: const Color(0xFFEEF1F4),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            '월',
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 12,
                              fontFamily: 'Pretendard',
                              fontWeight: FontWeight.w600,
                              height: 0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  BarTouchData get barTouchData => BarTouchData(
        enabled: false,
        touchTooltipData: BarTouchTooltipData(
          getTooltipColor: (group) => Colors.transparent,
          tooltipPadding: EdgeInsets.zero,
          tooltipMargin: 8,
          getTooltipItem: (
            BarChartGroupData group,
            int groupIndex,
            BarChartRodData rod,
            int rodIndex,
          ) {
            return BarTooltipItem(
              rod.toY.round().toString(),
              TextStyle(
                color: (now.weekday == group.x.toInt())
                    ? Colors.cyan
                    : Colors.grey,
                fontWeight: FontWeight.bold,
              ),
            );
          },
        ),
      );

  // '일'로 설정했을 때
  Widget _getWeeksDay(double value, TitleMeta meta) {
    const style1 = TextStyle(
      color: Colors.blue,
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );
    const style2 = TextStyle(
      color: Colors.grey,
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );
    String text;
    bool day = (now.weekday == value.toInt());
    switch (value.toInt()) {
      case 1:
        text = '월';
        break;
      case 2:
        text = '화';
        break;
      case 3:
        text = '수';
        break;
      case 4:
        text = '목';
        break;
      case 5:
        text = '금';
        break;
      case 6:
        text = '토';
        break;
      case 7:
        text = '일';
        break;
      default:
        text = '';
        break;
    }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 4,
      child: Text(text, style: (day) ? style1 : style2),
    );
  }

  FlTitlesData get titlesData => FlTitlesData(
        show: true,
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            getTitlesWidget: _getWeeksDay,
          ),
        ),
        leftTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(
            showTitles: false,
            reservedSize: 30,
          ),
        ),
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
      );

  FlBorderData get borderData => FlBorderData(
        show: false,
      );

  LinearGradient get _barsGradientBlue => const LinearGradient(
        colors: [
          Colors.blue,
          Colors.cyan,
        ],
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter,
      );

  LinearGradient get _barsGradientGrey => const LinearGradient(
        colors: [
          Colors.grey,
          Colors.grey,
        ],
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter,
      );

  List<BarChartGroupData> get barGroups => [
        BarChartGroupData(
          x: 1,
          barRods: [
            BarChartRodData(
              toY: 8,
              width: 30,
              gradient:
                  (1 == now.weekday) ? _barsGradientBlue : _barsGradientGrey,
            )
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 2,
          barRods: [
            BarChartRodData(
              toY: 10,
              width: 30,
              gradient:
                  (2 == now.weekday) ? _barsGradientBlue : _barsGradientGrey,
            )
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 3,
          barRods: [
            BarChartRodData(
              toY: 14,
              width: 30,
              gradient:
                  (3 == now.weekday) ? _barsGradientBlue : _barsGradientGrey,
            )
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 4,
          barRods: [
            BarChartRodData(
              toY: 15,
              width: 30,
              gradient:
                  (4 == now.weekday) ? _barsGradientBlue : _barsGradientGrey,
            )
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 5,
          barRods: [
            BarChartRodData(
              toY: 13,
              width: 30,
              gradient:
                  (5 == now.weekday) ? _barsGradientBlue : _barsGradientGrey,
            )
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 6,
          barRods: [
            BarChartRodData(
              toY: 10,
              width: 30,
              gradient:
                  (6 == now.weekday) ? _barsGradientBlue : _barsGradientGrey,
            )
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 7,
          barRods: [
            BarChartRodData(
              toY: 16,
              width: 30,
              gradient:
                  (7 == now.weekday) ? _barsGradientBlue : _barsGradientGrey,
            )
          ],
          showingTooltipIndicators: [0],
        ),
      ];

  //기간별 평균 흡연량 비교
  Widget _periodCompareInfo() {
    return ScreenUtilInit(
      designSize: const Size(390, 500),
      child: Ink(
        width: 390.w,
        height: 500.h,
        decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            side: const BorderSide(
              width: 2,
              strokeAlign: BorderSide.strokeAlignOutside,
              color: Color(0xFFEEF1F4),
            ),
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(15),
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.only(
                  top: 20.0,
                ),
                child: SizedBox(
                  width: 322,
                  child: Text(
                    '평균 흡연량 비교하기',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontFamily: 'Pretendard',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      setState(() {
                        compareCheck = true;
                      });
                    },
                    child: Text(
                      '나',
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        color: compareCheck
                            ? const Color(0xFF0099FC)
                            : const Color(0xFFD1D6DC),
                        fontSize: 12,
                        fontFamily: 'Pretendard',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        compareCheck = false;
                      });
                    },
                    child: Text(
                      '전체',
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        color: compareCheck
                            ? const Color(0xFFD1D6DC)
                            : const Color(0xFF0099FC),
                        fontSize: 12,
                        fontFamily: 'Pretendard',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: (compareType == '일')
                    ? BarChart(
                        BarChartData(
                          barTouchData: _periodCompare,
                          titlesData: titlesDataCompare,
                          borderData: borderData,
                          barGroups: barGroupsCompare,
                          gridData: const FlGridData(show: false),
                          alignment: BarChartAlignment.spaceAround,
                          maxY: 20,
                        ),
                      )
                    : (compareType == '주')
                        ? BarChart(
                            BarChartData(
                              barTouchData: barTouchData,
                              titlesData: titlesData,
                              borderData: borderData,
                              barGroups: barGroups,
                              gridData: const FlGridData(show: false),
                              alignment: BarChartAlignment.spaceAround,
                              maxY: 100,
                            ),
                          )
                        : BarChart(
                            //월
                            BarChartData(
                              barTouchData: _periodCompare,
                              titlesData: titlesData,
                              borderData: borderData,
                              barGroups: barGroups,
                              gridData: const FlGridData(show: false),
                              alignment: BarChartAlignment.spaceAround,
                              maxY: 500,
                            ),
                          ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ToggleButtons(
                  disabledColor: Colors.white,
                  selectedColor: const Color(0xFFEEF1F4),
                  borderRadius: BorderRadius.circular(10),
                  isSelected: _isComparetype,
                  onPressed: (int index) {
                    setState(() {
                      _isComparetype[index] = true;
                      for (int i = 0; i < _isComparetype.length; i++) {
                        if (i != index) {
                          _isComparetype[i] = false;
                        }
                      }
                      if (_isComparetype[index]) {
                        switch (index) {
                          case 0:
                            compareType = '일';
                            break;
                          case 1:
                            compareType = '주';
                            break;
                          case 2:
                            compareType = '월';
                            break;
                          default:
                            break;
                        }
                      }
                    });
                  },
                  children: [
                    Container(
                      width: 61,
                      height: 30,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      clipBehavior: Clip.antiAlias,
                      decoration: ShapeDecoration(
                        color: const Color(0xFFEEF1F4),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            '일',
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 12,
                              fontFamily: 'Pretendard',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 61,
                      height: 30,
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      clipBehavior: Clip.antiAlias,
                      decoration: ShapeDecoration(
                        color: const Color(0xFFEEF1F4),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            '주',
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 12,
                              fontFamily: 'Pretendard',
                              fontWeight: FontWeight.w600,
                              height: 0,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 61,
                      height: 30,
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      clipBehavior: Clip.antiAlias,
                      decoration: ShapeDecoration(
                        color: const Color(0xFFEEF1F4),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            '월',
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 12,
                              fontFamily: 'Pretendard',
                              fontWeight: FontWeight.w600,
                              height: 0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  BarTouchData get _periodCompare => BarTouchData(
        enabled: false,
        touchTooltipData: BarTouchTooltipData(
          getTooltipColor: (group) => Colors.transparent,
          tooltipPadding: EdgeInsets.zero,
          tooltipMargin: 8,
          getTooltipItem: (
            BarChartGroupData group,
            int groupIndex,
            BarChartRodData rod,
            int rodIndex,
          ) {
            return BarTooltipItem(
              rod.toY.round().toString(),
              TextStyle(
                color: (compareCheck) ? Colors.cyan : Colors.grey,
                fontWeight: FontWeight.bold,
              ),
            );
          },
        ),
      );

  // '일'로 설정했을 때
  Widget _getWeeksDayCompare(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );
    String text;
    switch (value.toInt()) {
      case 0:
        text = '월';
        break;
      case 1:
        text = '화';
        break;
      case 2:
        text = '수';
        break;
      case 3:
        text = '목';
        break;
      case 4:
        text = '금';
        break;
      case 5:
        text = '토';
        break;
      case 6:
        text = '일';
        break;
      default:
        text = '';
        break;
    }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 4,
      child: Text(text, style: style),
    );
  }

  FlTitlesData get titlesDataCompare => FlTitlesData(
        show: true,
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            getTitlesWidget: _getWeeksDayCompare,
          ),
        ),
        leftTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(
            showTitles: false,
            reservedSize: 30,
          ),
        ),
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
      );

  // 일, 주, 월 데이터 받아와서 저장 및 등록
  List<double> UserAver = [12.2, 9.0, 3.4, 10.3, 2.8, 8.7, 9.4];
  List<double> EveryAver = [11.2, 19.0, 6.4, 17.3, 9.8, 18.7, 13.4];

  List<BarChartGroupData> get barGroupsCompare => [
        for (int i = 0; i < UserAver.length; i++)
          makeGroupData(i, UserAver[i], EveryAver[i], compareCheck)
      ];

  BarChartGroupData makeGroupData(
      int x, double y1, double y2, bool compareCheck) {
    return BarChartGroupData(
      barsSpace: 4,
      x: x,
      barRods: [
        BarChartRodData(
          toY: y1,
          width: 15,
          gradient: (compareCheck) ? _barsGradientBlue : _barsGradientGrey,
        ),
        BarChartRodData(
          toY: y2,
          width: 15,
          gradient: (compareCheck) ? _barsGradientGrey : _barsGradientBlue,
        ),
      ],
    );
  }

  int _selectedIndex = -1;
  // 담배값 계산기
  Widget _calculatePrice() {
    return ScreenUtilInit(
      designSize: const Size(390, 300),
      child: Ink(
        width: 390.w,
        height: 300.h,
        decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            side: const BorderSide(
              width: 2,
              strokeAlign: BorderSide.strokeAlignOutside,
              color: Color(0xFFEEF1F4),
            ),
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        child: InkWell(
          onTap: () {
            context.push(
              routePaths[widget.index],
              extra: widget.category,
            );
          },
          borderRadius: BorderRadius.circular(15),
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 20.0),
                child: SizedBox(
                  width: 322,
                  child: Text(
                    '나의 담배가격 계산해보기',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontFamily: 'Pretendard',
                      fontWeight: FontWeight.w600,
                      height: 0,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 50,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 3,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding:
                            const EdgeInsets.all(10), // 마지막 아이템에는 패딩을 적용하지 않음.
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              if (_selectedIndex == index) {
                                _selectedIndex = -1;
                              } else {
                                _selectedIndex = index;
                              }
                            });
                          },
                          child: Container(
                            height: 10,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 15,
                            ),
                            decoration: BoxDecoration(
                              color: _selectedIndex == index
                                  ? Theme.of(context).colorScheme.onPrimary
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(16),
                              border: _selectedIndex == index
                                  ? Border.all(
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                    )
                                  : Border.all(
                                      color: const Color(0xffE4E7EB),
                                    ),
                            ),
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                'test $index',
                                style: const TextStyle(
                                  color: Color(0xFF464D57),
                                  fontSize: 12,
                                  fontFamily: 'Pretendard',
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
