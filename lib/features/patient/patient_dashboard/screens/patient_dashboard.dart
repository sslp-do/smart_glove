import 'package:flutter/material.dart';
import 'package:smart_glove/features/patient/patient_dashboard/screens/main_content.dart';
import '../widgets/patient_side_menu.dart';

class PatientDashboard extends StatelessWidget {
  PatientDashboard({super.key});

  String routName = "overview";
  bool isScreenCollapsed = false;

  @override
  Widget build(BuildContext context) {
    if (routName == "overview") {
      isScreenCollapsed = false;
    } else {
      isScreenCollapsed = true;
    }

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: LayoutBuilder(
        builder: (context, constraints) {
          bool isSmallScreen = constraints.maxWidth < 1000;

          return Row(
            children: [
              // 1. Sidebar Navigation
              if (isSmallScreen || isScreenCollapsed)
                const PatientSideMenu(isCollapsed: true)
              else
                const PatientSideMenu(isCollapsed: false),

              // 2. Main Content Area
              MainContent(routeName: routName),
            ],
          );
        },
      ),
    );
  }
}
