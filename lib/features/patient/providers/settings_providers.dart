import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsProvider with ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system;
  bool _isDarkMode = ThemeMode.system== ThemeMode.dark;
  bool _soundsEnabled = true;
  bool _isGloveConnected = false;

  // Getters
  ThemeMode get themeMode => _themeMode;
  bool get isDarkMode => _themeMode == ThemeMode.dark;
  bool get notificationsEnabled => _soundsEnabled;
  bool get isGloveConnected => _isGloveConnected;

  // مفاتيح ثنائية لحفظ البيانات في ذاكرة الجهاز
  static const String _darkModeKey = 'is_dark_mode';
  static const String _soundsKey = 'sounds_enabled';

  // Constructor: بمجرد خلق البروفايدر، نقرأ الإعدادات القديمة فوراً
  SettingsProvider() {
    _loadSettingsFromDevice();
  }

  void toggleTheme() async {
    _isDarkMode = !_isDarkMode;
    _themeMode = _isDarkMode ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
      final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_darkModeKey, _isDarkMode); // حفظ دائم في الجهاز
  }

  // 1. دالة جلب الإعدادات من ذاكرة الجهاز عند فتح التطبيق
  Future<void> _loadSettingsFromDevice() async {
    final prefs = await SharedPreferences.getInstance();

    // إذا لم يجد قيمة قديمة (أول مرة يفتح التطبيق)، سيعتمد القيمة البديلة المكتوبة بعد ??
    _isDarkMode = prefs.getBool(_darkModeKey) ?? false;
    _soundsEnabled = prefs.getBool(_soundsKey) ?? true;

    notifyListeners();
  }

  Future<void> toggleSound() async {
    _soundsEnabled = !_soundsEnabled;
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_soundsKey, _soundsEnabled); // حفظ دائم في الجهاز
  }

  void updateGloveConnection(bool status) {
    _isGloveConnected = status;
    notifyListeners();
  }
}