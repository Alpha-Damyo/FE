import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'dart:async';

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
  bool _isLoading = false;

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
                          maxY: 20,
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
                              maxY: 20,
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
        show: true,
        drawHorizontalLine: true,
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
              TextStyle(
                color: (compareCheck) ? Colors.cyan : Colors.grey,
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
        showTitles: true,
        interval: 1,
        reservedSize: 20,
      );

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

  // 일, 주, 월 데이터 받아와서 저장 및 등록
  List<double> UserAverDay = [12.2, 9.0, 3.4, 10.3, 2.8, 8.7, 9.4];
  List<double> EveryAverDay = [11.2, 19.0, 6.4, 17.3, 9.8, 18.7, 13.4];

  List<double> UserAverWeek = [12.2, 9.0, 3.4, 10.3];
  List<double> EveryAverWeek = [11.2, 19.0, 6.4, 17.3];

  List<double> UserAverMonth = [12.2, 9.0, 3.4, 10.3, 2.8, 8.7];
  List<double> EveryAverMonth = [11.2, 19.0, 6.4, 17.3, 9.8, 18.7];

  List<BarChartGroupData> get barDaysCompare => [
        for (int i = 0; i < UserAverDay.length; i++)
          makeGroupData(i, UserAverDay[i], EveryAverDay[i], compareCheck)
      ];
  List<BarChartGroupData> get barWeeksCompare => [
        for (int i = 0; i < UserAverWeek.length; i++)
          makeGroupData(i, UserAverWeek[i], EveryAverWeek[i], compareCheck)
      ];
  List<BarChartGroupData> get barMonthsCompare => [
        for (int i = 0; i < UserAverMonth.length; i++)
          makeGroupData(i, UserAverMonth[i], EveryAverMonth[i], compareCheck)
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
