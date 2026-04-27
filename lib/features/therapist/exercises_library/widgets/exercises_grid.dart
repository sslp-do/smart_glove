import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_glove/features/therapist/exercises_library/widgets/exercise_card.dart';
import 'package:smart_glove/features/therapist/logic/category_provider.dart';
class buildExercisesGrid extends StatelessWidget {
  const buildExercisesGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final filteredExercises = context.watch<CategoryProvider>().filteredExercises;

    if (filteredExercises.isEmpty) {
      return const Center(child: Text("No exercises found."));
    }

    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 320,
        childAspectRatio: 0.85,
        crossAxisSpacing: 24,
        mainAxisSpacing: 24,
      ),
      itemCount: filteredExercises.length,
      itemBuilder: (context, index) {
        return buildExerciseCard(filteredExercises[index], context);
      },
    );
  }
}