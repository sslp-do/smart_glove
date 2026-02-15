import 'dart:math';

import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:smart_glove/ui/live_session/widgets/control_section.dart';
import 'package:smart_glove/ui/live_session/widgets/simulation_section.dart';
import 'package:smart_glove/utils/sound_manager.dart';

class LiveSessionScreen extends StatefulWidget {
  const LiveSessionScreen({super.key});

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
        title: const Text("Great Job! 🎉"),
        content: const Text("Session completed successfully. See you tomorrow!"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
           /*   Navigator.pop(context);*/
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
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }




  @override
  Widget build(BuildContext context) {
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
          IconButton(
            icon: const Icon(Icons.check_circle),
            onPressed: () { simulateGloveData();},
          ), IconButton(
            icon: const Icon(Icons.share_arrival_time),
            onPressed: () { SoundManager.playSessionComplete();
              finishSession();
              },
          ),

          _buildSensorState(context),
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
              createParticlePath: drawStar,
            ),
          ),
        ],
      ),
    );
  }
}

Widget _buildSensorState(BuildContext context){
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
    padding: const EdgeInsets.symmetric(horizontal: 12),
    decoration: BoxDecoration(
      color: Colors.green.withOpacity(0.1),
      borderRadius: BorderRadius.circular(20),
      border: Border.all(color: Colors.green),
    ),
    child: Row(
      children: const [
        Icon(Icons.link, color: Colors.green, size: 16),
        SizedBox(width: 8),
        Text(
          "Sensor Active",
          style: TextStyle(
            color: Colors.green,
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
        ),
      ],
    ),
  );
}

Path drawStar(Size size) {
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
    path.lineTo(halfWidth + externalRadius * cos(step), halfWidth + externalRadius * sin(step));
    path.lineTo(halfWidth + internalRadius * cos(step + halfDegreesPerStep), halfWidth + internalRadius * sin(step + halfDegreesPerStep));
  }
  path.close();
  return path;
}



