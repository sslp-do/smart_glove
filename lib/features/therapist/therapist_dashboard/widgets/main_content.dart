import 'package:flutter/material.dart';
import 'package:smart_glove/features/therapist/ai_reports/screen/ai_reports.dart';
import 'package:smart_glove/features/therapist/all_patients/screen/all_patients.dart';
import 'package:smart_glove/features/therapist/therapist_dashboard/widgets/admin_top_bar.dart';
import 'package:smart_glove/features/therapist/therapist_dashboard/widgets/overview.dart';
import 'package:smart_glove/features/therapist/therapist_feedback/screen/therapist_feedback.dart';
import 'package:smart_glove/features/therapist/exercises_library/screen/exersices_screen.dart';

class MainContent extends StatefulWidget {
  int index = 0;

  MainContent({super.key, required this.index});

  @override
  State<MainContent> createState() => _MainContentState(index);
}

class _MainContentState extends State<MainContent> {
  int index = 0;

  _MainContentState(this.index);

  @override
  Widget build(BuildContext context) {
    Theme.of(context);

    return Expanded(
      child: Column(
        children: [
          //Top Bar
          const AdminTopBar(),

          //Overview-Library-Analysis
          if (index == 0) Expanded(child: const Overview()),
          if (index == 1) Expanded(child: const AllPatientsScreen()),
          if (index == 2) Expanded(child: const TherapistExercisesScreen()),
          if (index == 3) Expanded(child: const TherapistFeedbackScreen()),
        ],
      ),
    );
  }
}
