import 'package:flutter/material.dart';

class NavigationProvider extends ChangeNotifier {
  bool _isCollapsed = false;

  String _currentRoute = "overview";

  String get currentRoute => _currentRoute;

  bool get isCollapsed => _isCollapsed;

  bool setCollapsed(bool value) {
    _isCollapsed = value;
    notifyListeners();
    return _isCollapsed;
  }


  void changeRoute(String newRoute) {
    _currentRoute = newRoute;
    notifyListeners();
  }
}
