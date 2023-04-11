import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:shared_preferences/shared_preferences.dart';

// La class HomeProvider est la classe dédier pour gerer l'etat de l'application
class HomeProvider extends ChangeNotifier {
  // variable qui permet de dire si le mode sombre est activer ou pas
  bool _darkThemeIsActived = false;

  // declaration du thème de l'application
  late ThemeData _themeData = ThemeData(
      primarySwatch: Colors.purple,
      brightness: _darkThemeIsActived ? Brightness.dark : Brightness.light);

  // variable pour la synthèse vocal
  var flutterTts = FlutterTts();

  // variable gestion taille texte application
  // variable gestion style application
  var _customTextStyle = const TextStyle(fontSize: 18.0);

  // variable activation synthèse vocal
  bool activSynthe = true;

  bool get darkThemeIsActived => _darkThemeIsActived;

  ThemeData get themeData => _themeData;

  TextStyle? get customTextStyle => _customTextStyle;

  Future<bool>? get synthesIsActive async {
    var perf = await SharedPreferences.getInstance();
    return perf.getBool('activSynthe')!;
  }

  setTextStyle({double? fontSize}) {
    _customTextStyle = TextStyle(fontSize: fontSize);
    notifyListeners();
  }

  setsynthesIsActive(bool value) async {
    var perf = await SharedPreferences.getInstance();
    perf.setBool('activSynthe', value);
    activSynthe = value;
    notifyListeners();
  }

  changeAppTheme(bool value) {
    _darkThemeIsActived = value;
    notifyListeners();
  }

  // méthode changement thème
  changeTheme(ThemeData newTheme) {
    _themeData = newTheme;
    notifyListeners();
  }

  // méthode pour la synthèse vocal
  ftts(String text) async {
    if (activSynthe) {
      flutterTts.stop();
      await flutterTts.setLanguage('fr-FR');
      await flutterTts.setPitch(0.9);
      await flutterTts.speak(text);
    }
  }

  stopFtts() {
    flutterTts.stop();
  }
}
