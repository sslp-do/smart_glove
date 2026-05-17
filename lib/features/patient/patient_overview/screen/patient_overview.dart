import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_glove/core/providers/badges_provider.dart';
import 'package:smart_glove/features/patient/models/fingerdata.dart';
import 'package:smart_glove/features/patient/patient_dashboard/widgets/badge_section.dart';
import 'package:smart_glove/features/patient/patient_dashboard/widgets/header_section.dart';
import 'package:smart_glove/features/patient/patient_dashboard/widgets/progress_chart_section.dart';
import 'package:smart_glove/features/patient/patient_dashboard/widgets/start_session_card.dart';
import 'package:smart_glove/features/patient/patient_dashboard/widgets/statistics_grid.dart';
import 'package:smart_glove/features/patient/providers/glove_provider.dart';
import 'package:smart_glove/features/patient/providers/patient_provider.dart';

import '../../models/exercise_model.dart';


class PatientOverview extends StatefulWidget {
  const PatientOverview({super.key});

  @override
  State<PatientOverview> createState() => _PatientOverviewState();
}



class _PatientOverviewState extends State<PatientOverview> {
  @override

  @override
  Widget build(BuildContext context) {
    final patientProvider = Provider.of<PatientProvider>(context);
    final gloveProvider = Provider.of<GloveProvider>(context);
    //final badges = Provider.of<BadgesProvider>(context).badges;
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           HeaderSection(gloveProvider:gloveProvider, patientProvider: patientProvider,),
          const SizedBox(height: 30),
           StartSessionCard(exercise:/* patientProvider?.nextExercise*/ new Exercise(id: "iooi",title: 'title',description: 'description',tutorialImageUrl: 'tutorialImageUrl',duration: 6,targetRepetitions: 5,targetData: FingerData(thumb: 34, index: 43, middle: 23, ring: 34, little: 67)),),
          const SizedBox(height: 30),
           StatsGrid(patientProvider: patientProvider,), const SizedBox(height: 30),
          // BadgesSection(badges: badges,),
          const SizedBox(height: 30),
          ProgressChartSection(weeklyProgress: new Map(),), const SizedBox(height: 30),
        ],
      ),
    );
  }
}
