import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';

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
        // Glove Connection Status Indicator
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.green.shade200),
          ),
          child: Row(
            children: const [
              Icon(Icons.circle, color: AppColors.success, size: 12),
              SizedBox(width: 8),
              Text(
                "Glove Connected",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: AppColors.success,
                ),
              ),
              SizedBox(width: 8),
              Icon(Icons.bluetooth, color: Colors.green),
            ],
          ),
        ),
      ],
    );
  }
}