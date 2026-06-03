import 'package:smart_glove/features/patient/models/fingerdata.dart' show FingerData;
import 'package:smart_glove/features/patient/screens/result_page/widgets/finger_snapshot.dart';

class PatientSession {
  final String sessionId;
  final String exerciseId;
  final String patientNumber;
  final DateTime sessionDate;
  final Duration duration;
  final double progress;
  final int score;
  final FingerSnapshot gloveDataSummary; // متوسط القراءات في الجلسة
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

  factory PatientSession.fromJson(Map<String, dynamic> json) {
    return PatientSession(
      sessionId: json['sessionId'] ?? '',
      exerciseId: json['exerciseId'] ?? '',
      patientNumber: json['patientNumber'] ?? '',
      sessionDate: json['sessionDate'] != null
          ? DateTime.parse(json['sessionDate'])
          : DateTime.now(),
      duration: Duration(seconds: json['durationSeconds'] ?? 0),
      progress: (json['progress'] ?? 0).toDouble(),
      score: json['score'] ?? 0,
      gloveDataSummary: FingerSnapshot.fromJson(json['gloveDataSummary'] ?? {}),
      aiAnalysis: json['aiAnalysis'] ?? '',
    );
  }

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
    FingerSnapshot? gloveDataSummary,
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