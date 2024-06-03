class statRegionModel {
  final List<dynamic> allRegion; //모든 지역(구) 중 최고 순위
  final List<dynamic> areaTop; //흡연구역 중 최고 순위

  statRegionModel(this.allRegion, this.areaTop);
  @override
  String toString() {
    return '$allRegion, $areaTop';
  }
}
