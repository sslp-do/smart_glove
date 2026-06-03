import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:smart_glove/features/patient/models/fingerdata.dart';
import 'package:http/http.dart' as http;
class GloveRepository {
  final DatabaseReference _dbRef = FirebaseDatabase.instance.ref();

  // دالة تعيد Stream من بيانات الأصابع لمريض معين
  Stream<DatabaseEvent> getLiveGloveData(String sessionId) {
    return _dbRef.child('sessions/$sessionId/readings').onValue.map((event) {
      final data = Map<String, dynamic>.from(event.snapshot.value as Map);
      return data.values.last;
    });
  }

  // 🎯 الرابط الرئيسي لقاعدة بيانات الفايربيز الخاصة بكِ
  final String _baseUrl = "https://ai-glove-default-rtdb.firebaseio.com";

  /// دالة تولد Stream ذكي يبحث عن أحدث جلسة فتحها القفاز ويجلب بيانات أصابعها الحية لايف
  Stream<Map<dynamic, dynamic>> listenToLatestSessionLive() {
    return Stream.periodic(const Duration(seconds: 1)).asyncMap((_) async {
      try {
        final url = Uri.parse("$_baseUrl/sessions.json");
        final response = await http.get(url);

        if (response.statusCode == 200 && response.body != 'null') {
          final Map<String, dynamic> allSessionsMap = json.decode(response.body) as Map<String, dynamic>;

          if (allSessionsMap.isNotEmpty) {
            // 1. ترتيب مجلدات الجلسات تلقائياً وجلب اسم أحدث جلسة فتحها القفاز للتو
            var sortedSessionKeys = allSessionsMap.keys.toList()..sort();
            var latestSessionKey = sortedSessionKeys.last;

            // 2. الدخول لبيانات الحركة (readings) داخل هذه الجلسة الأحدث
            var readingsMap = allSessionsMap[latestSessionKey]['readings'];

            if (readingsMap != null && readingsMap is Map && readingsMap.isNotEmpty) {
              // 3. جلب أحدث لقطة قراءة في قاع الـ readings
              var sortedReadingKeys = readingsMap.keys.toList()..sort();
              var lastPushKey = sortedReadingKeys.last;
              var fingers = readingsMap[lastPushKey]['fingers'];

              if (fingers != null) {
                // تجميع البيانات وإرسالها مع اسم الجلسة المكتشفة لتخزينها بالبروفايدر
                return {
                  'sessionKey': latestSessionKey,
                  'fingers': fingers,
                };
              }
            }
          }
        }
      } catch (e) {
        print("❌ خطأ شبكة داخل مستودع القفاز (GloveRepository): $e");
      }
      return {};
    }).where((data) => data.isNotEmpty); // تصفية اللقطات الفارغة لمنع تشتيت التطبيق
  }
}