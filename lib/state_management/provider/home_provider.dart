import 'package:flutter/material.dart';

class HomeProvider extends ChangeNotifier {
  bool _darkThemeIsActived = false;
  late ThemeData _themeData = ThemeData(
      primarySwatch: Colors.purple,
      brightness: _darkThemeIsActived ? Brightness.dark : Brightness.light);

  bool get darkThemeIsActived => _darkThemeIsActived;
  ThemeData get themeData => _themeData;

  changeAppTheme(bool value) {
    _darkThemeIsActived = value;
    notifyListeners();
  }

  changeTheme(ThemeData newTheme) {
    _themeData = newTheme;
    notifyListeners();
  }
}
