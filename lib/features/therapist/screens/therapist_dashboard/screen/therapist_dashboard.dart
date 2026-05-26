/*import 'package:flutter/material.dart';
import 'package:smart_glove/features/therapist/ai_reports/screen/therapist_ai_reports.dart';
import 'package:smart_glove/features/therapist/therapist_dashboard/widgets/admin_side_menu.dart';
import 'package:smart_glove/features/therapist/therapist_dashboard/widgets/main_content.dart';
import 'package:smart_glove/features/therapist/therapist_dashboard/widgets/patient_details_drawer.dart';

class TherapistDashboard extends StatelessWidget {
   TherapistDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bgColor = theme.scaffoldBackgroundColor;
    int index = 0;
    if(index==4)
    return  const TherapistAIReports();
    else return Scaffold(
      backgroundColor: bgColor,
      endDrawer: const PatientDetailsDrawer(),
      body: Row(
        children: [
          //Admin Side Menu
         const AdminSideMenu(),

          //Main Content
          Expanded(child: TherapistMainContent()),
        ],
      ),
    );
  }
}*/
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_glove/core/providers/navigation_provider.dart';
import 'package:smart_glove/features/therapist/screens/therapist_dashboard/widgets/admin_side_menu.dart';
import 'package:smart_glove/features/therapist/screens/therapist_dashboard/widgets/main_content.dart';
import 'package:smart_glove/features/therapist/screens/therapist_dashboard/widgets/patient_details_drawer.dart';

class TherapistDashboard extends StatelessWidget {
  TherapistDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    bool isSmallScreen = MediaQuery.of(context).size.width <= 1150;
    if (isSmallScreen) context.read<NavigationProvider>().setCollapsed(true);
    bool isCollapsed = context.watch<NavigationProvider>().isCollapsed;

    final bgColor = Theme.of(context).scaffoldBackgroundColor;

    return Scaffold(
      backgroundColor: bgColor,
      endDrawer: const PatientDetailsDrawer(),
      body: LayoutBuilder(
        builder: (context, constraints) {
          context.read<NavigationProvider>().setCollapsed(
            constraints.maxWidth <= 1150,
          );

          return Row(
            children: [
              // 1. Sidebar Navigation
              TherapistSideMenu(isCollapsed: isCollapsed),

              // 2. Main Content Area
              Expanded(child: TherapistMainContent()),
            ],
          );
        },
      ),
    );
  }
}
