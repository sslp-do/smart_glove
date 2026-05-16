// lib/models/raw_glove_data.dart
class RawGloveData {
  final Map<String, dynamic> data;
  final DateTime timestamp;

  RawGloveData({required this.data, required this.timestamp});

  factory RawGloveData.fromFirestore(Map<String, dynamic> firestoreData) {
    return RawGloveData(
      data: firestoreData,
      timestamp: DateTime.now(),
    );
  }
}