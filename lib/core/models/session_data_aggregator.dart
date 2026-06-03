import 'package:firebase_database/firebase_database.dart';
import 'package:intl/intl.dart';
import 'package:smart_glove/Test/ai_payload.dart';
// import 'ai_payload_adapter.dart';

class SessionDataAggregator {

  // دالة مستقلة تماماً ومسؤولة فقط عن تجميع البيانات وتحويلها
  static Future<AiPayloadAdapter> buildAiPayloadFromFirebase({
    required String firebaseSessionKey,
    required String patientName,
    required int patientAge,
    required String diagnosis,
    required int sessionNumber,
    required int durationMinutes,
  }) async {

    final DatabaseReference readingsRef = FirebaseDatabase.instance
        .ref("sessions/$firebaseSessionKey/readings");

    DataSnapshot snapshot = await readingsRef.get();

    List<double> thumbAngles = [];
    List<double> indexAngles = [];
    List<double> middleAngles = [];
    List<double> ringAngles = [];
    List<double> pinkyAngles = [];

    double finalThumbRom = 0.0, finalThumbTam = 0.0;
    double finalIndexRom = 0.0, finalIndexTam = 0.0;
    double finalMiddleRom = 0.0, finalMiddleTam = 0.0;
    double finalRingRom = 0.0, finalRingTam = 0.0;
    double finalPinkyRom = 0.0, finalPinkyTam = 0.0;

    if (snapshot.exists && snapshot.value != null) {
      Map<dynamic, dynamic> readingsMap = snapshot.value as Map<dynamic, dynamic>;
      var sortedKeys = readingsMap.keys.toList()..sort();

      for (var pushKey in sortedKeys) {
        var readingData = readingsMap[pushKey];
        if (readingData['fingers'] != null) {
          var fingers = readingData['fingers'];

          if (fingers['Thumb'] != null) {
            thumbAngles.add((fingers['Thumb']['angle'] ?? 0.0).toDouble());
            finalThumbRom = (fingers['Thumb']['rom'] ?? 0.0).toDouble();
            finalThumbTam = (fingers['Thumb']['tam'] ?? 0.0).toDouble();
          }
          if (fingers['Index'] != null) {
            indexAngles.add((fingers['Index']['angle'] ?? 0.0).toDouble());
            finalIndexRom = (fingers['Index']['rom'] ?? 0.0).toDouble();
            finalIndexTam = (fingers['Index']['tam'] ?? 0.0).toDouble();
          }
          if (fingers['Middle'] != null) {
            middleAngles.add((fingers['Middle']['angle'] ?? 0.0).toDouble());
            finalMiddleRom = (fingers['Middle']['rom'] ?? 0.0).toDouble();
            finalMiddleTam = (fingers['Middle']['tam'] ?? 0.0).toDouble();
          }
          if (fingers['Ring'] != null) {
            ringAngles.add((fingers['Ring']['angle'] ?? 0.0).toDouble());
            finalRingRom = (fingers['Ring']['rom'] ?? 0.0).toDouble();
            finalRingTam = (fingers['Ring']['tam'] ?? 0.0).toDouble();
          }
          var pinkyData = fingers['Pinky'] ?? fingers['little'] ?? fingers['Little'];
          if (pinkyData != null) {
            pinkyAngles.add((pinkyData['angle'] ?? 0.0).toDouble());
            finalPinkyRom = (pinkyData['rom'] ?? 0.0).toDouble();
            finalPinkyTam = (pinkyData['tam'] ?? 0.0).toDouble();
          }
        }
      }
    }

    // تأمين القوائم
    if (thumbAngles.isEmpty) thumbAngles = [0.0];
    if (indexAngles.isEmpty) indexAngles = [0.0];
    if (middleAngles.isEmpty) middleAngles = [0.0];
    if (ringAngles.isEmpty) ringAngles = [0.0];
    if (pinkyAngles.isEmpty) pinkyAngles = [0.0];

    String formattedDate = DateFormat('dd MMMM yyyy').format(DateTime.now());

    // إرجاع كائن الـ Adapter جاهزاً ومكتمل البيانات
    return AiPayloadAdapter(
      patientName: patientName,
      patientAge: patientAge,
      diagnosis: diagnosis,
      therapistName: "Dr. Sara Khalil, PT",
      sessionNumber: sessionNumber,
      sessionDate: formattedDate,
      durationMin: durationMinutes,
      fingers: [
        AiFingerInput(name: "Thumb", angles: thumbAngles, rom: finalThumbRom, tam: finalThumbTam, prevRom: finalThumbRom),
        AiFingerInput(name: "Index", angles: indexAngles, rom: finalIndexRom, tam: finalIndexTam, prevRom: finalIndexRom),
        AiFingerInput(name: "Middle", angles: middleAngles, rom: finalMiddleRom, tam: finalMiddleTam, prevRom: finalMiddleRom),
        AiFingerInput(name: "Ring", angles: ringAngles, rom: finalRingRom, tam: finalRingTam, prevRom: finalRingRom),
        AiFingerInput(name: "Pinky", angles: pinkyAngles, rom: finalPinkyRom, tam: finalPinkyTam, prevRom: finalPinkyRom),
      ],
    );
  }
}