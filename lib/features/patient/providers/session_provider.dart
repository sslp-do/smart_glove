import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:smart_glove/core/repository/glove_repository.dart';
import 'package:smart_glove/core/services/AIService.dart';
import 'package:smart_glove/features/patient/models/exercise_model.dart';
import 'package:smart_glove/features/patient/models/fingerdata.dart';
import 'package:smart_glove/features/patient/models/session.dart';


class SessionProvider with ChangeNotifier {

  Exercise? currentExercise;
  FingerData? currentGloveData;

  int _secondsElapsed = 0;
  Timer? _timer;
  bool _isSessionActive = false;
  double _completionPercentage = 0.0;
  String _currentHint = "Squeeze tight...";

  // --- Getters لتعامل الواجهة (UI) معها ---
  Exercise? get exercise => currentExercise;
  int get secondsElapsed => _secondsElapsed;
  bool get isSessionActive => _isSessionActive;
  double get completionPercentage => _completionPercentage;
  String get currentHint => _currentHint;


  StreamSubscription<FingerData>? _gloveSubscription;
  final GloveRepository _gloveRepo = GloveRepository();

  final AIService _aiService = AIService();

  // تنسيق الوقت المنقضي ليظهر كـ (00:00)
  String get formattedTime {
    final minutes = (_secondsElapsed ~/ 60).toString().padLeft(2, '0');
    final seconds = (_secondsElapsed % 60).toString().padLeft(2, '0');
    return "$minutes:$seconds";
  }

  // --- دالة بدء الجلسة ---
  void startSession(Exercise exercise) {
    currentExercise = exercise;
    _secondsElapsed = 0;
    _completionPercentage = 0.0;
    _isSessionActive = true;
    _startTimer();
    // بدلاً من انتظار تحديث يدوي، نحن نشترك في البيانات اللحظية
    _gloveSubscription = _gloveRepo.getLiveGloveData("patientId").listen((newData) {
      updateGloveData(newData); // هذه الدالة التي كتبناها سابقاً ستحسب النسبة وتحدث الـ UI
    });
    notifyListeners();
  }

  // --- دالة التايمر التصاعدي ---
  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      _secondsElapsed++;
      notifyListeners();
    });
  }

  // --- دالة تحديث بيانات القفاز (تستدعى من الـ Stream) ---
  void updateGloveData(FingerData newData) {
    if (!_isSessionActive) return;

    currentGloveData = newData;
    _calculateProgress();
    _updateHint();
    notifyListeners();
  }

  // --- منطق حساب نسبة الإنجاز ---
  void _calculateProgress() {
    if (currentExercise == null || currentGloveData == null) return;

    // مثال منطقي: جمع قيم الأصابع الحالية وتقسيمها على مجموع أهداف التمرين
    double currentSum = currentGloveData!.thumb + currentGloveData!.index +
        currentGloveData!.middle + currentGloveData!.ring + currentGloveData!.little;

    double targetSum = currentExercise!.targetData.thumb + currentExercise!.targetData.index +
        currentExercise!.targetData.middle + currentExercise!.targetData.ring + currentExercise!.targetData.little;

    if (targetSum > 0) {
      _completionPercentage = (currentSum / targetSum).clamp(0.0, 1.0);
    }
  }

  // --- منطق تغيير الهينت بناءً على الإنجاز ---
  void _updateHint() {
    if (_completionPercentage < 0.3) {
      _currentHint = "استمر، أنت في البداية!";
    } else if (_completionPercentage < 0.7) {
      _currentHint = "عمل رائع، اقتربت من نصف الهدف!";
    } else if (_completionPercentage < 0.9) {
      _currentHint = "قليل من الجهد الإضافي وستنهي الجلسة!";
    } else {
      _currentHint = "ممتاز! لقد حققت الهدف تقريباً.";
    }
  }

  // --- إنهاء الجلسة وحفظ البيانات (التقرير) ---
  Future<void> finishSession() async {
    // إغلاق الاشتراك فوراً عند انتهاء الجلسة
    await _gloveSubscription?.cancel();

    _timer?.cancel();
    _isSessionActive = false;


    // 2. بناء كائن الجلسة (PatientSession) للحفظ
    final finalSession = PatientSession(
      sessionId: DateTime.now().millisecondsSinceEpoch.toString(),
      exerciseId: currentExercise!.id,
      patientNumber: "P123", // يجب جلبه من ملف المريض
      sessionDate: DateTime.now(),
      duration: Duration(seconds: _secondsElapsed),
      progress: _completionPercentage,
      score: (_completionPercentage * 100).toInt(),
      gloveDataSummary: currentGloveData ?? FingerData(thumb: 0, index: 0, middle: 0, ring: 0, little: 0),
      aiAnalysis: "Processing...",
    );


    // 1. استدعاء الـ AI API (تمثيل للطلب)
    String aiResponse = await _aiService.getSessionAnalysis(finalSession);

    // 4. تحديث الكائن بالتحليل الحقيقي
    final finalSessionAnalyzed = finalSession.copyWith(aiAnalysis: aiResponse);

    // 5. حفظ الجلسة النهائية في Firestore (التقارير الهيستوري)
    // await _firestoreRepo.saveReport(finalSession);

    // 6. تحديث بيانات المريض التراكمية (الـ Streak والـ Total Sessions)
    // await _patientProvider.updateStatsAfterSession(finalSession.score);

    notifyListeners();
    notifyListeners();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  Path drawStar(Size size) {
    double degToRad(double deg) => deg * (pi / 180.0);
    const numberOfPoints = 5;
    final halfWidth = size.width / 2;
    final externalRadius = halfWidth;
    final internalRadius = halfWidth / 2.5;
    final degreesPerStep = degToRad(360 / numberOfPoints);
    final halfDegreesPerStep = degreesPerStep / 2;
    final path = Path();
    final fullAngle = degToRad(360);
    path.moveTo(size.width, halfWidth);

    for (double step = 0; step < fullAngle; step += degreesPerStep) {
      path.lineTo(halfWidth + externalRadius * cos(step), halfWidth + externalRadius * sin(step));
      path.lineTo(halfWidth + internalRadius * cos(step + halfDegreesPerStep), halfWidth + internalRadius * sin(step + halfDegreesPerStep));
    }
    path.close();
    return path;
  }
}