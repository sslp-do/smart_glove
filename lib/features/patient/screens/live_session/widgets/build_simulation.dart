import 'package:flutter/material.dart';
import 'package:smart_glove/features/patient/screens/live_session/added/finger_snapshot.dart';
import 'package:smart_glove/features/patient/screens/live_session/added/hand_visual.dart';
import 'package:smart_glove/features/patient/screens/live_session/widgets/hand_visualizer.dart';

Widget buildSimulation(BuildContext context) {
  Theme.of(context);
  final cardColor = Colors.transparent;

  return Container(
    height: 400,
    width: double.infinity,
    decoration: BoxDecoration(
      color: cardColor,
      borderRadius: BorderRadius.circular(30),
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [cardColor, Theme.of(context).primaryColor.withOpacity(0.05)],
      ),
      boxShadow: [
        BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 20),
      ],
    ),
    child: ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(30)),
      child: /*HandVisualizer(
        sensorValue: 0.9,
        isTargetFist: true,
      ),*/ HandVisual(
        snapshot: FingerSnapshot(thumb: 23, index: 23, middle: 23, ring: 23, pinky: 23),
        weakFingerIndex: 0,
      ),
    ),
  );
}
