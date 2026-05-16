import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_glove/features/patient/live_session/widgets/build_header.dart';
import 'package:smart_glove/features/patient/live_session/widgets/build_instruction.dart';
import 'package:smart_glove/features/patient/live_session/widgets/build_simulation.dart';
import 'package:smart_glove/features/patient/live_session/widgets/hand_visualizer.dart';
import 'package:smart_glove/features/patient/providers/session_provider.dart';

class simulationSection extends StatelessWidget {
  const simulationSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 6,
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            // Exercise name
            buildHeader(context),

            const Spacer(),

            // simulation
            buildSimulation(context),

            const Spacer(),

            // instructions
            buildInstructions(context),
          ],
        ),
      ),
    );
  }
}






