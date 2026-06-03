class Patient {
  final String id;
  final String name;
  final int totalSessions;
  final int streak;
  final double recoveryProgress;
  final List<String> badges;
  final Map<String, int> weeklyProgress;
  final String affectedHand;
  final String status;
  final String lastSessionTime;
  final String diagnosis;

  Patient({
    required this.id,
    required this.name,
    required this.totalSessions,
    required this.streak,
    required this.recoveryProgress,
    required this.badges,
    required this.weeklyProgress,
    required this.affectedHand,
    required this.status,
    required this.lastSessionTime,
    required this.diagnosis,
  });

  factory Patient.fromJson(Map<String, dynamic> json) {
    return Patient(
      id: json['id'],
      name: json['name'],
      totalSessions: json['totalSessions'] ?? 0,
      streak: json['streak'] ?? 0,
      recoveryProgress: (json['improvement'] ?? 0).toDouble(),
      badges: List<String>.from(json['badges'] ?? []),
      weeklyProgress: Map<String, int>.from(json['weeklyProgress'] ?? {}),
      affectedHand: json['affectedHand'] ?? '',
      status: json['status'] ?? '',
      lastSessionTime: json['lastSessionTime'] ?? '',
      diagnosis: json['Condition'] ?? '',
    );
  }

  Patient copyWith({
    String? name,
    int? totalSessions,
    int? streak,
    double? improvement,
    List<String>? badges,
    Map<String, int>? weeklyProgress,
    String? affectedHand,
    String? status,
    String? lastSessionTime,
    String? Condition,
    int? recoveryProgress,
  }) {
    return Patient(
      id: id,
      name: name ?? this.name,
      totalSessions: totalSessions ?? this.totalSessions,
      streak: streak ?? this.streak,
      recoveryProgress: improvement ?? this.recoveryProgress,
      badges: badges ?? this.badges,
      weeklyProgress: weeklyProgress ?? this.weeklyProgress,
      affectedHand: affectedHand ?? this.affectedHand,
      status: status ?? this.status,
      lastSessionTime: lastSessionTime ?? this.lastSessionTime,
      diagnosis: Condition ?? this.diagnosis,
    );
  }
}
