import 'package:smart_glove/features/patient/models/fingerdata.dart';

class Exercise {
  final String id;
  final String title;
  final String description;
  final String tutorialImageUrl;
  final FingerData targetData; // أرقام الهدف لكل إصبع
  final int targetRepetitions;
  final int duration;

  Exercise({
    required this.id,
    required this.title,
    required this.description,
    required this.tutorialImageUrl,
    required this.targetData,
    required this.targetRepetitions,
    required this.duration,
  });

  factory Exercise.fromJson(Map<String, dynamic> json) {
    return Exercise(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      tutorialImageUrl: json['tutorialImageUrl'],
      targetData: FingerData.fromJson(json['targetData']),
      targetRepetitions: json['targetRepetitions'],
      duration: json['duration'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'description': description,
    'tutorialImageUrl': tutorialImageUrl,
    'targetData': targetData.toJson(),
    'targetRepetitions': targetRepetitions,
    'duration': duration,
  };
}