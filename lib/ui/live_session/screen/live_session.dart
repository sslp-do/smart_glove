import 'package:flutter/material.dart';
import 'package:smart_glove/ui/live_session/widgets/control_section.dart';
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
      appBar: AppBar(
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
          _buildSensorState(context),
        ],
      ),
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

