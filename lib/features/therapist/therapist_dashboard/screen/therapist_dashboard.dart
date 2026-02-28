import 'package:flutter/material.dart';
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
          TherapistMainContent(index: index),
        ],
      ),
    );
  }
}
