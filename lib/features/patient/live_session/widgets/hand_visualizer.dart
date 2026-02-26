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


    Color activeColor = isMatched
        ? Colors.green
        : Theme.of(context).secondaryHeaderColor;

    return Stack(
      alignment: Alignment.center,
      children: [
        // Instruction hand overlay
        _buildHandIcon(
          imagePath: isTargetFist ? AppAssets.openedHand: AppAssets.closedHand,
          color: Colors.grey.withOpacity(0.2),
          scale: 1.1,
          label: "Target",
        ),

      // Real hand overlay
       // 1. Opened hand
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
        ),

       // Check mark
       Positioned(
           right: 20,top: 20,
           child: Icon(Icons.check_circle,color: activeColor,)),

       // Feedback overlay
        if (isMatched)
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


  Widget _buildHandIcon({
    required String imagePath,
    required Color color,
    double scale = 1.0,
    String? label,
  }) {
    return Transform.scale(
      scale: scale * 4.0,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
        Image.asset(imagePath, width: 150, height: 150),
/*
       Image.network("https://th.bing.com/th/id/OIP.oQvk6F0RDeSwy-Nf2ZCd5wHaH_?w=157&h=180&c=7&r=0&o=7&dpr=1.3&pid=1.7&rm=3")
*/
       //   Icon(icon, color: color),
         if (label != null) ...[
            const SizedBox(height: 5),
            Text(
              label,
              style: TextStyle(
                fontSize: 4,
                color: color,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
