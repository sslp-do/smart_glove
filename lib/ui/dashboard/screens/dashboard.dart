import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:smart_glove/core/theme/app_colors.dart';

import '../widgets/header_section.dart';
import '../widgets/progress_chart_section.dart';
import '../widgets/side_menu.dart';
import '../widgets/start_session_card.dart';
import '../widgets/statistics_grid.dart';


class PatientDashboard extends StatelessWidget {
  const PatientDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    // Scaffold is the main layout structure
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Row(
        children: [
          // 1. Sidebar Navigation
          const SideMenu(),

          // 2. Main Content Area
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(32.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  HeaderSection(),
                  SizedBox(height: 30),
                  StartSessionCard(),
                  SizedBox(height: 30),
                  StatsGrid(),
                  SizedBox(height: 30),
                  ProgressChartSection(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}