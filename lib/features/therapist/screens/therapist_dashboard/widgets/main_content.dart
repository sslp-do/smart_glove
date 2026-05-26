import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_glove/core/providers/navigation_provider.dart';
import 'package:smart_glove/features/therapist/screens/ai_reports/screen/therapist_ai_reports.dart';
import 'package:smart_glove/features/therapist/screens/all_patients/screen/therapist_patients_list.dart';
import 'package:smart_glove/features/therapist/screens/exercises_library/screen/therapist_exersices_library.dart';
import 'package:smart_glove/features/therapist/screens/therapist_dashboard/widgets/overview.dart';

class TherapistMainContent extends StatelessWidget {
  TherapistMainContent({super.key});

  @override
  Widget build(BuildContext context) {
    String routName = context.watch<NavigationProvider>().currentRoute;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: _buildBody(routName),
    );
  }
}

Widget _buildBody(String routName) {
  switch (routName) {
    case "overview":
      return const Overview();
    case "all_patients":
      return const AllPatientsScreen();
    case "exercises":
      return const TherapistExercisesScreen();
    //  case "feedback": return const TherapistFeedbackScreen();
    case "ai_reports":
      return const TherapistAIReports();
    default:
      return const Overview();
  }
}
