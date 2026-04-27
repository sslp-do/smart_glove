import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_glove/core/models/alert_model.dart';
import 'package:smart_glove/core/providers/alerts_provider.dart';


class SmartAlerts extends StatelessWidget {
  const SmartAlerts({super.key});

  @override
  Widget build(BuildContext context) {
    final alerts = context.watch<AlertsProvider>().alerts;

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [

            Row(
              children: [
                const Icon(Icons.notifications_active, color: Colors.redAccent),
                const SizedBox(width: 10),
                const Text(
                  "Needs Attention!",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const Spacer(),

                CircleAvatar(
                  radius: 12,
                  backgroundColor: Colors.red.shade100,
                  child: Text(
                    "${alerts.length}",
                    style: const TextStyle(fontSize: 12, color: Colors.red, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            const Divider(height: 30),

            if (alerts.isEmpty)
              const Center(
                child: Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Text("All Patients are Good 🌟", style: TextStyle(color: Colors.grey)),
                ),
              )
            else
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: alerts.length,
                itemBuilder: (context, index) {
                  final alert = alerts[index];
                  return _buildAlertTile(context, alert);
                },
              ),
          ],
        ),
      ),
    );
  }


  Widget _buildAlertTile(BuildContext context, AlertModel alert) {

    final isHighSeverity = alert.severity == AlertSeverity.high;
    final iconColor = isHighSeverity ? Colors.red : Colors.orange;
    final bgColor = isHighSeverity ? Colors.red.shade50 : Colors.orange.shade50;
    final iconData = isHighSeverity ? Icons.warning_rounded : Icons.info_outline;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: iconColor.withOpacity(0.3)),
      ),
      child: ListTile(
        leading: Icon(iconData, color: iconColor, size: 30),
        title: Text(
          alert.patientName,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text(alert.message, style: TextStyle(color: Colors.grey.shade800)),
            const SizedBox(height: 4),
            Text(alert.timeAgo, style: const TextStyle(fontSize: 11, color: Colors.grey)),
          ],
        ),
        trailing: IconButton(
          icon: const Icon(Icons.check_circle_outline, color: Colors.grey),
          tooltip: "Mark as Seen",
          onPressed: () {
            context.read<AlertsProvider>().dismissAlert(alert.patientId);
          },
        ),
      ),
    );
  }
}