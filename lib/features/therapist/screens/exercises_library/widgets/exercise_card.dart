import 'package:flutter/material.dart';
import 'package:smart_glove/features/patient/models/exercise_model.dart';

Widget buildExerciseCard(Exercise exercise, BuildContext context) {
  final theme = Theme.of(context);
  Color diffColor = exercise.difficulty == 'Easy'
      ? Colors.green
      : (exercise.difficulty == 'Medium' ? Colors.orange : Colors.red);

  return Container(
    // width: MediaQuery.of(context).size.width * 0.50, height: MediaQuery.of(context).size.height * 0.50,
    decoration: BoxDecoration(
      color: theme.cardTheme.color,
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: Colors.grey.withOpacity(0.1)),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.2),
          spreadRadius: 2,
          blurRadius: 5,
          offset: const Offset(0, 3),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          flex: 3,
          child: Container(
            decoration: BoxDecoration(
              color: theme.primaryColor.withOpacity(0.05),
              borderRadius: BorderRadius.all(Radius.circular(16)),

/*              BorderRadius.vertical(
                bottom: Radius.circular(16),
                top: Radius.circular(16),
              ),*/
            ),
            child: Image.network(
              exercise.tutorialImageUrl,
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) =>
                  Container(color: Colors.grey.shade100),
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: diffColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        exercise.difficulty,
                        style: TextStyle(
                          color: diffColor,
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      exercise.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      exercise.description,
                      style: TextStyle(color: Colors.grey[600], fontSize: 13),
                      maxLines: 4,
                      softWrap: false,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}
