import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_glove/core/providers/badges_provider.dart';
import 'package:smart_glove/features/patient/patient_dashboard/widgets/badge_section.dart';
import 'package:smart_glove/features/patient/patient_dashboard/widgets/header_section.dart';
import 'package:smart_glove/features/patient/patient_dashboard/widgets/progress_chart_section.dart';
import 'package:smart_glove/features/patient/patient_dashboard/widgets/start_session_card.dart';
import 'package:smart_glove/features/patient/patient_dashboard/widgets/statistics_grid.dart';
import 'package:smart_glove/features/patient/providers/glove_provider.dart';
import 'package:smart_glove/features/patient/providers/patient_provider.dart';


class PatientOverview extends StatefulWidget {
  const PatientOverview({super.key});

  @override
  State<PatientOverview> createState() => _PatientOverviewState();
}



class _PatientOverviewState extends State<PatientOverview> {
  late  PatientProvider patientProvider = context.watch<PatientProvider>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // نطلب من فلاتر رسم الشاشة أولاً، ثم تشغيل الدالة بأمان في الخلفية
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<PatientProvider>().fetchPatientData("patientId");
      context.read<PatientProvider>().fetchNextExercise("patientId");
    //  context.read<BadgesProvider>().updateBadgeStatus(context.read<PatientProvider>().currentPatient?);
    });
  }
  @override
  Widget build(BuildContext context) {
    final patientProvider = context.watch<PatientProvider>();
    Map<String, int> weeklyProgress = patientProvider.currentPatient?.weeklyProgress ?? {};
    final gloveProvider = context.watch<GloveProvider>();
    final badges = context.watch<BadgesProvider>().all_Badges;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           HeaderSection(gloveProvider:gloveProvider, patientProvider: patientProvider,),
          const SizedBox(height: 30),
           StartSessionCard(patientProvider: patientProvider,),
          const SizedBox(height: 30),
           StatsGrid(patientProvider: patientProvider,), const SizedBox(height: 30),
           BadgesSection(badges: badges,),
          const SizedBox(height: 30),
          ProgressChartSection(weeklyProgress: weeklyProgress,), const SizedBox(height: 30),
        ],
      ),
    );
  }
}
