// [AI-GEN] Theme management with persistence.
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system;
  bool _notificationsEnabled = true;
  int _fontScaleIndex = 1;

  static const List<double> _fontScales = [0.9, 1.0, 1.15];
  static const List<String> _fontLabels = ['小', '中', '大'];

  ThemeMode get themeMode => _themeMode;
  bool get notificationsEnabled => _notificationsEnabled;
  double get fontScale => _fontScales[_fontScaleIndex];
  int get fontScaleIndex => _fontScaleIndex;
  String get fontSizeLabel => _fontLabels[_fontScaleIndex];

  ThemeProvider() {
    _load();
  }

  Future<void> _load() async {
    final prefs = await SharedPreferences.getInstance();
    final modeStr = prefs.getString('theme_mode') ?? 'system';
    _themeMode = _parseThemeMode(modeStr);
    _notificationsEnabled = prefs.getBool('notifications') ?? true;
    _fontScaleIndex = prefs.getInt('font_scale') ?? 1;
    notifyListeners();
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    _themeMode = mode;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('theme_mode', _serializeThemeMode(mode));
  }

  Future<void> setNotifications(bool v) async {
    _notificationsEnabled = v;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('notifications', v);
  }

  void increaseFont() {
    if (_fontScaleIndex < 2) {
      _fontScaleIndex++;
      notifyListeners();
      _saveFontScale();
    }
  }

  void decreaseFont() {
    if (_fontScaleIndex > 0) {
      _fontScaleIndex--;
      notifyListeners();
      _saveFontScale();
    }
  }

  Future<void> _saveFontScale() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('font_scale', _fontScaleIndex);
  }

  ThemeMode _parseThemeMode(String s) {
    switch (s) {
      case 'light':
        return ThemeMode.light;
      case 'dark':
        return ThemeMode.dark;
      default:
        return ThemeMode.system;
    }
  }

  String _serializeThemeMode(ThemeMode mode) {
    switch (mode) {
      case ThemeMode.light:
        return 'light';
      case ThemeMode.dark:
        return 'dark';
      default:
        return 'system';
    }
  }
}
