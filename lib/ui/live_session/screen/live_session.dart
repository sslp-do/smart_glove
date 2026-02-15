import 'package:flutter/material.dart';
import 'package:smart_glove/ui/live_session/widgets/control_section.dart';
import 'package:smart_glove/ui/live_session/widgets/sensor_state.dart';
import 'package:smart_glove/ui/live_session/widgets/simulation_section.dart';

class LiveSessionScreen extends StatelessWidget {
  const LiveSessionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bgColor = Theme
        .of(context)
        .scaffoldBackgroundColor;

    return Scaffold(
      backgroundColor: bgColor,
      appBar: _buildAppBar(context),
      body: Row(
        children: [
          // left side : simulation (60%)
          simulationSection(),
          // right side : control (40%)
          controlSection(),
        ],
      ),
    );
  }
}

PreferredSizeWidget _buildAppBar(BuildContext context){
  return AppBar(
    title: const Text("Live Session"),
    leading: IconButton(
      icon: const Icon(Icons.arrow_back_ios),
      onPressed: () => Navigator.pop(context),
    ),
    actions: [
      IconButton(
        icon: const Icon(Icons.settings),
        onPressed: () {},
      ),
      sensorState(),
    ],
  );
}

