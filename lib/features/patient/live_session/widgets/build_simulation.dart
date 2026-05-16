import 'package:flutter/material.dart';
import 'package:smart_glove/features/patient/live_session/widgets/hand_visualizer.dart';

Widget buildSimulation(BuildContext context) {
  final theme = Theme.of(context);
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
    child:
    const ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(30)),
      child: HandVisualizer(
        sensorValue: 0.9,
        isTargetFist: true,
      ),
    ),
  );
}