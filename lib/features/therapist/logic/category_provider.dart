import 'package:flutter/material.dart';

class CategoryProvider extends ChangeNotifier {
  String selectedCategory = 'All';
  final List<Map<String, dynamic>> exercises = [
    {
      "title": "Full Fist Grip",
      "category": "Full Hand",
      "desc": "Improves overall grip strength.",
      "icon": Icons.back_hand,
      "difficulty": "Easy",
    },
    {
      "title": "Finger Extension",
      "category": "Fingers",
      "desc": "Stretches the flexor tendons.",
      "icon": Icons.pan_tool,
      "difficulty": "Medium",
    },
    {
      "title": "Wrist Rotation",
      "category": "Wrist",
      "desc": "Increases wrist mobility.",
      "icon": Icons.rotate_right,
      "difficulty": "Hard",
    },
    {
      "title": "Pinch Grip",
      "category": "Fingers",
      "desc": "Thumb and index finger coordination.",
      "icon": Icons.touch_app,
      "difficulty": "Medium",
    },
    {
      "title": "Thumb Flexion",
      "category": "Fingers",
      "desc": "Isolates thumb movement.",
      "icon": Icons.thumb_up,
      "difficulty": "Easy",
    },
    {
      "title": "Hand Spread",
      "category": "Full Hand",
      "desc": "Opens up the palm fully.",
      "icon": Icons.sign_language,
      "difficulty": "Easy",
    },
  ];

  late List<Map<String, dynamic>> filteredExercises = selectedCategory == 'All'
      ? exercises
      : exercises.where((e) => e['category'] == selectedCategory).toList();

  List<Map<String, dynamic>> getExercises() => exercises;

  String get selectCategory => selectedCategory;

  void updateSelectedCategory(String category) {
    selectedCategory = category;
    notifyListeners();
  }

  void updateFilteredExercises() {
    filteredExercises = selectedCategory == 'All'
        ? exercises
        : exercises.where((e) => e['category'] == selectedCategory).toList();
    notifyListeners();
  }
}