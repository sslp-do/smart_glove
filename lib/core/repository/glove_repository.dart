import 'package:firebase_database/firebase_database.dart';
import 'package:smart_glove/features/patient/models/fingerdata.dart';

class GloveRepository {
  final DatabaseReference _dbRef = FirebaseDatabase.instance.ref();

  // دالة تعيد Stream من بيانات الأصابع لمريض معين
  Stream<FingerData> getLiveGloveData(String patientId) {
    // نفترض أن المسار في RTDB هو: patients/ID/live_data
    return _dbRef.child('patients/$patientId/live_data').onValue.map((event) {
      final data = Map<String, dynamic>.from(event.snapshot.value as Map);
      return FingerData.fromJson(data);
    });
  }
}