import 'package:flutter/material.dart';

class FilterList extends ChangeNotifier{
  List<Map<String, dynamic> > _filterList = [{'개방여부': false},{'실내여부':false},{'환풍여부':false},{'청결함여부':false},{'크기':false},{'혼잡도':false}];
  List<List<String> > _filterItem = [['개방형', '폐쇄형'], ['실내', '실외'], ['환풍 o', '환풍 x'], ['청결함', '더러움'], ['대형', '소형'], ['혼잡함', '한적함']];

  List<Map<String, dynamic> > get filterList => _filterList;

  void changeFilterList(String filterKey, int filterVal){
    int index = _filterList.indexWhere((filter) => filter.containsKey(filterKey));

    // print(index);

    if (index != -1) {
      _filterList.removeAt(index);
      _filterList.insert(index,{filterKey: _filterItem[index][filterVal]});
      notifyListeners(); // 상태 변경 알림
    }
  }
   
}
