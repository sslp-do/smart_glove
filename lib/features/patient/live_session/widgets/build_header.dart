import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:smart_glove/features/patient/providers/session_provider.dart';

Widget buildHeader(BuildContext context) {
  final theme = Theme.of(context);
  final session = context.watch<SessionProvider>();
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            session.currentExercise?.title ?? "Exercise",
            style: theme.textTheme.displayMedium,
          ),
          const SizedBox(height: 5),
          Text(
            "Target Muscle: ${session.currentExercise?.description}",
            style: theme.textTheme.bodyMedium,
          ),
        ],
      ),
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: theme.primaryColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          "Repeats : ${session.currentExercise?.targetRepetitions}",
          style: theme.textTheme.titleLarge!.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ],
  );
}
