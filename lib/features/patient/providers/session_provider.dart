/*
import 'dart:async';
import 'dart:math';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:smart_glove/core/models/session_data_aggregator.dart';
import 'package:smart_glove/core/repository/glove_repository.dart';
import 'package:smart_glove/core/providers/AIService.dart';
import 'package:smart_glove/Test/ai_payload.dart';
import 'package:smart_glove/features/patient/models/exercise_model.dart';
import 'package:smart_glove/features/patient/models/fingerdata.dart';
import 'package:smart_glove/features/patient/models/session.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

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
  bool _isAiUploading = false;

  bool get isAiUploading => _isAiUploading;

  StreamSubscription<DatabaseEvent>? _gloveSubscription;

  // final GloveRepository _gloveRepo = GloveRepository();

  final AIService _aiService = AIService();

  // تنسيق الوقت المنقضي ليظهر كـ (00:00)
  String get formattedTime {
    final minutes = (_secondsElapsed ~/ 60).toString().padLeft(2, '0');
    final seconds = (_secondsElapsed % 60).toString().padLeft(2, '0');
    return "$minutes:$seconds";
  }

  String? currentFirebaseSessionKey;

  //String? get firebaseSessionKey => currentFirebaseSessionKey;


  // --- دالة بدء الجلسة ---
  void startSession(Exercise exercise) {
    currentExercise = exercise;
    _secondsElapsed = 0;
    _completionPercentage = 0.0;
    _isSessionActive = true;
    _startTimer();

    _gloveSubscription?.cancel();

    // بدلاً من انتظار تحديث يدوي، نحن نشترك في البيانات اللحظية
      _gloveSubscription = FirebaseDatabase.instance
        .ref("sessions/$currentFirebaseSessionKey/readings")
        .limitToLast(1)
        .onValue
        .listen((DatabaseEvent event) {
          if (!_isSessionActive || event.snapshot.value == null) return;

          try {
            // تفكيك الداتا القادمة من الفايربيز بناءً على الهيكلية الظاهرة بالصورة
            Map<dynamic, dynamic> readingsMap =
                event.snapshot.value as Map<dynamic, dynamic>;
            var lastPushKey = readingsMap.keys.first;
            var fingersData = readingsMap[lastPushKey]['fingers'];

            if (fingersData != null) {
              // تحويل الداتا الحية لكائن FingerData يفهمه تطبيقكِ والـ Visualization
              FingerData newData = FingerData(
                thumb: (fingersData['Thumb']?['angle'] ?? 0.0).toDouble(),
                index: (fingersData['Index']?['angle'] ?? 0.0).toDouble(),
                middle: (fingersData['Middle']?['angle'] ?? 0.0).toDouble(),
                ring: (fingersData['Ring']?['angle'] ?? 0.0).toDouble(),
                // دعم مرن لاسم الخنصر سواء كان Pinky أو little
                little:
                    ((fingersData['Pinky'] ??
                                fingersData['little'] ??
                                fingersData['Little'])?['angle'] ??
                            0.0)
                        .toDouble(),
              );

              // تحديث البروفايدر والـ UI لحظياً بالزوايا الجديدة
              updateGloveData(newData);
            }
          } catch (e) {
            print("❌ خطأ أثناء التقاط القراءة اللحظية: $e");
          }
        });

    notifyListeners();

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
    double currentSum =
        currentGloveData!.thumb +
        currentGloveData!.index +
        currentGloveData!.middle +
        currentGloveData!.ring +
        currentGloveData!.little;

    double targetSum =
        currentExercise!.targetData.thumb +
        currentExercise!.targetData.index +
        currentExercise!.targetData.middle +
        currentExercise!.targetData.ring +
        currentExercise!.targetData.little;

    if (targetSum > 0) {
      _completionPercentage = (currentSum / targetSum).clamp(0.0, 1.0);
    }
  }

  // --- منطق تغيير الهينت بناءً على الإنجاز ---
  void _updateHint() {
    if (_completionPercentage < 0.3) {
      _currentHint = "Good Start, Continue!";
    } else if (_completionPercentage < 0.7) {
      _currentHint = "Nice work, you are getting there!";
    } else if (_completionPercentage < 0.9) {
      _currentHint = "A little more and you are there...";
    } else {
      _currentHint = "Great...You did it !";
    }

  }
  Future<void> uploadSessionToAi({
    required String patientName,
    required int patientAge,
    required String diagnosis,
    required int currentTotalSessions,
    required int durationMinutes,
    required String firebaseSessionKey,
  }) async {
    _isAiUploading = true;
    notifyListeners();

    try {
      int nextSessionNumber = currentTotalSessions + 1;

      // 👈 استدعاء الـ Aggregator الخارجي للقيام بالمعالجة والتجميع بشكل منفصل تماماً
      AiPayloadAdapter finalPayload =
          await SessionDataAggregator.buildAiPayloadFromFirebase(
            firebaseSessionKey: firebaseSessionKey,
            patientName: patientName,
            patientAge: patientAge,
            diagnosis: diagnosis,
            sessionNumber: nextSessionNumber,
            durationMinutes: durationMinutes,
          );

      // الـ Provider يكتفي فقط بمهمة الرفع والاتصال بقاعدة البيانات
      String targetSessionId =
          "${patientName.replaceAll(' ', '_')}_s$nextSessionNumber";
      await FirebaseDatabase.instance
          .ref("sessions/$targetSessionId")
          .set(finalPayload.toJson());

      print("🎯 تم الرفع بنجاح بعد تطبيق مبدأ Separation of Concerns!");
    } catch (e) {
      print("❌ خطأ أثناء الرفع: $e");
    } finally {
      _isAiUploading = false;
      notifyListeners();
    }
  }

  // --- إنهاء الجلسة وحفظ البيانات (التقرير) ---
  Future<void> finishSession() async {
    await _gloveSubscription?.cancel();

    _timer?.cancel();
    _isSessionActive = false;

    final finalSession = PatientSession(
      sessionId: DateTime.now().millisecondsSinceEpoch.toString(),
      exerciseId: currentExercise!.id,
      patientNumber: "P123",
      // يجب جلبه من ملف المريض
      sessionDate: DateTime.now(),
      duration: Duration(seconds: _secondsElapsed),
      progress: _completionPercentage,
      score: (_completionPercentage * 100).toInt(),
      gloveDataSummary:
          currentGloveData ??
          FingerData(thumb: 0, index: 0, middle: 0, ring: 0, little: 0),
      aiAnalysis: "Processing...",
    );

    // 1. استدعاء الـ AI API (تمثيل للطلب)
    // String aiResponse = await _aiService.getSessionAnalysis(finalSession);

    // 4. تحديث الكائن بالتحليل الحقيقي
    // final finalSessionAnalyzed = finalSession.copyWith(aiAnalysis: aiResponse);

    // 5. حفظ الجلسة النهائية في Firestore (التقارير الهيستوري)
    // await _firestoreRepo.saveReport(finalSession);

    // 6. تحديث بيانات المريض التراكمية (الـ Streak والـ Total Sessions)
    // await _patientProvider.updateStatsAfterSession(finalSession.score);

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
      path.lineTo(
        halfWidth + externalRadius * cos(step),
        halfWidth + externalRadius * sin(step),
      );
      path.lineTo(
        halfWidth + internalRadius * cos(step + halfDegreesPerStep),
        halfWidth + internalRadius * sin(step + halfDegreesPerStep),
      );
    }
    path.close();
    return path;
  }
}
*/ /*

import 'dart:async';
import 'dart:math';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:smart_glove/core/models/session_data_aggregator.dart';
import 'package:smart_glove/core/repository/glove_repository.dart';
import 'package:smart_glove/core/providers/AIService.dart';
import 'package:smart_glove/Test/ai_payload.dart';
import 'package:smart_glove/features/patient/models/exercise_model.dart';
import 'package:smart_glove/features/patient/models/fingerdata.dart';
import 'package:smart_glove/features/patient/models/session.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

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

  bool _isAiUploading = false;
  bool get isAiUploading => _isAiUploading;

  StreamSubscription<DatabaseEvent>? _gloveSubscription;
  final AIService _aiService = AIService();

  // تنسيق الوقت المنقضي ليظهر كـ (00:00)
  String get formattedTime {
    final minutes = (_secondsElapsed ~/ 60).toString().padLeft(2, '0');
    final seconds = (_secondsElapsed % 60).toString().padLeft(2, '0');
    return "$minutes:$seconds";
  }

  String? currentFirebaseSessionKey;

  // --- دالة بدء الجلسة ---
  void startSession(Exercise exercise) {
    currentExercise = exercise;
    _secondsElapsed = 0;
    _completionPercentage = 0.0;
    _isSessionActive = true;
    _startTimer();

    _gloveSubscription?.cancel();

    // الاشتراك اللحظي لقراءة حركة الأصابع وتحديث الـ UI
    _gloveSubscription = FirebaseDatabase.instance
        .ref("sessions/$currentFirebaseSessionKey/readings")
        .limitToLast(1)
        .onValue
        .listen((DatabaseEvent event) {
      if (!_isSessionActive || event.snapshot.value == null) return;

      try {
        Map<dynamic, dynamic> readingsMap = event.snapshot.value as Map<dynamic, dynamic>;
        var lastPushKey = readingsMap.keys.first;
        var fingersData = readingsMap[lastPushKey]['fingers'];

        if (fingersData != null) {
          FingerData newData = FingerData(
            thumb: (fingersData['Thumb']?['degree'] ?? 0.0).toDouble(), // تعديل لـ degree ليتوافق مع الهاردوير
            index: (fingersData['Index']?['degree'] ?? 0.0).toDouble(),
            middle: (fingersData['Middle']?['degree'] ?? 0.0).toDouble(),
            ring: (fingersData['Ring']?['degree'] ?? 0.0).toDouble(),
            little: ((fingersData['Pinky'] ?? fingersData['little'] ?? fingersData['Little'])?['degree'] ?? 0.0).toDouble(),
          );

          updateGloveData(newData);
        }
      } catch (e) {
        print("❌ خطأ أثناء التقاط القراءة اللحظية: $e");
      }
    });

    notifyListeners();
  }

  // --- دالة التايمر التصاعدي ---
  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_isSessionActive) {
        _secondsElapsed++;
        notifyListeners();
      }
    });
  }

  // --- دالة تحديث بيانات القفاز ---
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

    double currentSum =
        currentGloveData!.thumb +
            currentGloveData!.index +
            currentGloveData!.middle +
            currentGloveData!.ring +
            currentGloveData!.little;

    double targetSum =
        currentExercise!.targetData.thumb +
            currentExercise!.targetData.index +
            currentExercise!.targetData.middle +
            currentExercise!.targetData.ring +
            currentExercise!.targetData.little;

    if (targetSum > 0) {
      _completionPercentage = (currentSum / targetSum).clamp(0.0, 1.0);
    }
  }

  // --- منطق تغيير الإرشادات بناءً على الإنجاز ---
  void _updateHint() {
    if (_completionPercentage < 0.3) {
      _currentHint = "Good Start, Continue!";
    } else if (_completionPercentage < 0.7) {
      _currentHint = "Nice work, you are getting there!";
    } else if (_completionPercentage < 0.9) {
      _currentHint = "A little more and you are there...";
    } else {
      _currentHint = "Great...You did it !";
    }
  }

  // --- رفع الجلسة وتجميع الـ AI Payload ---
  Future<void> uploadSessionToAi({
    required String patientName,
    required int patientAge,
    required String diagnosis,
    required int currentTotalSessions,
    required int durationMinutes,
    required String firebaseSessionKey,
  }) async {
    _isAiUploading = true;
    notifyListeners();

    try {
      int nextSessionNumber = currentTotalSessions + 1;

      AiPayloadAdapter finalPayload =
      await SessionDataAggregator.buildAiPayloadFromFirebase(
        firebaseSessionKey: firebaseSessionKey,
        patientName: patientName,
        patientAge: patientAge,
        diagnosis: diagnosis,
        sessionNumber: nextSessionNumber,
        durationMinutes: durationMinutes,
      );

      String targetSessionId = "${patientName.replaceAll(' ', '_')}_s$nextSessionNumber";
      await FirebaseDatabase.instance
          .ref("sessions/$targetSessionId")
          .set(finalPayload.toJson());

      print("🎯 تم الرفع بنجاح بعد تطبيق مبدأ Separation of Concerns!");
    } catch (e) {
      print("❌ خطأ أثناء الرفع: $e");
    } finally {
      _isAiUploading = false;
      notifyListeners();
    }
  }

  // --- إنهاء الجلسة وتجميع التقرير النهائي بسلام ---
  Future<void> finishSession() async {
    final sessionKey = currentFirebaseSessionKey;

    if (sessionKey == null) {
      print("❌ لا يوجد جلسة نشطة حالياً لإنهائها");
      return;
    }

    try {
      print("⏳ بدء إنهاء الجلسة وتجميع الملخص من السيرفر لجلسة: $sessionKey...");
      _isSessionActive = false;
      _timer?.cancel(); // إيقاف التايمر فوراً هنا
      await _gloveSubscription?.cancel();

      // 1. قراءة عقدة الـ summary الجاهزة عبر الـ REST API لحماية الديسكتوب
      final url = Uri.parse("https://ai-glove-default-rtdb.firebaseio.com/sessions/$sessionKey/summary.json");
      final response = await http.get(url);

      FingerData summaryGloveData = FingerData(thumb: 0, index: 0, middle: 0, ring: 0, little: 0);

      if (response.statusCode == 200 && response.body != 'null') {
        final Map<String, dynamic> summaryMap = json.decode(response.body) as Map<String, dynamic>;
        final fingersData = summaryMap['fingers'];

        if (fingersData != null) {
          summaryGloveData = FingerData(
            thumb: (fingersData['Thumb']?['rom'] ?? 0.0).toDouble(),
            index: (fingersData['Index']?['rom'] ?? 0.0).toDouble(),
            middle: (fingersData['Middle']?['rom'] ?? 0.0).toDouble(),
            ring: (fingersData['Ring']?['rom'] ?? 0.0).toDouble(),
            little: (fingersData['Pinky']?['rom'] ?? 0.0).toDouble(),
          );
        }
        print("🟢 تم جلب ملخص القفاز بنجاح (ROM السبابة = ${summaryGloveData.index})");
      }

      // 2. بناء كائن الـ التقرير الطبي باستخدام المتغير المحمي _secondsElapsed
      final finalSessionReport = {
        "sessionId": sessionKey,
        "date": DateFormat('yyyy-MM-DD').format(DateTime.now()),
        "durationInSeconds": _secondsElapsed, // 🎯 تم التصحيح: استخدام المتغير المحلي السليم بدلاً من التايمر المفقود
        "progressPercentage": _completionPercentage,
        "gloveDataSummary": summaryGloveData.toJson(),
      };

      // 3. حفظ التقرير الطبي الكامل تحت مجلد الجلسة
      final saveUrl = Uri.parse("https://ai-glove-default-rtdb.firebaseio.com/sessions/$sessionKey/report.json");
      final saveResponse = await http.put(saveUrl, body: json.encode(finalSessionReport));

      if (saveResponse.statusCode == 200) {
        print("🎯 نصر برمجياً! تم توثيق تقرير الجلسة الطبي بالكامل في الفايربيز");
      } else {
        print("❌ فشل حفظ تقرير الجلسة في السيرفر: ${saveResponse.body}");
      }

    } catch (e) {
      print("❌ حدث خطأ غير متوقع أثناء محاولة إنهاء الجلسة: $e");
    } finally {
      // 4. تصفير العدادات والتحضير بأمان للجلسة القادمة
      _secondsElapsed = 0; // 🎯 تم التصحيح: تصفير العداد المحلي المعتمد بدلاً من الكائن الخارجي
      notifyListeners();
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    _gloveSubscription?.cancel();
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
      path.lineTo(
        halfWidth + externalRadius * cos(step),
        halfWidth + externalRadius * sin(step),
      );
      path.lineTo(
        halfWidth + internalRadius * cos(step + halfDegreesPerStep),
        halfWidth + internalRadius * sin(step + halfDegreesPerStep),
      );
    }
    path.close();
    return path;
  }
}*/
import 'dart:async';
import 'dart:math';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:smart_glove/core/models/session_data_aggregator.dart';
import 'package:smart_glove/core/repository/glove_data_services.dart';
import 'package:smart_glove/core/repository/glove_repository.dart';
import 'package:smart_glove/core/providers/AIService.dart';
import 'package:smart_glove/Test/ai_payload.dart';
import 'package:smart_glove/features/patient/models/exercise_model.dart';
import 'package:smart_glove/features/patient/models/fingerdata.dart';
import 'package:smart_glove/features/patient/models/session.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:smart_glove/features/patient/screens/result_page/widgets/finger_snapshot.dart';

