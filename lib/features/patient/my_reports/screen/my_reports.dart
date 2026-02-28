import 'package:flutter/material.dart';
import 'package:smart_glove/features/patient/my_reports/widgets/hero_card.dart';
import 'package:smart_glove/features/patient/my_reports/widgets/reports_queue.dart';

class PatientReportsScreen extends StatelessWidget {
  const PatientReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //  TODO: needs enhancement
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("My Progress & Reports", style: theme.textTheme.displayMedium),
            IconButton(icon: const Icon(Icons.help_outline), onPressed: () {}),
          ],
        ),
          const SizedBox(height: 20),

        //  1. Hero Card
        HeroCard(),
          const SizedBox(height: 30),

        //   2. title
        const Text(
          "Doctor's Feedback",
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
    );
  }
}
