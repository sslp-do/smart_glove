import 'package:flutter/material.dart';
import 'package:smart_glove/features/patient/models/exercise_model.dart';
import 'package:smart_glove/features/patient/models/fingerdata.dart';
import 'package:smart_glove/features/patient/models/patient.dart';
import 'package:smart_glove/features/patient/providers/exercise_provider.dart';

class PatientProvider with ChangeNotifier {
  Patient? _currentPatient;
  bool _isLoading = false;
  Exercise? _nextExercise ;


  Exercise? get nextExercise => _nextExercise;
  Patient? get currentPatient => _currentPatient;
  bool get isLoading => _isLoading;

  set nextExercise(Exercise? exercise) {
    _nextExercise = exercise;
    notifyListeners();
  }

  // 1. (Dashboard)
  Future<void> fetchPatientData(String patientId) async {
    _isLoading = true;
    notifyListeners();
    try {
      // _currentPatient = await _patientRepository.getPatientProfile(patientId);
      _currentPatient = Patient(
        id: patientId,
        name: "katy hill",
        totalSessions: 45,
        streak: 5,
        recoveryProgress: 12.5,
        badges: [],
        weeklyProgress: {
          "Sat": 70,
          "Sun": 85,
          "Mon": 90,
          "Tue": 40,
          "Wed": 0,
          "Thu": 0,
          "Fri": 0,
        },
        affectedHand: "left",
        diagnosis: "wrist",
        status: "plateau",
        lastSessionTime: "21-2",
      );

      /* Exercise(
        id: "1002",
        name: "Full Grip",
        description: "Hand grip exercise",
        tutorialImageUrl: "",
        targetRepetitions: 0,
        duration: 3,
        targetData: FingerData(
          thumb: 0,
          index: 0,
          middle: 0,
          ring: 0,
          little: 0,
        ),
        difficulty: "Easy",
        category: "Full Hand",
      );*/

    } catch (e) {
      print("Error fetching patient data: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchNextExercise(String patientId) async {
    try {
      // _currentPatient = await _patientRepository.getPatientProfile(patientId);


      notifyListeners();
    } catch (e) {
      print("Error fetching exercise data: $e");
    }
  }

  // 2. دالة لتحديث الـ Streak والسكور بعد انتهاء الجلسة
  // يتم استدعاؤها من الـ SessionProvider بعد نجاح الحفظ
  void updateStatsAfterSession(int score) {
    if (_currentPatient == null) return;

    _currentPatient = _currentPatient!.copyWith(
      totalSessions: _currentPatient!.totalSessions + 1,
      streak: _currentPatient!.streak + 1,
    );
    notifyListeners();
  }


}
