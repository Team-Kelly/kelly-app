import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

class PersonalInfo extends ChangeNotifier {
  bool _isFirst = true;
  late String _name;

  bool get isFirst => _isFirst;
  String get name => _name;

  void visit() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isFirst', false);
    notifyListeners();
  }

  void reverse() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isFirst', true);
    notifyListeners();
  }

  void nameChange(String input) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('name', input);
    notifyListeners();
  }

  void loadinfo() async {
    final prefs = await SharedPreferences.getInstance();
    _isFirst = prefs.getBool('isFirst') ?? true;
    _name = prefs.getString('name') ?? '아무개';
    notifyListeners();
  }
}
