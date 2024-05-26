import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fl_chart/fl_chart.dart';

//index 5
final List<bool> _isComparetype = [true, false, false];
String compareType = '일';
bool compareCheck = true;
// 날짜 정보를 가져오기 위해
DateTime now = DateTime.now();

class periodCompareInfo extends StatefulWidget {
  const periodCompareInfo({
    super.key,
  });

  @override
  State<periodCompareInfo> createState() => _periodCompareInfoState();
}

class _periodCompareInfoState extends State<periodCompareInfo> {
  @override
  //기간별 평균 흡연량 비교
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(top: 25.h, left: 16.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                '평균 흡연량 비교하기',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontFamily: 'Pretendard',
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
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
                        barTouchData: _periodCompare,
                        titlesData: titlesDataCompare,
                        borderData: borderData,
                        barGroups: barGroupsCompare,
                        gridData: const FlGridData(show: false),
                        alignment: BarChartAlignment.spaceAround,
                        maxY: 100,
                      ),
                    )
                  : BarChart(
                      //월
                      BarChartData(
                        barTouchData: _periodCompare,
                        titlesData: titlesDataCompare,
                        borderData: borderData,
                        barGroups: barGroupsCompare,
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
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
}
