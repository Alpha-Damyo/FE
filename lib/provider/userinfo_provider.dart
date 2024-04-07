import 'package:flutter/material.dart';

class UserInfoProvider with ChangeNotifier {
  String? _name;
  int? _age;
  //성별은 true면 남자, false면 여자
  bool? _gender;
  String? _nickname;
  int? _score = 0;

  String? get name => _name;
  int? get age => _age;
  bool? get gender => _gender;
  String? get nickname => _nickname;
  int? get score => _score;

  void setName(String name) {
    _name = name;
    notifyListeners();
  }

  void setAge(int age) {
    _age = age;
    notifyListeners();
  }

  void setGender(bool gender) {
    _gender = gender;
    notifyListeners();
  }

  void setNickname(String nickname) {
    _nickname = nickname;
    notifyListeners();
  }

  void setScore(int score) {
    _score = score;
    notifyListeners();
  }
}
