import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fl_chart/fl_chart.dart';

//index 2
bool timeCheck = true;

class timeAverInfo extends StatefulWidget {
  const timeAverInfo({super.key});

  @override
  State<timeAverInfo> createState() => _timeAverInfoState();
}

class _timeAverInfoState extends State<timeAverInfo> {
  //시간대별 정보
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.only(top: 20, left: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                '시간별 평균 흡연량',
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
}
