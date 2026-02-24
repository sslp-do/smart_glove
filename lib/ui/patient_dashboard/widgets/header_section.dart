import 'package:flutter/material.dart';
import 'battery_status.dart';

class HeaderSection extends StatelessWidget {
  const HeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Good Morning, Sarah 👋",
              style: theme.textTheme.displayMedium,
            ),
            Text(
              "Ready to make some progress today?",
              style: theme.textTheme.bodyMedium,
            ),
          ],
        ),
        // Glove Connection Status & Battery Indicator
        GloveBatteryStatus(batteryLevel: 75),
      ],
    );
  }
}