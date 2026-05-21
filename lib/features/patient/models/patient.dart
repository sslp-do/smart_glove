class Patient {
  final String id;
  final String name;
  final int totalSessions;
  final int streak;
  final double improvement;
  final List<String> badges;
  final Map<String, int> weeklyProgress; // مثال: {"Mon": 80, "Tue": 85}

  Patient({
    required this.id,
    required this.name,
    required this.totalSessions,
    required this.streak,
    required this.improvement,
    required this.badges,
    required this.weeklyProgress,
  });

  factory Patient.fromJson(Map<String, dynamic> json) {
    return Patient(
      id: json['id'],
      name: json['name'],
      totalSessions: json['totalSessions'] ?? 0,
      streak: json['streak'] ?? 0,
      improvement: (json['improvement'] ?? 0).toDouble(),
      badges: List<String>.from(json['badges'] ?? []),
      weeklyProgress: Map<String, int>.from(json['weeklyProgress'] ?? {}),
    );
  }

  Patient copyWith({
    String? id,
    String? name,
    int? totalSessions,
    int? streak,
    double? improvement,
    List<String>? badges,
    Map<String, int>? weeklyProgress,
  }) {
    return Patient(
      id: id ?? this.id,
      name: name ?? this.name,
      totalSessions: totalSessions ?? this.totalSessions,
      streak: streak ?? this.streak,
      improvement: improvement ?? this.improvement,
      badges: badges ?? this.badges,
      weeklyProgress: weeklyProgress ?? this.weeklyProgress,
    );
  }
}
