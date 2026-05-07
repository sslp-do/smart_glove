import 'package:flutter/material.dart';
import 'package:smart_glove/features/patient/my_reports/widgets/hero_card.dart';
import 'package:smart_glove/features/patient/my_reports/widgets/reports_queue.dart';
import 'package:smart_glove/features/patient/patient_dashboard/widgets/header_section.dart';

class PatientReportsScreen extends StatelessWidget {
  const PatientReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //  TODO: needs enhancement
    final theme = Theme.of(context);
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          HeaderSection(),

          const SizedBox(height: 20),

          //  1. Hero Card
          HeroCard(),
          const SizedBox(height: 30),

          //   2. title
          const Text(
            "Reports History",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 16),

          //  3. reports queue
          RepotsQueue(),
        ],
      ),
    );
  }
}
