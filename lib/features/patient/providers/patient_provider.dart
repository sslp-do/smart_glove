import 'package:flutter/material.dart';
import 'package:smart_glove/features/patient/models/exercise_model.dart';
import 'package:smart_glove/features/patient/models/fingerdata.dart';
import 'package:smart_glove/features/patient/models/patient.dart';

class PatientProvider with ChangeNotifier {
  Patient? _currentPatient;
  bool _isLoading = false;
  Exercise? _nextExercise ;

  // Getters
  Exercise? get nextExercise => _nextExercise;

  Patient? get currentPatient => _currentPatient;

  bool get isLoading => _isLoading;

  // 1. (Dashboard)
  Future<void> fetchPatientData(String patientId) async {
    _isLoading = true;
    notifyListeners();
    try {
      // _currentPatient = await _patientRepository.getPatientProfile(patientId);

      _currentPatient = Patient(
        id: patientId,
        name: "Dounia Almassri",
        totalSessions: 45,
        streak: 5,
        improvement: 12.5,
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
      );
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

      _nextExercise = Exercise(
        id: "1002",
        title: "Full Grip",
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
      );
      notifyListeners();
    } catch (e) {
      print("Error fetching exercise data: $e");
    }
  }

  // 2. دالة لتحديث الـ Streak والسكور بعد انتهاء الجلسة
  // يتم استدعاؤها من الـ SessionProvider بعد نجاح الحفظ
  void updateStatsAfterSession(int newScore) {
    if (_currentPatient == null) return;

    // منطق بسيط لتحديث البيانات محلياً قبل المزامنة
    // (يمكنكِ زيادة عدد الجلسات وتحديث الـ Weekly Progress هنا)
    notifyListeners();
  }


}