class SessionProvider with ChangeNotifier {
  Exercise? currentExercise;
  FingerSnapshot currentGloveData = FingerSnapshot(
    thumb: 0,
    index: 0,
    middle: 0,
    ring: 0,
    pinky: 0,
  );
  int _secondsElapsed = 0;
  Timer? _timer;
  bool _isSessionActive = false;
  double _completionPercentage = 0.0;
  String _currentHint = "Squeeze tight...";
  bool _isAiUploading = false;

  StreamSubscription? _gloveSubscription;

  // final AIService _aiService = AIService();
  String? currentFirebaseSessionKey;

  GloveRepository _gloveRepository = GloveRepository();

  Map<String, dynamic> finalSessionReport = {
    "sessionId": 'currentFirebaseSessionKey',
    "date": DateFormat('yyyy-MM-DD').format(DateTime.now()),
    "durationInSeconds": 0,
    "progressPercentage": 0,
    "gloveDataSummary": FingerSnapshot(
      thumb: 0,
      index: 0,
      middle: 0,
      ring: 0,
      pinky: 0,
    ).toJson(),
  };

  Exercise? get exercise => currentExercise;

  int get secondsElapsed => _secondsElapsed;

  bool get isSessionActive => _isSessionActive;

  double get completionPercentage => _completionPercentage;

