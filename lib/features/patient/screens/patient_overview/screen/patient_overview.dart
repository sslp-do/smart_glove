import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_glove/features/patient/providers/badges_provider.dart';
import 'package:smart_glove/features/patient/providers/glove_provider.dart';
import 'package:smart_glove/features/patient/providers/patient_provider.dart';
import 'package:smart_glove/features/patient/screens/patient_dashboard/widgets/badge_section.dart';
import 'package:smart_glove/features/patient/screens/patient_dashboard/widgets/header_section.dart';
import 'package:smart_glove/features/patient/screens/patient_dashboard/widgets/progress_chart_section.dart';
import 'package:smart_glove/features/patient/screens/patient_dashboard/widgets/start_session_card.dart';
import 'package:smart_glove/features/patient/screens/patient_dashboard/widgets/statistics_grid.dart';


class PatientOverview extends StatefulWidget {
  const PatientOverview({super.key});

  @override
  State<PatientOverview> createState() => _PatientOverviewState();
}



class _PatientOverviewState extends State<PatientOverview> {

  @override
  void initState() {
    super.initState();
    // جلب البيانات لما الشاشة تفتح — listen: false لأننا مش داخل build
    Future.microtask(() {
      final provider = Provider.of<PatientProvider>(context, listen: false);
      provider.fetchPatientData("patient_123");
      provider.fetchNextExercise("patient_123");
    });
  }

  @override
  Widget build(BuildContext context) {
    final patientProvider = Provider.of<PatientProvider>(context);
    Provider.of<GloveProvider>(context);
    final badges = Provider.of<BadgesProvider>(context).Badges;

    // ✅ لو البيانات لسا بتتحمل، اعرض Loading
    if (patientProvider.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    // ✅ لو البيانات ما وصلت (null)، اعرض رسالة
    if (patientProvider.currentPatient == null) {
      return const Center(child: Text("No data available"));
    }

    // ✅ هون مضمون البيانات موجودة، استخدمها بأمان
    final patient = patientProvider.currentPatient!;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          HeaderSection(),
          const SizedBox(height: 30),

          // ✅ من الـ Provider مباشرة
          if (patientProvider.nextExercise != null)
            StartSessionCard(exercise: patientProvider.nextExercise!),

          const SizedBox(height: 30),
          StatsGrid(),
          const SizedBox(height: 30),

          BadgesSection(badges: badges),
          const SizedBox(height: 30),

          // ✅ من الـ Patient Model مباشرة
          ProgressChartSection(weeklyProgress: patient.weeklyProgress),
          const SizedBox(height: 30),
        ],
      ),
    );
  }
}