/*
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:smart_glove/core/models/sound_manager.dart';
import 'package:smart_glove/features/patient/models/fingerdata.dart';
import 'package:smart_glove/features/patient/models/patient.dart';
import 'package:smart_glove/features/patient/models/session.dart';
import 'package:smart_glove/features/patient/providers/patient_provider.dart';
import 'package:smart_glove/features/patient/providers/session_provider.dart';
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
  Patient? currentPatient = context.read<PatientProvider>().currentPatient;
  void finishSession() async{
    late ConfettiController _confettiController = ConfettiController(
      duration: const Duration(seconds: 1),
    );
    SoundManager.playSessionComplete();

    _confettiController.play();

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

  }

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
        ],
      ),
      SizedBox(height: 10),
      SizedBox(
        height: 50,
        child: ElevatedButton(
          onPressed: () {
            finishSession();
          },
          child:
              */
/* gloveProvider.isSaving
              ? const SizedBox(
              height: 20,
              width: 20,
              child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white)
          )
              : *//*

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
*/
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:smart_glove/core/models/sound_manager.dart';
import 'package:smart_glove/features/patient/models/fingerdata.dart';
import 'package:smart_glove/features/patient/models/patient.dart';
import 'package:smart_glove/features/patient/models/session.dart';
import 'package:smart_glove/features/patient/providers/patient_provider.dart';
import 'package:smart_glove/features/patient/providers/session_provider.dart';
import 'package:smart_glove/features/patient/screens/live_session/screen/result_screen.dart';
import 'package:smart_glove/features/patient/screens/result_page/widgets/finger_snapshot.dart';

class controlSection extends StatelessWidget {
  SessionProvider sessionProvider;
   controlSection({super.key, required this.sessionProvider});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cardColor = theme.cardTheme.color;

  /*  // 🎯 الحل السحري: استدعاء watch في أعلى الدالة لجعل الشاشة كاملة تستمع بأمان وبدون تضارب Context
    final sessionProvider = context.watch<SessionProvider>();
*/
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

            // 🎯 تمرير البروفايدر الحي المستقر مباشرة للمؤشرات
            _buildIndicators(context, sessionProvider),

            const Spacer(),

            // 🎯 تمرير البروفايدر الحي المستقر مباشرة للأزرار لتأمين زر الإنهاء
            _buildControlButtons(context, sessionProvider),
          ],
        ),
      ),
    );
  }
}

// 🎯 توزيع البيانات الحية المستقرة مية بالمية ممررة من الأعلى بسلام
Widget _buildIndicators(BuildContext context, SessionProvider sessionProvider) {
  double timerIndicatorValue = (sessionProvider.secondsElapsed % 60) / 60.0;

  return Column(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      // حقن نسبة الإنجاز اللحظية التلقائية الحقيقية
      _strengthIndicator(context, sessionProvider.completionPercentage),

      const SizedBox(height: 30),

      // حقن الوقت والعداد التصاعدي الحي (00:01, 00:02)
      _timerIndicator(context, timerIndicatorValue, sessionProvider.formattedTime),
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
          animation: false, // استجابة فورية وحية مية بالمية لحركة القفاز
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

Widget _timerIndicator(BuildContext context, double timerValue, String timeText) {
  final theme = Theme.of(context);
  final textColor = theme.textTheme.titleLarge?.color;

  return Column(
    children: [
      Text("Timer", style: theme.textTheme.titleLarge),
      const SizedBox(height: 20),
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
                  timeText, // عرض الوقت الحي تصاعدياً ثانية بثانية
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: textColor,
                  ),
                ),
                const Text("Elapsed", style: TextStyle(color: Colors.grey)),
              ],
            ),
          ],
        ),
      ),
    ],
  );
}

// 🎯 استقبال الـ sessionProvider الموثوق من الأعلى لمنع أي تضارب في الـ Context
Widget _buildControlButtons(BuildContext context, SessionProvider sessionProvider) {
  Patient? currentPatient = context.read<PatientProvider>().currentPatient;

  void finishSession() async {
    late ConfettiController _confettiController = ConfettiController(
      duration: const Duration(seconds: 1),
    );

    SoundManager.playSessionComplete();
    _confettiController.play();

    // 🎯 استدعاء الدالة الحقيقية بداخل البروفايدر الممرر والآمن تماماً الآن
    await sessionProvider.finishSession();

    // فتح شاشة النتيجة وتمرير البيانات الحقيقية المجمعة مية بالمية
     Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ResultScreen(
          session: PatientSession(
            sessionId: sessionProvider.currentFirebaseSessionKey ?? "session_id",
            exerciseId: sessionProvider.currentExercise?.id ?? "exercise_id",
            patientNumber: currentPatient?.id ?? "P123",
            sessionDate: DateTime.now(),
            duration: Duration(seconds: sessionProvider.secondsElapsed),
            progress: sessionProvider.completionPercentage,
            score: (sessionProvider.completionPercentage * 100).toInt(),
            gloveDataSummary: sessionProvider.currentGloveData,
            aiAnalysis: "Processing with AI...",
          ),
        ),
      ),);

  }

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
        ],
      ),
      const SizedBox(height: 10),
      SizedBox(
        height: 50,
        child: ElevatedButton(
          onPressed: () {
            finishSession();
          },
          child: const Text("End Session"),
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