import 'package:flutter/material.dart';
import 'package:smart_glove/features/therapist/ai_reports/screen/therapist_ai_reports.dart';
import 'package:smart_glove/features/therapist/all_patients/screen/therapist_patients_list.dart';
import 'package:smart_glove/features/therapist/therapist_dashboard/widgets/admin_top_bar.dart';
import 'package:smart_glove/features/therapist/therapist_dashboard/widgets/overview.dart';
import 'package:smart_glove/features/therapist/therapist_feedback/screen/therapist_feedback.dart';
import 'package:smart_glove/features/therapist/exercises_library/screen/therapist_exersices_library.dart';

class TherapistMainContent extends StatefulWidget {
  int index = 0;

  TherapistMainContent({super.key, required this.index});

  @override
  State<TherapistMainContent> createState() => _TherapistMainContentState(index);
}

class _TherapistMainContentState extends State<TherapistMainContent> {
  int index = 0;

  _TherapistMainContentState(this.index);

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
         // if (index == 5) Expanded(child: const TherapistFeedbackScreen()),
        ],
      ),
    );
  }
}
