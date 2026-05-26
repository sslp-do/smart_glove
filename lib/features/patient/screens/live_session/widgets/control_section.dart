import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:smart_glove/core/models/sound_manager.dart';
import 'package:smart_glove/features/patient/models/fingerdata.dart';
import 'package:smart_glove/features/patient/models/session.dart';
import 'package:smart_glove/features/patient/screens/live_session/screen/result_screen.dart';

class controlSection extends StatelessWidget {
  const controlSection({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cardColor = theme.cardTheme.color;

    return Expanded(
      flex: 3,
      child: Container(
        padding: const EdgeInsets.all(24),
        color: cardColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Session Metrics",
              style: theme.textTheme.titleLarge!.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 30),

            //Indicators
            _buildIndicators(context),

            const Spacer(),

            // Control Buttons
            _buildControlButtons(context),
          ],
        ),
      ),
    );
  }
}

Widget _buildIndicators(BuildContext context) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      // strength indicator
      _strengthIndicator(context, 0.75),

      SizedBox(height: 30),

      // Timer indicator
      _timerIndicator(context, 0.7),
    ],
  );
}

Widget _strengthIndicator(BuildContext context, double currentProgress) {
  final theme = Theme.of(context);
  final textColor = theme.textTheme.titleLarge?.color;

  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text("Progress Rate", style: theme.textTheme.titleLarge),
      const SizedBox(height: 20),
      Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          boxShadow: [
            BoxShadow(
              color: Colors.green.withOpacity(0.2),
              blurRadius: 20,
              spreadRadius: 4,
            ),
          ],
        ),
        child: CircularPercentIndicator(
          radius: 80.0,
          lineWidth: 15.0,
          animation: true,
          percent: currentProgress,
          center: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "${(currentProgress * 100).toInt()}%",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30.0,
                  color: textColor,
                ),
              ),
              Text("Power", style: theme.textTheme.bodyMedium),
            ],
          ),
          circularStrokeCap: CircularStrokeCap.round,
          backgroundColor: Colors.grey.withOpacity(0.2),
          progressColor: currentProgress > 0.7 ? Colors.green : Colors.orange,
        ),
      ),
    ],
  );
}

Widget _timerIndicator(BuildContext context, double timerValue) {
  final theme = Theme.of(context);
  final textColor = theme.textTheme.titleLarge?.color;

  return Column(
    children: [
      Text("Timer", style: Theme.of(context).textTheme.titleLarge),
      SizedBox(height: 20),
      Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              width: 150,
              height: 150,
              child: CircularProgressIndicator(
                value: timerValue,
                strokeWidth: 12,
                backgroundColor: Colors.grey.withOpacity(0.1),
                color: theme.primaryColor,
              ),
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "01:20",
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: textColor,
                  ),
                ),
                const Text("Remaining", style: TextStyle(color: Colors.grey)),
              ],
            ),
          ],
        ),
      ),
    ],
  );
}

Widget _buildControlButtons(BuildContext context) {
  void finishSession() {
    late ConfettiController _confettiController = ConfettiController(
      duration: const Duration(seconds: 1),
    );
    SoundManager.playSessionComplete();

    _confettiController.play();

    /*  showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Great Job! 🎉"),
        content: const Text("Session completed successfully. See you tomorrow!"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
                 Navigator.pop(context);
            },
            child: const Text("Done"),
          )
        ],
      ),
    );*/
  }

  //final gloveProvider = Provider.of<GloveProvider>(context);
  final theme = Theme.of(context);
  return Column(
    children: [
      Row(
        children: [
          Expanded(
            child: ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.pause),
              label: const Text("Pause"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.amber[700],
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
            ),
          ),
          /*     const SizedBox(width: 16),
          Expanded(
            child: ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.skip_next),
              label: const Text("Skip"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
            ),
          ),*/
        ],
      ),
      SizedBox(height: 10),
      SizedBox(
        height: 50,
        child: ElevatedButton(
          onPressed: () {
            SoundManager.playSessionComplete();
            finishSession();
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ResultScreen(
                  session: new PatientSession(
                    sessionId: "sessionId",
                    exerciseId: "exerciseId",
                    patientNumber: "patientNumber",
                    sessionDate: DateTime.now(),
                    duration: Duration(minutes: 2),
                    progress: 20,
                    score: 100,
                    gloveDataSummary: FingerData(
                      thumb: 12,
                      index: 34,
                      middle: 23,
                      ring: 23,
                      little: 12,
                    ),
                    aiAnalysis: "aiAnalysis",
                  ),
                ),
              ),
            );
          },
          /* gloveProvider.isSaving
              ? null
              : () async {
            await context.read<GloveProvider>().endAndSaveSession(
              patientName: "dounia",
              patientNumber: "12345",
            );


            if (context.mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Saved in Firebase')),
              );
              // Navigator.pushNamed(context, '/reports'); // اختياري: الانتقال للتقارير
            }
          }*/
          child:
              /* gloveProvider.isSaving
              ? const SizedBox(
              height: 20,
              width: 20,
              child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white)
          )
              : */
              Text("End Session"),
          style: ElevatedButton.styleFrom(
            backgroundColor: theme.primaryColor,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 16),
          ),
        ),
      ),
    ],
  );
}
