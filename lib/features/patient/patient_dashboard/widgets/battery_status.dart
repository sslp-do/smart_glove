import 'package:flutter/material.dart';
import 'package:smart_glove/core/theme/app_colors.dart';


class GloveBatteryStatus extends StatelessWidget {
  final int batteryLevel;

  const GloveBatteryStatus({super.key, required this.batteryLevel});

  @override
  Widget build(BuildContext context) {
final theme = Theme.of(context);
    Color statusColor = batteryLevel > 20 ? AppColors.success : AppColors.error;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: theme.cardTheme.color,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.bluetooth_connected, color: statusColor, size: 20),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                batteryLevel > 20 ? "Glove Connected" : "Low Battery",
               style: TextStyle(
            fontWeight: FontWeight.bold,
            color:statusColor,
          ),
              ),
              const SizedBox(height: 4),

              SizedBox(
                width: 80,
                height: 6,
                child: LinearProgressIndicator(
                  value: batteryLevel / 100,
                  backgroundColor: Colors.grey.shade200,
                  color: statusColor,
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
            ],
          ),
          const SizedBox(width: 12),
          Text("$batteryLevel%", style: TextStyle(fontWeight: FontWeight.bold, color:  statusColor)),
        ],
      ),
    );
  }
}