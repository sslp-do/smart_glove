import 'package:flutter/material.dart';
import 'package:smart_glove/features/therapist/screens/therapist_dashboard/widgets/active_patients_table.dart';
import 'package:smart_glove/features/therapist/screens/therapist_dashboard/widgets/smart_alerts.dart';
import 'package:smart_glove/features/therapist/screens/therapist_dashboard/widgets/stats_row.dart';

class Overview extends StatelessWidget {
  const Overview({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Clinic Overview", style: theme.textTheme.displayMedium),
          const SizedBox(height: 30),

          // Statistics
          const StatCards(),
          const SizedBox(height: 30),

          // Monitoring section
          const SmartAlerts(),
          const SizedBox(height: 30),

          // Patients List
          const ActivePatientsTable(),
          const SizedBox(height: 30),

      /*    // Patients Quick Overview
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Patient's Progress
              Expanded(flex: 6, child: const ActivePatientsTable()),
              const SizedBox(width: 30),
              // AI Reports Overview
              Expanded(flex: 4, child: const AIReportsQueue()),
            ],
          ),*/
        ],
      ),
    );
  }
}
