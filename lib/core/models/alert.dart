enum AlertSeverity { high, medium, low }

class AlertModel {
  final String patientId;
  final String patientName;
  final String message;
  final String timeAgo;
  final AlertSeverity severity;

  AlertModel({
    required this.patientId,
    required this.patientName,
    required this.message,
    required this.timeAgo,
    required this.severity,
  });
}