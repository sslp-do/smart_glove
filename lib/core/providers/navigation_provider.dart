import 'package:flutter/material.dart';

class NavigationProvider extends ChangeNotifier {

  String _currentRoute = "overview";

  String get currentRoute => _currentRoute;


  void changeRoute(String newRoute) {
    _currentRoute = newRoute;
    notifyListeners();
  }
}