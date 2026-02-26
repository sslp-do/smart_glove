import 'package:flutter/material.dart';
import 'package:smart_glove/features/therapist/therapist_dashboard/widgets/active_patients_table.dart';
import 'package:smart_glove/features/therapist/therapist_dashboard/widgets/ai_reports_queue.dart';
import 'package:smart_glove/features/therapist/therapist_dashboard/widgets/live_monitoring.dart';
import 'package:smart_glove/features/therapist/therapist_dashboard/widgets/stats_row.dart';


class Overview extends StatelessWidget {
  const Overview({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Clinic Overview", style: theme.textTheme.displayMedium),
          const SizedBox(height: 30),

          // Statistics
          const AdminStatsRow(),

          const SizedBox(height: 30),

          // Monitoring section
          const LiveMonitoringSection(),

          // Patients Quick Overview
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Patient's Progress
              Expanded(flex: 6, child: const ActivePatientsTable()),
              const SizedBox(width: 30),
              // AI Reports Overview
              Expanded(flex: 4, child: const AIReportsQueue()),
            ],
          ),
        ],
      ),
    );
  }
}
