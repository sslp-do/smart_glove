import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_glove/features/patient/providers/exercise_provider.dart';
import 'package:smart_glove/features/therapist/providers/category_provider.dart';
import 'package:smart_glove/features/therapist/screens/exercises_library/widgets/exercise_card.dart';
class buildExercisesGrid extends StatelessWidget {
  const buildExercisesGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final filteredExercises = context.watch<ExerciseProvider>().filteredExercises;

    if (filteredExercises.isEmpty) {
      return const Center(child: Text("No exercises found."));
    }

    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 320,
        childAspectRatio: 0.65,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemCount: filteredExercises.length,
      itemBuilder: (context, index) {
        return buildExerciseCard(filteredExercises[index], context);
      },
    );
  }
}