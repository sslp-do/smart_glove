// 💡 هذا الملف المحدث بالكامل ليتوافق مع العقد الأصلي بدون أي اختصارات
class AiFingerInput {
  final String name;         // Thumb, Index, Middle, Ring, Pinky
  final List<double> angles; // مصفوفة القراءات الحية
  final double rom;          // Range of Motion
  final double tam;          // Total Active Motion (MCP + PIP + DIP)
  final double prevRom;      // ROM من الجلسة السابقة

  AiFingerInput({
    required this.name,
    required this.angles,
    required this.rom,
    required this.tam,
    required this.prevRom,
  });

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "angles": angles,
      "rom": rom,
      "tam": tam,
      "prev_rom": prevRom,
    };
  }
}

class AiPayloadAdapter {
  final String patientName;
  final int patientAge;
  final String diagnosis;
  final String therapistName;
  final int sessionNumber;
  final String sessionDate;
  final int durationMin;
  final List<AiFingerInput> fingers;

  AiPayloadAdapter({
    required this.patientName,
    required this.patientAge,
    required this.diagnosis,
    required this.therapistName,
    required this.sessionNumber,
    required this.sessionDate,
    required this.durationMin,
    required this.fingers,
  });

  Map<String, dynamic> toJson() {
    return {
      "patient": {
        "name": patientName,
        "age": patientAge,
        "diagnosis": diagnosis,
        "therapist": therapistName,
        "session_number": sessionNumber,
        "session_date": sessionDate,
        "duration_min": durationMin,
      },
      "fingers": fingers.map((f) => f.toJson()).toList(),
    };
  }
}