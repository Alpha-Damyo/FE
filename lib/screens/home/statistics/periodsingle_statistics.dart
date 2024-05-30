import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'dart:async';

//index 3
final List<bool> _isPeriodtype = [true, false, false];
String periodType = '일';
// 날짜 정보를 가져오기 위해
DateTime now = DateTime.now();

class periodSingleInfo extends StatefulWidget {
  const periodSingleInfo({
    super.key,
  });

  @override
  State<periodSingleInfo> createState() => _periodSingleInfoState();
}

class _periodSingleInfoState extends State<periodSingleInfo> {
  bool _isLoading = false;

  Future<void> _loadData(int term) async {
    Timer(Duration(milliseconds: term), () {
      setState(() {
        _isLoading = false;
      });
    });
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
                          maxY: 20,
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
                              maxY: 20,
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
                              maxY: 20,
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

  // '주'
  BarTouchData get barWeekTouchData => BarTouchData(
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
                color: (1 == group.x.toInt()) ? Colors.cyan : Colors.grey,
                fontWeight: FontWeight.bold,
              ),
            );
          },
        ),
      );

  // '주'
  BarTouchData get barMonthTouchData => BarTouchData(
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
    bool day = (1 == value.toInt());
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
      case 5:
        text = '4주전';
        break;
      case 6:
        text = '5주전';
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
    bool day = (1 == value.toInt());
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
      child: Text(text, style: (day) ? style1 : style2),
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

  List<BarChartGroupData> get barDayGroups => [
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

  List<BarChartGroupData> get barWeekGroups => [
        BarChartGroupData(
          x: 1,
          barRods: [
            BarChartRodData(
              toY: 8,
              width: 30,
              gradient: _barsGradientBlue,
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
              gradient: _barsGradientGrey,
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
              gradient: _barsGradientGrey,
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
              gradient: _barsGradientGrey,
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
              gradient: _barsGradientGrey,
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
              gradient: _barsGradientGrey,
            )
          ],
          showingTooltipIndicators: [0],
        ),
      ];

  List<BarChartGroupData> get barMonthGroups => [
        BarChartGroupData(
          x: 1,
          barRods: [
            BarChartRodData(
              toY: 8,
              width: 30,
              gradient: _barsGradientBlue,
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
              gradient: _barsGradientGrey,
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
              gradient: _barsGradientGrey,
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
              gradient: _barsGradientGrey,
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
              gradient: _barsGradientGrey,
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
              gradient: _barsGradientGrey,
            )
          ],
          showingTooltipIndicators: [0],
        ),
      ];
}
