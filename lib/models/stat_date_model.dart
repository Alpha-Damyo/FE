class statDateModel {
  final Map<String, dynamic> hourlyInfo; //시간별 평균량(고정)
  final Map<String, dynamic> dailyInfo; //한달 기준 각 날의 평균(고정)
  final Map<String, dynamic> weeklyInfo; //한달 기준 각 주의 평균(이번 주가 4번째에 존재, 3주전이 1번째에)
  final Map<String, dynamic> monthlyInfo; //1년 기준 각 월의 퍙균(고정)
  final Map<String, dynamic> dayOfWeekInfo; //요일 기준 일주일의 평균

  statDateModel(this.hourlyInfo, this.dailyInfo, this.weeklyInfo,
      this.monthlyInfo, this.dayOfWeekInfo);
  @override
  String toString() {
    return '$hourlyInfo, $dailyInfo, $weeklyInfo, $monthlyInfo, $dayOfWeekInfo';
  }
}