  String get currentHint => _currentHint;

  bool get isAiUploading => _isAiUploading;

  String get formattedTime {
    final minutes = (_secondsElapsed ~/ 60).toString().padLeft(2, '0');
    final seconds = (_secondsElapsed % 60).toString().padLeft(2, '0');
    return "$minutes:$seconds";
  }

  void startSession(Exercise exercise) {
    currentExercise = exercise;
    _secondsElapsed = 0;
    _completionPercentage = 0.0;
    _isSessionActive = true;

    _startTimer();
    _gloveSubscription?.cancel();

    _gloveSubscription = _gloveRepository.listenToLatestSessionLive().listen((
      Map<dynamic, dynamic> sessionUpdate,
    ) {
      if (!_isSessionActive) return;

      try {
        currentFirebaseSessionKey = sessionUpdate['sessionKey'];

        var fingers = sessionUpdate['fingers'];
        if (fingers != null) {
          double thumb =
              (fingers['Thumb']?['degree'] ?? fingers['Thumb']?['angle'] ?? 0.0)
                  .toDouble();
          double index =
              (fingers['Index']?['degree'] ?? fingers['Index']?['angle'] ?? 0.0)
                  .toDouble();
          double middle =
              (fingers['Middle']?['degree'] ??
                      fingers['Middle']?['angle'] ??
                      0.0)
                  .toDouble();
          double ring =
              (fingers['Ring']?['degree'] ?? fingers['Ring']?['angle'] ?? 0.0)
                  .toDouble();
          double little =
              ((fingers['Pinky'] ??
                          fingers['little'] ??
                          fingers['Little'])?['degree'] ??
                      (fingers['Pinky'] ??
                          fingers['little'] ??
                          fingers['Little'])?['angle'] ??
                      0.0)
                  .toDouble();

          final currentData = FingerSnapshot(
            thumb: thumb,
            index: index,
            middle: middle,
            ring: ring,
            pinky: little,
          );

          // ج) ضخ الداتا للبروفايدر ليقوم بتحريك التايمر والـ progress بالتزامن المباشر
          updateGloveData(currentData);
        }
      } catch (e) {
        print("❌ Error while streaming from the glove $e");
      }
    });


    // حساب الإنجاز والهينت تلقائياً بالتزامن مع البيانات الجديدة
    _calculateProgress();
    _updateHint();

    notifyListeners();
  }

