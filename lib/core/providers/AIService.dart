import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:smart_glove/features/patient/models/session.dart';

class AIService {
  // الرابط الخاص بالـ API الذي قمتِ ببنائه أو استخدامه
  final String apiUrl = "https://your-ai-api-endpoint.com/analyze";

  Future<String> getSessionAnalysis(PatientSession session) async {
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "exercise_id": session.exerciseId,
          "duration": session.duration.inSeconds,
          "score": session.score,
          "finger_data": session.gloveDataSummary.toJson(),
          // يمكنك إضافة بيانات أخرى يحتاجها النموذج الخاص بكِ
        }),
      );

      if (response.statusCode == 200) {
        final result = jsonDecode(response.body);
        return result['analysis_text']; // افترضنا أن الـ API يعيد هذا الحقل
      } else {
        return "تعذر الحصول على تحليل الذكاء الاصطناعي حالياً.";
      }
    } catch (e) {
      return "خطأ في الاتصال بالخادم: $e";
    }
  }
}