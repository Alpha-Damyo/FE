import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class IsLoginProvider with ChangeNotifier {
  FlutterSecureStorage storage = const FlutterSecureStorage();
  bool _isLogin = false;
  bool _isFirst = true;

  bool get isLogin => _isLogin;
  bool get isFirst => _isFirst;

  void login() {
    _isLogin = true;
    notifyListeners();
  }

  void logout() async {
    _isLogin = false;
    _isFirst = true;
    await storage.deleteAll();
    notifyListeners();
  }

  void checkFirst() async {
    //추후 서버 연결시 토큰으로 확인
    _isFirst = false;
    notifyListeners();
  }
}
