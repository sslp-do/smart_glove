import 'package:flutter/material.dart';
import 'package:smart_glove/features/patient/patient_dashboard/widgets/badge_section.dart';
import 'package:smart_glove/features/patient/patient_dashboard/widgets/header_section.dart';
import 'package:smart_glove/features/patient/patient_dashboard/widgets/progress_chart_section.dart';
import 'package:smart_glove/features/patient/patient_dashboard/widgets/start_session_card.dart';
import 'package:smart_glove/features/patient/patient_dashboard/widgets/statistics_grid.dart';


class PatientOverview extends StatelessWidget {
  const PatientOverview({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          HeaderSection(),
          SizedBox(height: 30),
          StartSessionCard(),
          SizedBox(height: 30),
          StatsGrid(), SizedBox(height: 30),
          BadgesSection(),
          SizedBox(height: 30),
          ProgressChartSection(), SizedBox(height: 30),
        ],
      ),
    );
  }
}
