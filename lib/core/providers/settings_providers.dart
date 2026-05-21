import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsProvider with ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system;
  bool _isDarkMode = ThemeMode.system== ThemeMode.dark;
  bool _notificationsEnabled = true;
  bool _isGloveConnected = false;

  // Getters
  ThemeMode get themeMode => _themeMode;
  bool get isDarkMode => _themeMode == ThemeMode.dark;
  bool get notificationsEnabled => _notificationsEnabled;
  bool get isGloveConnected => _isGloveConnected;

  // مفاتيح ثنائية لحفظ البيانات في ذاكرة الجهاز
  static const String _darkModeKey = 'is_dark_mode';
  static const String _notificationsKey = 'notifications_enabled';

  // Constructor: بمجرد خلق البروفايدر، نقرأ الإعدادات القديمة فوراً
  SettingsProvider() {
    _loadSettingsFromDevice();
  }

  void toggleTheme()  {
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
    _notificationsEnabled = prefs.getBool(_notificationsKey) ?? true;

    // نحدث الواجهة بالقيم الحقيقية المسترجعة من الذاكرة
    notifyListeners();
  }

  // 2. تعديل الدالة لتغير القيمة وتحفظها في الذاكرة بنفس الوقت
  Future<void> toggleDarkMode() async {
    _isDarkMode = !_isDarkMode;
    notifyListeners(); // نحدث الواجهة فوراً لسرعة الاستجابة للمستخدم

    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_darkModeKey, _isDarkMode); // حفظ دائم في الجهاز
  }

  // 3. تعديل دالة التنبيهات بنفس المنطق الرياضي الآمن
  Future<void> toggleNotifications() async {
    _notificationsEnabled = !_notificationsEnabled;
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_notificationsKey, _notificationsEnabled); // حفظ دائم في الجهاز
  }

  // بالنسبة للقفاز، الاتصال لحظي (Hardware Connection) فلا يجب حفظه بالذاكرة،
  // لأنه لو أغلق التطبيق وفتح، يجب أن يفحص هل القفاز متصل فيزيائياً الآن أم لا.
  void updateGloveConnection(bool status) {
    _isGloveConnected = status;
    notifyListeners();
  }
}