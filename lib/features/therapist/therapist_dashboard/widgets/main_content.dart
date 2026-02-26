import 'package:flutter/material.dart';
import 'package:smart_glove/features/therapist/therapist_dashboard/widgets/admin_top_bar.dart';
import 'package:smart_glove/features/therapist/therapist_dashboard/widgets/overview.dart';

class MainContent extends StatefulWidget {
  const MainContent({super.key});

  @override
  State<MainContent> createState() => _MainContentState();
}

class _MainContentState extends State<MainContent> {
  @override
  Widget build(BuildContext context) {
    Theme.of(context);

    return Expanded(
      child: Column(
        children: [
          //Top Bar
          const AdminTopBar(),

          //Overview
          // Expanded(child: const ExercisesLibraryScreen()),
        //  Expanded(child: const TherapistFeedbackScreen()),
          Expanded(child: const Overview()),
        ],
      ),
    );
  }
}
