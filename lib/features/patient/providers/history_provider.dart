import 'package:flutter/cupertino.dart';
import 'package:smart_glove/features/patient/models/session.dart';

class HistoryProvider with ChangeNotifier {
  List<PatientSession> _sessions = [];
  bool _isLoading = false;

  List<PatientSession> get sessions => _sessions;
  bool get isLoading => _isLoading;

  // جلب سجل الجلسات
  Future<void> fetchSessionHistory(String patientId) async {
    _isLoading = true;
    notifyListeners();

    // استدعاء الـ Repository لجلب قائمة الجلسات
    // _sessions = await _sessionRepository.getAllSessions(patientId);

    _isLoading = false;
    notifyListeners();
  }

  // دالة لجلب تفاصيل جلسة معينة عند الضغط عليها (لفتح صفحة التقرير)
  PatientSession getSessionById(String id) {
    return _sessions.firstWhere((s) => s.sessionId == id);
  }
}