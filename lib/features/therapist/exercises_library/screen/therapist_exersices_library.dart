import 'package:flutter/material.dart';
import 'package:smart_glove/features/therapist/exercises_library/widgets/top_bar.dart';

import '../widgets/category_chip.dart';
import '../widgets/exercises_grid.dart';

class TherapistExercisesScreen extends StatefulWidget {
  const TherapistExercisesScreen({super.key});

  @override
  State<TherapistExercisesScreen> createState() =>
      _TherapistExercisesScreenState();
}

class _TherapistExercisesScreenState extends State<TherapistExercisesScreen> {


  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            topBar(context),
            const SizedBox(height: 30),

            Row(
              children: [
                buildCategoryChip(
                  label: "All",
                ),
                const SizedBox(width: 12),
                buildCategoryChip(
                  label: "Full Hand",
                ),
                const SizedBox(width: 12),
                buildCategoryChip(
                  label: "Fingers",
                ),
                const SizedBox(width: 12),
                buildCategoryChip(
                  label: "Wrist",
                ),
              ],
            ),
            const SizedBox(height: 30),

            // Grid View
            Expanded(child: buildExercisesGrid()),
          ],
        ),
      ),
    );
  }
}
