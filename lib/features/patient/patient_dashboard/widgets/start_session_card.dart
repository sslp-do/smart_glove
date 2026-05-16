import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_glove/features/patient/live_session/screen/live_session.dart';
import 'package:smart_glove/features/patient/providers/patient_provider.dart';
import 'package:smart_glove/features/patient/providers/session_provider.dart';

class StartSessionCard extends StatelessWidget {
  final PatientProvider patientProvider;
  const StartSessionCard({super.key, required this.patientProvider});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [theme.primaryColor, theme.primaryColor.withOpacity(0.8)],
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: theme.primaryColor.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child:  Text(
                    "Today's Session",
                   style: theme.textTheme.bodyMedium!.copyWith(color: Colors.white),
                  ),
                ),
                const SizedBox(height: 10),
                 Text(
                  "Exercise: ${patientProvider.nextExercise?.title ?? "No Exercise"}",
                  style:
                   theme.textTheme.displayMedium!.copyWith(color: Colors.white)
                ),
                const SizedBox(height: 5),
                 Text(
                  "Duration: ${patientProvider.nextExercise?.duration??0} mins • Reps: ${patientProvider.nextExercise?.targetRepetitions??0} ",
                  style: theme.textTheme.titleLarge!.copyWith(color: Colors.white),
                ),
                const SizedBox(height: 20),
                ElevatedButton.icon(
                  onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LiveSessionScreen(currentExercise: patientProvider.nextExercise!)),
                  );
                  },
                  icon: const Icon(Icons.play_arrow),
                  label:  Text("Start Session Now", style: theme.textTheme.titleLarge!.copyWith(color: theme.primaryColor),),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: theme.cardColor,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 12,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ],
            ),
          ),

          Icon(
            Icons.sports_gymnastics,
            size: 120,
            color: theme.cardColor.withOpacity(0.3),
          ),
        ],
      ),
    );
  }
}