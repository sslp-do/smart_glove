import 'package:smart_glove/features/patient/models/fingerdata.dart';

class Exercise {
  final String id;
  final String name;
  final String description;
  final String tutorialImageUrl;
  final FingerData targetData; // أرقام الهدف لكل إصبع
  final int targetRepetitions;
  final int duration;
  final String difficulty;
  final String category;

  Exercise({
    required this.id,
    required this.name,
    required this.description,
    required this.tutorialImageUrl,
    required this.targetData,
    required this.targetRepetitions,
    required this.duration,
    required this.difficulty,
    required this.category,
  });

  factory Exercise.fromJson(Map<String, dynamic> json) {
    return Exercise(
      id: json['id'],
      name: json['title'],
      description: json['description'],
      tutorialImageUrl: json['tutorialImageUrl'],
      targetData: FingerData.fromJson(json['targetData']),
      targetRepetitions: json['targetRepetitions'],
      duration: json['duration'],
      difficulty: json['difficulty'],
      category: json['category'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': name,
    'description': description,
    'tutorialImageUrl': tutorialImageUrl,
    'targetData': targetData.toJson(),
    'targetRepetitions': targetRepetitions,
    'duration': duration,
    'difficulty': difficulty,
    'category': category,
  };
}