  // 🎯 دالة تحويل شكل الأصابع من النظام المحلي لتطبيقكِ إلى النظام الذي يطلبه الـ AI بالملي
  List<Map<String, dynamic>> buildFingersListForAi(
    FingerData summaryGloveData,
  ) {
    return [
      {
        "name": "Thumb",
        "angles": [summaryGloveData.thumb, summaryGloveData.thumb],
        // الـ AI يحتاج مصفوفة زوايا لتأكيد الاستقرار
        "rom": summaryGloveData.thumb,
        "tam": summaryGloveData.thumb * 0.9,
        // الـ AI يحسب الـ TAM تلقائياً، نعطيه قيمة تقريبية للأمان
        "prev_rom": summaryGloveData.thumb,
        // للأمان نثبته على الـ ROM الحالي في أول جلسة
      },
      {
        "name": "Index",
        "angles": [summaryGloveData.index, summaryGloveData.index],
        "rom": summaryGloveData.index,
        "tam": summaryGloveData.index * 0.9,
        "prev_rom": summaryGloveData.index,
      },
      {
        "name": "Middle",
        "angles": [summaryGloveData.middle, summaryGloveData.middle],
        "rom": summaryGloveData.middle,
        "tam": summaryGloveData.middle * 0.9,
        "prev_rom": summaryGloveData.middle,
      },
      {
        "name": "Ring",
        "angles": [summaryGloveData.ring, summaryGloveData.ring],
        "rom": summaryGloveData.ring,
        "tam": summaryGloveData.ring * 0.9,
        "prev_rom": summaryGloveData.ring,
      },
      {
        "name": "Pinky",
        "angles": [summaryGloveData.little, summaryGloveData.little],
        "rom": summaryGloveData.little,
        "tam": summaryGloveData.little * 0.9,
        "prev_rom": summaryGloveData.little,
      },
    ];
  }

