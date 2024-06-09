import 'package:damyo/database/smoke_database_helper.dart';
import 'package:damyo/models/statistics/stat_date_model.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'dart:async';

//index 5
final List<bool> _isComparetype = [true, false, false];
String compareType = '일';
bool compareCheck = true;
// 날짜 정보를 가져오기 위해
DateTime now = DateTime.now();
List<String> weekOrder = [
  'Monday',
  'Tuesday',
  'Wednesday',
  'Thursday',
  'Friday',
  'Saturday',
  'Sunday'
];

class periodCompareInfo extends StatefulWidget {
  const periodCompareInfo({
    super.key,
    required this.everyInfo,
    required this.userDB,
  });

  final statDateModel everyInfo;
  final SmokeDatabaseHelper userDB;

  @override
  State<periodCompareInfo> createState() => _periodCompareInfoState();
}

double roundUpToNearestTen(int number) {
  return (number + 9) ~/ 10 * 10;
}

class _periodCompareInfoState extends State<periodCompareInfo> {
  bool _isLoading = true;
  List<dynamic>? everyDayWeek, everyWeeks, everyMonths;
  List<dynamic>? smokeWeekdayInfo, smokeWeeksInfo, smokeMonthsInfo;
  int? maxWeekday, maxWeeks, maxMonths;

  void weekdayInfo() async {
    List<int> smokeCounts = List.filled(7, 0);
    int max = 0;
    final startDate = now.subtract(Duration(days: 6));
    final dataInRange =
        await widget.userDB.getSmokeInfoInWeekDayRange(startDate, now);

    for (var item in dataInRange) {
      int index = weekOrder.indexOf(item['weekday']);
      if (index != -1) {
        smokeCounts[index] = item['count'];
        if (max < item['count']) {
          max = item['count'];
        }
      }
    }

    setState(() {
      smokeWeekdayInfo = smokeCounts;
      maxWeekday = max;
    });
  }

  void weeksInfo() async {
    List<int> smokeCounts = List.filled(4, 0);
    int max = 0;

    for (int i = 0; i < 4; i++) {
      final startDate = now.subtract(Duration(days: 6 + (7 * i)));
      final endDate = now.subtract(Duration(days: 7 * i));
      final dateInRange =
          await widget.userDB.getSmokeInfoInWeeksRange(startDate, endDate);
      smokeCounts[i] = dateInRange.first['count'];
      if (max < dateInRange.first['count']) {
        max = dateInRange.first['count'];
      }
    }

    setState(() {
      smokeWeeksInfo = smokeCounts;
      maxWeeks = max;
    });
  }

  void monthsInfo() async {
    List<int> smokeCounts = List.filled(6, 0);
    int max = 0;

    for (int i = 0; i < 6; i++) {
      final startDate = now.subtract(Duration(days: 27 + (28 * i)));
      final endDate = now.subtract(Duration(days: 28 * i));
      final dateInRange =
          await widget.userDB.getSmokeInfoInWeeksRange(startDate, endDate);
      smokeCounts[i] = dateInRange.first['count'];
      if (max < dateInRange.first['count']) {
        max = dateInRange.first['count'];
      }
    }

    setState(() {
      smokeMonthsInfo = smokeCounts;
      maxMonths = max;
    });
  }

  void setEveryInfo() {
    setState(() {
      everyDayWeek = widget.everyInfo.dayWeek;
      everyWeeks = widget.everyInfo.weeks;
      everyMonths = widget.everyInfo.months;
    });
  }

  void setUserInfo() {
    weekdayInfo();
    weeksInfo();
    monthsInfo();
  }

  @override
  void initState() {
    _loadData(500);
    setEveryInfo();
    setUserInfo();
    super.initState();
  }

  Future<void> _loadData(int term) async {
    Timer(Duration(milliseconds: term), () {
      setState(() {
        _isLoading = false;
      });
    });
  }

