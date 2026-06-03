import 'package:flutter/material.dart';
import 'package:smart_glove/core/models/assets.dart';

class HandVisualizer extends StatelessWidget {
  final double sensorValue;
  final bool isTargetFist; //

  const HandVisualizer({
    super.key,
    required this.sensorValue, // From 0 to 1 (open to close)
    required this.isTargetFist, // True if the target is a fist
  });

  @override
  Widget build(BuildContext context) {
    bool isMatched =
        (isTargetFist && sensorValue > 0.8) ||
            (!isTargetFist && sensorValue < 0.2);
//bool goalReached = context.watch<SessionProvider>().completionPercentage == 100;

    Color activeColor = isMatched
        ? Colors.green
        : Theme
        .of(context)
        .secondaryHeaderColor;

    return Stack(
      alignment: Alignment.center,
      children: [

        // Real hand overlay
        Image.asset(AppAssets.gripExercise),
     /*   // 1. Opened hand
        Opacity(
          opacity: (1.0 - sensorValue).clamp(0.0, 1.0),
          child: _buildHandIcon(
            imagePath: AppAssets.openedHand,
            color: activeColor,
            scale: 1.0,
          ),
        ),

        // 2. Closed hand
        Opacity(
          opacity: sensorValue.clamp(0.0, 1.0),
          child: _buildHandIcon(
            imagePath: AppAssets.closedHand,
            color: activeColor,
            scale: 0.95,
          ),
        ),*/

        // Check mark
        Positioned(
            right: 20, top: 20,
            child: Icon(Icons.check_circle, color: activeColor,)),

        // Feedback overlay
        //if (goalReached)
          Positioned(
            top: 20,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.green.withOpacity(0.4),
                    blurRadius: 10,
                  ),
                ],
              ),
              child: const Row(
                children: [
                  Icon(Icons.check, color: Colors.white, size: 20),
                  SizedBox(width: 5),
                  Text(
                    "Perfect Hold!",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }


}