  // 🎯 دالة تجهيز كائن المريض والجلسة بالشكل والمسميات التي يطلبها الـ AI بالملي
  Map<String, dynamic> buildPatientMapForAi(dynamic patient, int secondsElapsed) {
    return {
      "name": patient?.name ?? "Katy Hill", // جلب الاسم الحقيقي أو الافتراضي من كودكِ
      "age": 45, // الـ AI يحتاج القيمة كرقم (int)
      "diagnosis": patient?.diagnosis ?? "Wrist plateau", // جلب التشخيص الحقيقي من البروفايدر
      "therapist": "Dr. Sara Khalil, PT", // اسم المعالج الافتراضي للأمان
      "session_number": (patient?.totalSessions ?? 45) + 1, // رقم الجلسة القادمة تلقائياً
      "session_date": "25 May 2026", // تنسيق التاريخ النصي الذي يطلبه السيرفر
      "duration_min": secondsElapsed ~/ 60, // تحويل الثواني المنقضية إلى دقائق كاملة
    };
  }

  // --- دالة التايمر التصاعدي التلقائي وحساب الإنجاز اللحظي ---
  void _startTimer() {
    _timer?.cancel(); // إلغاء أي تايمر قديم للأمان
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_isSessionActive) {
        _secondsElapsed++;

        // 🎯 استدعاء حساب الإنجاز وتحديث الهينت كل ثانية بانتظام لضمان حركية الواجهة
        _calculateProgress();
        _updateHint();

        notifyListeners(); // تحديث الواجهة تلقائياً بالثانية الجديدة ونسبة الإنجاز
      }
    });
  }

  // --- دالة تحديث بيانات القفاز القادمة من الـ Stream ---
  void updateGloveData(FingerSnapshot newData) {
    if (!_isSessionActive) return;

    currentGloveData = newData;
    _calculateProgress();
    _updateHint();
    notifyListeners();
  }

  // --- منطق حساب نسبة الإنجاز الديناميكي ---
  void _calculateProgress() {
    if (currentExercise == null) return;

    // جمع قيم زوايا الأصابع الحالية للقفاز
    double currentSum =
        currentGloveData.thumb +
        currentGloveData.index +
        currentGloveData.ring +
        currentGloveData.middle +
        currentGloveData.pinky;

    // جمع قيم الزوايا المستهدفة (الهدف التمريني)
    double targetSum =
        currentExercise!.targetData.thumb +
        currentExercise!.targetData.index +
        currentExercise!.targetData.middle +
        currentExercise!.targetData.ring +
        currentExercise!.targetData.little;

    if (targetSum > 0) {
      // حساب النسبة المئوية وحصرها بين 0.0 و 1.0 (0% إلى 100%)
      _completionPercentage = (currentSum / targetSum).clamp(0.0, 1.0);
    }
  }

  // --- منطق تغيير الإرشادات (Hints) بناءً على نسبة الإنجاز الحالية ---
  void _updateHint() {
    if (_completionPercentage < 0.3) {
      _currentHint = "Good Start, Continue!";
    } else if (_completionPercentage < 0.7) {
      _currentHint = "Nice work, you are getting there!";
    } else if (_completionPercentage < 0.9) {
      _currentHint = "A little more and you are there...";
    } else {
      _currentHint = "Great...You did it !";
    }
  }

  // --- رفع الجلسة وتجميع الـ AI Payload ---
  Future<void> uploadSessionToAi({
    required String patientName,
    required int patientAge,
    required String diagnosis,
    required int currentTotalSessions,
    required int durationMinutes,
    required String firebaseSessionKey,
  }) async {
    _isAiUploading = true;
    notifyListeners();

    try {
      int nextSessionNumber = currentTotalSessions + 1;

      AiPayloadAdapter finalPayload =
          await SessionDataAggregator.buildAiPayloadFromFirebase(
            firebaseSessionKey: firebaseSessionKey,
            patientName: patientName,
            patientAge: patientAge,
            diagnosis: diagnosis,
            sessionNumber: nextSessionNumber,
            durationMinutes: durationMinutes,
          );

      String targetSessionId =
          "${patientName.replaceAll(' ', '_')}_s$nextSessionNumber";
      await FirebaseDatabase.instance
          .ref("sessions/$targetSessionId")
          .set(finalPayload.toJson());

      print("🎯 تم الرفع بنجاح بعد تطبيق مبدأ Separation of Concerns!");
    } catch (e) {
      print("❌ خطأ أثناء الرفع: $e");
    } finally {
      _isAiUploading = false;
      notifyListeners();
    }
  }

  // --- إنهاء الجلسة وحفظ البيانات (التقرير) بسلام ---
  Future<void> finishSession() async {
    final sessionKey = currentFirebaseSessionKey;

    if (sessionKey == null) {
      print("❌ لا يوجد جلسة نشطة حالياً لإنهائها");
      return;
    }
    try {
      print(
        "⏳ بدء إنهاء الجلسة وتجميع الملخص من السيرفر لجلسة: $sessionKey...",
      );
      _isSessionActive = false;
      _timer?.cancel();

      await _gloveSubscription?.cancel();

      final url = Uri.parse(
        "https://ai-glove-default-rtdb.firebaseio.com/sessions/$sessionKey/summary.json",
      );
      final response = await http.get(url);

      FingerData summaryGloveData = FingerData(
        thumb: 0,
        index: 0,
        middle: 0,
        ring: 0,
        little: 0,
      );

      if (response.statusCode == 200 && response.body != 'null') {
        final Map<String, dynamic> summaryMap =
            json.decode(response.body) as Map<String, dynamic>;
        final fingersData = summaryMap['fingers'];

        if (fingersData != null) {
          summaryGloveData = FingerData(
            thumb: (fingersData['Thumb']?['rom'] ?? 0.0).toDouble(),
            index: (fingersData['Index']?['rom'] ?? 0.0).toDouble(),
            middle: (fingersData['Middle']?['rom'] ?? 0.0).toDouble(),
            ring: (fingersData['Ring']?['rom'] ?? 0.0).toDouble(),
            little: (fingersData['Pinky']?['rom'] ?? 0.0).toDouble(),
          );
        }
        print(
          "🟢 تم جلب ملخص القفاز بنجاح (ROM السبابة = ${summaryGloveData.index})",
        );
      }

      finalSessionReport = {
        "sessionId": sessionKey,
        "date": DateFormat('yyyy-MM-dd').format(DateTime.now()),
        "durationInSeconds": _secondsElapsed,
        // 🎯 تثبيت الوقت الذي تم قضاؤه بالتفصيل في ملف الحفظ
        "progressPercentage": _completionPercentage,
        "gloveDataSummary": summaryGloveData.toJson(),
      };

      final saveUrl = Uri.parse(
        "https://ai-glove-default-rtdb.firebaseio.com/sessions/$sessionKey/report.json",
      );
      final saveResponse = await http.put(
        saveUrl,
        body: json.encode(finalSessionReport),
      );

      if (saveResponse.statusCode == 200) {
        print(
          "🎯 نصر برمجياً! تم توثيق تقرير الجلسة الطبي بالكامل في الفايربيز",
        );
      } else {
        print("❌ فشل حفظ تقرير الجلسة في السيرفر: ${saveResponse.body}");
      }
    } catch (e) {
      print("❌ حدث خطأ غير متوقع أثناء محاولة إنهاء الجلسة: $e");
    } finally {
      // 4. تصفير العدادات والتحضير بأمان التام للجلسة القادمة
      _secondsElapsed = 0; // 🎯 تصفير الثواني بعد نهاية الحفظ المضمون
      _completionPercentage = 0.0;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    _gloveSubscription?.cancel();
    super.dispose();
  }
}
