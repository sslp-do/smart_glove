class SessionReport {
  final String exerciseName;
  final DateTime date;
  final Duration duration;
  final int averageGripStrength;
  final int targetAchievedCount;
  final List<double> forceSensorData;
  final String doctorNotes;

  SessionReport({
    required this.exerciseName,
    required this.date,
    required this.duration,
    required this.averageGripStrength,
    required this.targetAchievedCount,
    required this.forceSensorData,
    required this.doctorNotes,
  });
}