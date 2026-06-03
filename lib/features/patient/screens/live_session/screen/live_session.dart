import 'dart:math';
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_glove/core/models/sound_manager.dart';
import 'package:smart_glove/features/patient/models/exercise_model.dart';
import 'package:smart_glove/features/patient/providers/glove_provider.dart';
import 'package:smart_glove/features/patient/providers/session_provider.dart';
import 'package:smart_glove/features/patient/screens/live_session/widgets/build_sensor_state.dart';
import 'package:smart_glove/features/patient/screens/live_session/widgets/control_section.dart';
import 'package:smart_glove/features/patient/screens/live_session/widgets/simulation_section.dart';

class LiveSessionScreen extends StatefulWidget {
  final Exercise currentExercise;

  LiveSessionScreen({super.key, required this.currentExercise});

  @override
  State<LiveSessionScreen> createState() => _LiveSessionScreenState();
}

class _LiveSessionScreenState extends State<LiveSessionScreen> {
  double sensorValue = 0.0;
  bool isTargetReached = false;

  bool _hasPlayedSuccessSound =
      false; // True if the success sound has been played

  late ConfettiController _confettiController;

  void simulateGloveData() {
    // Bluetooth code here
    setState(() {
      sensorValue = 0.85;

      if (sensorValue > 0.8) {
        if (!_hasPlayedSuccessSound) {
          SoundManager.playSuccess();

          _hasPlayedSuccessSound = true;

          // repetitionsCount++;
        }
      } else {
        _hasPlayedSuccessSound = false;
      }
    });
  }

  void finishSession() {
    SoundManager.playSessionComplete();
    _confettiController.play();

   // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>  ResultScreen(session:)));

    /*   showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(
          "Great Job! 🎉",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
        ),
        content: const Text(
          "Session completed successfully. See you tomorrow!",
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("Done"),
          ),
        ],
      ),*/

  }

  @override
  void initState() {
    super.initState();
    _confettiController = ConfettiController(
      duration: const Duration(seconds: 3),
    );
    //context.read<SessionProvider>().startSession(new Exercise(id: "id", name: "name", description: "description", tutorialImageUrl: "tutorialImageUrl", targetData: FingerData(thumb: 55, index: 8, middle: 23, ring: 23, little: 12), targetRepetitions: 6, duration: 45, difficulty: "low", category: "category"));;
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bgColor = Theme.of(context).scaffoldBackgroundColor;
    final sessionProvider = context.watch<SessionProvider>();
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        title: const Text("Live Session"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          Spacer(),
          buildSensorState(context.watch<GloveProvider>().status.isConnected),

        ],
      ),
      body: Stack(
        children: [
          Row(
            children: [
              // left side : simulation (60%)
              simulationSection(),
              // right side : control (40%)
              controlSection(sessionProvider: sessionProvider,),
            ],
          ),

          Align(
            alignment: Alignment.topCenter,
            child: ConfettiWidget(
              confettiController: _confettiController,
              blastDirectionality: BlastDirectionality.explosive,
              shouldLoop: false,
              colors: const [
                Colors.green,
                Colors.blue,
                Colors.pink,
                Colors.orange,
                Colors.purple,
              ],
              createParticlePath: (size) => _drawStar(size),
            ),
          ),
        ],
      ),
    );
  }
}

Path _drawStar(Size size) {
  double degToRad(double deg) => deg * (pi / 180.0);
  const numberOfPoints = 5;
  final halfWidth = size.width / 2;
  final externalRadius = halfWidth;
  final internalRadius = halfWidth / 2.5;
  final degreesPerStep = degToRad(360 / numberOfPoints);
  final halfDegreesPerStep = degreesPerStep / 2;
  final path = Path();
  final fullAngle = degToRad(360);
  path.moveTo(size.width, halfWidth);

  for (double step = 0; step < fullAngle; step += degreesPerStep) {
    path.lineTo(
      halfWidth + externalRadius * cos(step),
      halfWidth + externalRadius * sin(step),
    );
    path.lineTo(
      halfWidth + internalRadius * cos(step + halfDegreesPerStep),
      halfWidth + internalRadius * sin(step + halfDegreesPerStep),
    );
  }
  path.close();
  return path;
}


