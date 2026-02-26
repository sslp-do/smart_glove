import 'package:flutter/material.dart';
import '../widgets/badge_section.dart';
import '../widgets/header_section.dart';
import '../widgets/progress_chart_section.dart';
import '../widgets/patient_side_menu.dart';
import '../widgets/start_session_card.dart';
import '../widgets/statistics_grid.dart';


class PatientDashboard extends StatelessWidget {
  const PatientDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    // Scaffold is the main layout structure
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: LayoutBuilder(
        builder: (context, constraints) {
          bool isSmallScreen = constraints.maxWidth < 1000;

          return Row(
            children: [
              // 1. Sidebar Navigation
              if (isSmallScreen)
                const PatientSideMenu(isCollapsed: true,)
              else
                const PatientSideMenu(isCollapsed: false,),

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
                      StatsGrid(), SizedBox(height: 30),
                      BadgesSection(),
                      SizedBox(height: 30),
                      ProgressChartSection(),
                    ],
                  ),
                ),
              ),
            ],
          );
        }
      ),
    );
  }
}