import 'package:flutter/cupertino.dart';
import 'package:smart_glove/features/patient/models/exercise_model.dart';

class ExerciseProvider with ChangeNotifier {
  List<Exercise> _availableExercises = [];

  List<Exercise> get availableExercises => _availableExercises;

  Future<void> loadExercises() async {
    // جلب التمارين من الفايربيز
    // _availableExercises = await _exerciseRepository.getExercises();
    notifyListeners();
  }
}