import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:smart_glove/features/patient/models/fingerdata.dart';

class GloveDataService {
  // الـ Stream الدوري اللي بيعمل Fetch للداتا كل ثانية
  Stream<Map<String, dynamic>?> getLiveGloveStream() {
    return Stream.periodic(const Duration(seconds: 1)).asyncMap((_) async {
      try {
        final url = Uri.parse("https://ai-glove-default-rtdb.firebaseio.com/sessions.json");
        final response = await http.get(url);

        if (response.statusCode == 200 && response.body != 'null') {
          return json.decode(response.body) as Map<String, dynamic>;
        }
      } catch (e) {
        print("❌ خطأ شبكة خارجي في الـ Service: $e");
      }
      return null;
    });
  }

  // دالة مساعدة ومفصلة لتحليل الـ Map القادم من الفايربيز واستخراج الزوايا ومفتاح الجلسة
  Map<String, dynamic> parseGloveResponse(Map<String, dynamic> allSessionsMap) {
    double thumb = 0.0;
    double index = 0.0;
    double middle = 0.0;
    double ring = 0.0;
    double little = 0.0;
    String latestSessionKey = "";

    if (allSessionsMap.isNotEmpty) {
      var sortedSessionKeys = allSessionsMap.keys.toList()..sort();
      latestSessionKey = sortedSessionKeys.last;

      var readingsMap = allSessionsMap[latestSessionKey]['readings'];
      if (readingsMap != null && readingsMap is Map) {
        var sortedReadingKeys = readingsMap.keys.toList()..sort();
        var lastPushKey = sortedReadingKeys.last;
        var fingers = readingsMap[lastPushKey]['fingers'];

        if (fingers != null) {
          thumb  = (fingers['Thumb']?['degree'] ?? 0.0).toDouble();
          index  = (fingers['Index']?['degree'] ?? 0.0).toDouble();
          middle = (fingers['Middle']?['degree'] ?? 0.0).toDouble();
          ring   = (fingers['Ring']?['degree'] ?? 0.0).toDouble();
          little = (fingers['Pinky']?['degree'] ?? 0.0).toDouble();
        }
      }
    }

    return {
      'sessionKey': latestSessionKey,
      'fingerData': FingerData(
        thumb: thumb,
        index: index,
        middle: middle,
        ring: ring,
        little: little,
      ),
    };
  }
}