import 'package:flutter/material.dart';
import 'package:smart_glove/features/patient/models/fingerdata.dart';
import 'package:smart_glove/features/patient/models/session.dart';

class ReportsProvider with ChangeNotifier {
  List<PatientSession> _reports = [];
  bool _isLoading = false;
  String? _error;

  // Getters
  List<PatientSession> get reports => _reports;
  bool get isLoading => _isLoading;
  String? get error => _error;

  // أحدث جلسة (لعرضها كـ "NEW" في الأعلى)
  PatientSession? get latestReport =>
      _reports.isNotEmpty ? _reports.first : null;

  // جلب كل التقارير من Firestore
  Future<void> fetchReports(String patientId) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      // TODO: استبدل بـ Firestore call حقيقي
      // _reports = await _reportsRepository.getReports(patientId);

      // بيانات تجريبية مؤقتة
      _reports = [
        PatientSession(
          sessionId: "001",
          exerciseId: "full_fist_grip",
          patientNumber: patientId,
          sessionDate: DateTime.now(),
          duration: Duration(minutes: 15),
          progress: 0.85,
          score: 85,
          gloveDataSummary: FingerData(
            thumb: 80, index: 85, middle: 90, ring: 75, little: 70,
          ),
          aiAnalysis: "+12% Strength improvement detected.",
        ),
        PatientSession(
          sessionId: "002",
          exerciseId: "wrist_rotation",
          patientNumber: patientId,
          sessionDate: DateTime.now().subtract(Duration(days: 1)),
          duration: Duration(minutes: 10),
          progress: 0.60,
          score: 60,
          gloveDataSummary: FingerData(
            thumb: 60, index: 65, middle: 55, ring: 50, little: 45,
          ),
          aiAnalysis: "-10% Mobility regression detected.",
        ),  PatientSession(
          sessionId: "002",
          exerciseId: "wrist_rotation",
          patientNumber: patientId,
          sessionDate: DateTime.now().subtract(Duration(days: 1)),
          duration: Duration(minutes: 10),
          progress: 0.60,
          score: 60,
          gloveDataSummary: FingerData(
            thumb: 60, index: 65, middle: 55, ring: 50, little: 45,
          ),
          aiAnalysis: "-10% Mobility regression detected.",
        ),  PatientSession(
          sessionId: "002",
          exerciseId: "wrist_rotation",
          patientNumber: patientId,
          sessionDate: DateTime.now().subtract(Duration(days: 1)),
          duration: Duration(minutes: 10),
          progress: 0.60,
          score: 60,
          gloveDataSummary: FingerData(
            thumb: 60, index: 65, middle: 55, ring: 50, little: 45,
          ),
          aiAnalysis: "-10% Mobility regression detected.",
        ),  PatientSession(
          sessionId: "002",
          exerciseId: "wrist_rotation",
          patientNumber: patientId,
          sessionDate: DateTime.now().subtract(Duration(days: 1)),
          duration: Duration(minutes: 10),
          progress: 0.60,
          score: 60,
          gloveDataSummary: FingerData(
            thumb: 60, index: 65, middle: 55, ring: 50, little: 45,
          ),
          aiAnalysis: "-10% Mobility regression detected.",
        ),
      ];
    } catch (e) {
      _error = "Failed to load reports";
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // إضافة تقرير جديد بعد انتهاء الجلسة
  void addReport(PatientSession session) {
    _reports.insert(0, session); // أضفه في الأول كـ "NEW"
    notifyListeners();
  }
}