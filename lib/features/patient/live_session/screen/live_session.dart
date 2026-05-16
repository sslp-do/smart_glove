import 'dart:math';

import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_glove/core/utils/sound_manager.dart';
import 'package:smart_glove/features/patient/live_session/widgets/build_sensor_state.dart';
import 'package:smart_glove/features/patient/live_session/widgets/control_section.dart';
import 'package:smart_glove/features/patient/live_session/widgets/simulation_section.dart';
import 'package:smart_glove/features/patient/models/exercise_model.dart';
import 'package:smart_glove/features/patient/providers/glove_provider.dart';
import 'package:smart_glove/features/patient/providers/patient_provider.dart';
import 'package:smart_glove/features/patient/providers/session_provider.dart';


class LiveSessionScreen extends StatefulWidget {
  final Exercise currentExercise ;
   LiveSessionScreen({super.key , required this.currentExercise});

  @override
  State<LiveSessionScreen> createState() => _LiveSessionScreenState();
}

class _LiveSessionScreenState extends State<LiveSessionScreen> {

  double sensorValue = 0.0;
  bool isTargetReached = false;

  bool _hasPlayedSuccessSound = false; // True if the success sound has been played

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
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Great Job! 🎉", style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30),),
        content: const Text("Session completed successfully. See you tomorrow!"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("Done"),
          )
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _confettiController = ConfettiController(duration: const Duration(seconds: 3));

    // القاعدة: تشغيل الجلسة بيصير مرة واحدة عند فتح الشاشة، لهيك بنستخدم read
    try {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        // نفترض أننا مجهزين التمرين في البروفايدر الآخر، أو بنمرره للشاشة
         context.read<SessionProvider>().startSession(widget.currentExercise);
      });
    } on Exception catch (e) {
      print(e.toString());
    }
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
  /*  context.read<PatientProvider>().fetchNextExercise("patientId");
    Exercise nextExercise = context.read<PatientProvider>().nextExercise!;
    context.read<SessionProvider>().startSession(nextExercise);*/
    final sessionWatch = context.watch<SessionProvider>();
    final bgColor = Theme
        .of(context)
        .scaffoldBackgroundColor;

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        title: const Text("Live Session"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
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
              controlSection(),
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
                Colors.purple
              ],
              createParticlePath: (size) => SessionProvider().drawStar(size),
            ),
          ),
        ],
      ),
    );
  }
}





