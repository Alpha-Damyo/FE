import 'package:damyo/database/smoke_database_helper.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'dart:async';

//index 3
final List<bool> _isPeriodtype = [true, false, false];
String periodType = '일';
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

class periodSingleInfo extends StatefulWidget {
  const periodSingleInfo({
    super.key,
    required this.userDB,
  });

  final SmokeDatabaseHelper userDB;

  @override
  State<periodSingleInfo> createState() => _periodSingleInfoState();
}

class _periodSingleInfoState extends State<periodSingleInfo> {
  bool _isLoading = true;
  List<dynamic>? smokeWeekdayInfo, smokeWeeksInfo, smokeMonthsInfo;
  int? maxWeekday, maxWeeks, maxMonths;

  Future<void> _loadData(int term) async {
    Timer(Duration(milliseconds: term), () {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    });
  }

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

  @override
  void initState() {
    weekdayInfo();
    weeksInfo();
    monthsInfo();
    _loadData(300);
    super.initState();
  }

  @override
  // 기간별 총 흡연량(개인)
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.only(top: 25, left: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                '나의 기간별 흡연량',
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
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                '개수',
                style: TextStyle(
                  color: Color(0xFFD1D6DC),
                  fontSize: 12,
                  fontFamily: 'Pretendard',
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
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
                child: (periodType == '일')
                    ? BarChart(
                        BarChartData(
                          barTouchData: barDayTouchData,
                          titlesData: dayTitlesData,
                          borderData: borderData,
                          barGroups: barDayGroups,
                          gridData: const FlGridData(show: false),
                          alignment: BarChartAlignment.spaceAround,
                          maxY: (maxWeekday! + 10),
                        ),
                      )
                    : (periodType == '주')
                        ? BarChart(
                            BarChartData(
                              barTouchData: barWeekTouchData,
                              titlesData: weekTitlesData,
                              borderData: borderData,
                              barGroups: barWeekGroups,
                              gridData: const FlGridData(show: false),
                              alignment: BarChartAlignment.spaceAround,
                              maxY: (maxWeeks! + 10),
                            ),
                          )
                        : BarChart(
                            //월
                            BarChartData(
                              barTouchData: barMonthTouchData,
                              titlesData: monthTitlesData,
                              borderData: borderData,
                              barGroups: barMonthGroups,
                              gridData: const FlGridData(show: false),
                              alignment: BarChartAlignment.spaceAround,
                              maxY: (maxMonths! + 10),
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

  // '일'
  BarTouchData get barDayTouchData => BarTouchData(
        enabled: false,
        touchTooltipData: BarTouchTooltipData(
          getTooltipColor: (group) => Colors.transparent,
          tooltipPadding: EdgeInsets.zero,
          tooltipMargin: 20,
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

  // '주'
  BarTouchData get barWeekTouchData => BarTouchData(
        enabled: false,
        touchTooltipData: BarTouchTooltipData(
          getTooltipColor: (group) => Colors.transparent,
          tooltipPadding: EdgeInsets.zero,
          tooltipMargin: 20,
          getTooltipItem: (
            BarChartGroupData group,
            int groupIndex,
            BarChartRodData rod,
            int rodIndex,
          ) {
            return BarTooltipItem(
              rod.toY.round().toString(),
              TextStyle(
                color: (1 == group.x.toInt()) ? Colors.cyan : Colors.grey,
                fontWeight: FontWeight.bold,
              ),
            );
          },
        ),
      );

  // '월'
  BarTouchData get barMonthTouchData => BarTouchData(
        enabled: false,
        touchTooltipData: BarTouchTooltipData(
          getTooltipColor: (group) => Colors.transparent,
          tooltipPadding: EdgeInsets.zero,
          tooltipMargin: 20,
          getTooltipItem: (
            BarChartGroupData group,
            int groupIndex,
            BarChartRodData rod,
            int rodIndex,
          ) {
            return BarTooltipItem(
              rod.toY.round().toString(),
              TextStyle(
                color: (1 == group.x.toInt()) ? Colors.cyan : Colors.grey,
                fontWeight: FontWeight.bold,
              ),
            );
          },
        ),
      );

  // '일'로 설정했을 때
  Widget _getDays(double value, TitleMeta meta) {
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
    bool thisday = (now.weekday == value.toInt());
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
      child: Text(text, style: (thisday) ? style1 : style2),
    );
  }

  // '주'로 설정했을 때
  Widget _getWeeks(double value, TitleMeta meta) {
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
    bool thisweek = (1 == value.toInt());
    switch (value.toInt()) {
      case 1:
        text = '이번주';
        break;
      case 2:
        text = '1주전';
        break;
      case 3:
        text = '2주전';
        break;
      case 4:
        text = '3주전';
        break;
      default:
        text = '';
        break;
    }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 4,
      child: Text(text, style: (thisweek) ? style1 : style2),
    );
  }

  // '월'로 설정했을 때
  Widget _getMonths(double value, TitleMeta meta) {
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
    bool thismonth = (1 == value.toInt());
    switch (value.toInt()) {
      case 1:
        text = '이번달';
        break;
      case 2:
        text = '1달전';
        break;
      case 3:
        text = '2달전';
        break;
      case 4:
        text = '3달전';
        break;
      case 5:
        text = '4달전';
        break;
      case 6:
        text = '5달전';
        break;
      default:
        text = '';
        break;
    }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 4,
      child: Text(text, style: (thismonth) ? style1 : style2),
    );
  }

  FlTitlesData get dayTitlesData => FlTitlesData(
        show: true,
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            getTitlesWidget: _getDays,
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

  FlTitlesData get weekTitlesData => FlTitlesData(
        show: true,
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            getTitlesWidget: _getWeeks,
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

  FlTitlesData get monthTitlesData => FlTitlesData(
        show: true,
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            getTitlesWidget: _getMonths,
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

  List<BarChartGroupData> get barDayGroups =>
      List.generate(smokeWeekdayInfo!.length, (index) {
        return BarChartGroupData(
          x: index + 1,
          barRods: [
            BarChartRodData(
              toY: (smokeWeekdayInfo?[index] != 0)
                  ? (smokeWeekdayInfo?[index] * 1.0)
                  : 0.2,
              width: 30,
              gradient: ((index + 1) == now.weekday)
                  ? _barsGradientBlue
                  : _barsGradientGrey,
            )
          ],
          showingTooltipIndicators: [0],
        );
      });

  List<BarChartGroupData> get barWeekGroups =>
      List.generate(smokeWeeksInfo!.length, (index) {
        return BarChartGroupData(
          x: index + 1,
          barRods: [
            BarChartRodData(
              toY: (smokeWeeksInfo?[index] != 0)
                  ? (smokeWeeksInfo?[index] * 1.0)
                  : 0.2,
              width: 30,
              gradient: (index == 0) ? _barsGradientBlue : _barsGradientGrey,
            )
          ],
          showingTooltipIndicators: [0],
        );
      });

  List<BarChartGroupData> get barMonthGroups =>
      List.generate(smokeMonthsInfo!.length, (index) {
        return BarChartGroupData(
          x: index + 1,
          barRods: [
            BarChartRodData(
              toY: (smokeMonthsInfo?[index] != 0)
                  ? (smokeMonthsInfo?[index] * 1.0)
                  : 0.2,
              width: 30,
              gradient: (index == 0) ? _barsGradientBlue : _barsGradientGrey,
            )
          ],
          showingTooltipIndicators: [0],
        );
      });
}
