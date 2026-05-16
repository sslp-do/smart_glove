import 'package:smart_glove/features/patient/models/fingerdata.dart' show FingerData;

class PatientSession {
  final String sessionId;
  final String exerciseId;
  final String patientNumber;
  final DateTime sessionDate;
  final Duration duration;
  final double progress;
  final int score;
  final FingerData gloveDataSummary; // متوسط القراءات في الجلسة
  final String aiAnalysis; // النص القادم من الـ API

  PatientSession({
    required this.sessionId,
    required this.exerciseId,
    required this.patientNumber,
    required this.sessionDate,
    required this.duration,
    required this.progress,
    required this.score,
    required this.gloveDataSummary,
    required this.aiAnalysis,
  });

  Map<String, dynamic> toJson() => {
    'sessionId': sessionId,
    'exerciseId': exerciseId,
    'patientNumber': patientNumber,
    'sessionDate': sessionDate.toIso8601String(),
    'durationSeconds': duration.inSeconds,
    'progress': progress,
    'score': score,
    'gloveDataSummary': gloveDataSummary.toJson(),
    'aiAnalysis': aiAnalysis,
  };

  PatientSession copyWith({
    String? sessionId,
    String? exerciseId,
    String? patientNumber,
    DateTime? sessionDate,
    Duration? duration,
    double? progress,
    int? score,
    FingerData? gloveDataSummary,
    String? aiAnalysis,
  }) {
    return PatientSession(
      // إذا مررنا قيمة جديدة نستخدمها، وإلا نستخدم القيمة القديمة (this)
      sessionId: sessionId ?? this.sessionId,
      exerciseId: exerciseId ?? this.exerciseId,
      patientNumber: patientNumber ?? this.patientNumber,
      sessionDate: sessionDate ?? this.sessionDate,
      duration: duration ?? this.duration,
      progress: progress ?? this.progress,
      score: score ?? this.score,
      gloveDataSummary: gloveDataSummary ?? this.gloveDataSummary,
      aiAnalysis: aiAnalysis ?? this.aiAnalysis,
    );
  }
}