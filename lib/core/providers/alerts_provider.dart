import 'package:flutter/material.dart';
import 'package:smart_glove/core/models/alert.dart';


class AlertsProvider extends ChangeNotifier {
  final List<AlertModel> _alerts = [
    AlertModel(
      patientId: "101",
      patientName: "Khaled",
      message: "Severe pain in pending exercise (8/10).",
      timeAgo: "2 hours ago",
      severity: AlertSeverity.high,
    ),
    AlertModel(
      patientId: "102",
      patientName: "Sara Ahmad",
      message: "No sessions since 2 weeks",
      timeAgo: "Yesterday",
      severity: AlertSeverity.medium,
    ),
    AlertModel(
      patientId: "103",
      patientName: "Omar tarek",
      message: "Decrease in movement angle (ROM).",
      timeAgo: "5 hours ago",
      severity: AlertSeverity.medium,
    ),
  ];

  List<AlertModel> get alerts => _alerts;

  void dismissAlert(String patientId) {
    _alerts.removeWhere((alert) => alert.patientId == patientId);
    notifyListeners();
  }
}