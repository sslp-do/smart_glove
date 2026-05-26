import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchProvider extends ChangeNotifier{
  String searchQuery = "";

  void updateSearchQuery(String query){
    searchQuery = query;
    notifyListeners();
  }
}