  @override
  //기간별 평균 흡연량 비교
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.only(top: 25, left: 16),
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
        _isLoading
            ? const Expanded(
                child: Align(
                  alignment: Alignment.center,
                  child: SizedBox(
                    width: 50.0, // 원하는 너비
                    height: 50.0, // 원하는 높이
                    child: CircularProgressIndicator(),
                  ),
                ),
              )
            : Expanded(
                child: (compareType == '일')
                    ? BarChart(
                        BarChartData(
                          barTouchData: _periodCompare,
                          titlesData: daytitlesCompare,
                          borderData: borderData,
                          barGroups: barDaysCompare,
                          gridData: gridData,
                          alignment: BarChartAlignment.spaceAround,
                          maxY: roundUpToNearestTen(maxWeekday! + 20),
                        ),
                      )
                    : (compareType == '주')
                        ? BarChart(
                            BarChartData(
                              barTouchData: _periodCompare,
                              titlesData: weektitlesCompare,
                              borderData: borderData,
                              barGroups: barWeeksCompare,
                              gridData: gridData,
                              alignment: BarChartAlignment.spaceAround,
                              maxY: roundUpToNearestTen(maxWeeks! + 20),
                            ),
                          )
                        : BarChart(
                            //월
                            BarChartData(
                              barTouchData: _periodCompare,
                              titlesData: monthtitlesCompare,
                              borderData: borderData,
                              barGroups: barMonthsCompare,
                              gridData: gridData,
                              alignment: BarChartAlignment.spaceAround,
                              maxY: roundUpToNearestTen(maxMonths! + 20),
                            ),
                          ),
              ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ToggleButtons(
            disabledColor: Colors.white,
            selectedColor: const Color(0xFFEEF1F4),
            fillColor: const Color(0xFFEEF1F4),
            borderRadius: BorderRadius.circular(10),
            renderBorder: false,
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
                _isLoading = true;
                _loadData(500);
              });
            },
            children: [
              Container(
                width: 60,
                height: 30,
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
                width: 60,
                height: 30,
                padding: const EdgeInsets.symmetric(vertical: 8),
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
                width: 60,
                height: 30,
                padding: const EdgeInsets.symmetric(vertical: 8),
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

  FlBorderData get borderData => FlBorderData(
        show: false,
      );

  FlGridData get gridData => const FlGridData(
        show: false,
        drawHorizontalLine: true,
        horizontalInterval: 10,
        drawVerticalLine: false,
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
              const TextStyle(
                color: Colors.cyan,
                fontWeight: FontWeight.bold,
              ),
            );
          },
        ),
      );

  // '일'로 설정했을 때
  Widget _getDayCompare(double value, TitleMeta meta) {
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

  // '주'로 설정했을 때
  Widget _getWeekCompare(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );
    String text;
    switch (value.toInt()) {
      case 0:
        text = '이번주';
        break;
      case 1:
        text = '1주전';
        break;
      case 2:
        text = '2주전';
        break;
      case 3:
        text = '3주전';
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

  // '월'로 설정했을 때
  Widget _getMonthCompare(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );
    String text;
    switch (value.toInt()) {
      case 0:
        text = '이번달';
        break;
      case 1:
        text = '1달전';
        break;
      case 2:
        text = '2달전';
        break;
      case 3:
        text = '3달전';
        break;
      case 4:
        text = '4달전';
        break;
      case 5:
        text = '5달전';
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

  SideTitles leftTitles() => SideTitles(
        getTitlesWidget: leftTitleWidgets,
        showTitles: false,
        interval: 10,
        reservedSize: 20,
      );

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 10,
    );
    int text = value.toInt();

    return Text('$text', style: style, textAlign: TextAlign.center);
  }

  FlTitlesData get daytitlesCompare => FlTitlesData(
        show: true,
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            getTitlesWidget: _getDayCompare,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: leftTitles(),
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

  FlTitlesData get weektitlesCompare => FlTitlesData(
        show: true,
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            getTitlesWidget: _getWeekCompare,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: leftTitles(),
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

  FlTitlesData get monthtitlesCompare => FlTitlesData(
        show: true,
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            getTitlesWidget: _getMonthCompare,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: leftTitles(),
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

  List<BarChartGroupData> get barDaysCompare => [
        for (int i = 0; i < smokeWeekdayInfo!.length; i++)
          makeGroupData(
              i, smokeWeekdayInfo?[i] * 1.0, everyDayWeek?[i + 1], compareCheck)
      ];
  List<BarChartGroupData> get barWeeksCompare => [
        for (int i = 0; i < smokeWeeksInfo!.length; i++)
          makeGroupData(
              i, smokeWeeksInfo?[i] * 1.0, everyWeeks?[i + 1], compareCheck)
      ];
  List<BarChartGroupData> get barMonthsCompare => [
        for (int i = 0; i < smokeMonthsInfo!.length; i++)
          makeGroupData(i, smokeMonthsInfo![i] * 1.0,
              everyMonths?[(now.month + 12 - i) % 12], compareCheck)
      ];

  BarChartGroupData makeGroupData(
      int x, double y1, double y2, bool compareCheck) {
    return BarChartGroupData(
      barsSpace: 4,
      x: x,
      barRods: [
        BarChartRodData(
          toY: (y1 == 0) ? 0.4 : y1,
          width: 15,
          gradient: (compareCheck) ? _barsGradientBlue : _barsGradientGrey,
        ),
        BarChartRodData(
          toY: (y2 == 0) ? 0.4 : y2,
          width: 15,
          gradient: (compareCheck) ? _barsGradientGrey : _barsGradientBlue,
        ),
      ],
      showingTooltipIndicators: (compareCheck) ? [0] : [1],
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
}
