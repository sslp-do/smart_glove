import 'package:flutter/material.dart';

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
            _buildHeader(context, "Fist Grip Exercise", "Repetition: 3/10"),

            const Spacer(),

            // simulation
            _buildSimulation(context),

            const Spacer(),

            // bold instructions
            _buildInstructions(context),
          ],
        ),
      ),
    );
  }
}

Widget _buildHeader(BuildContext context, String title, String subtitle) {
  final theme = Theme.of(context);
  final textColor = Theme.of(context).textTheme.titleLarge?.color;
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: theme.textTheme.displayMedium),
          const SizedBox(height: 5),
          Text(
            "Target Muscle: Flexor Auditorium",
            style: theme.textTheme.bodyMedium,
          ),
        ],
      ),
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: theme.primaryColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          subtitle,
          style: theme.textTheme.titleLarge!.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ],
  );
}

Widget _buildSimulation(BuildContext context) {
  final theme = Theme.of(context);
  final cardColor = theme.cardTheme.color;
  final primaryColor = theme.primaryColor;

  return Container(
    height: 400,
    width: double.infinity,
    decoration: BoxDecoration(
      color: cardColor,
      borderRadius: BorderRadius.circular(30),
      boxShadow: [
        BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 20),
      ],
    ),
    child: Stack(
      alignment: Alignment.center,
      children: [
        Icon(Icons.grid_4x4, size: 200, color: Colors.grey.withOpacity(0.1)),

        // Hand simulation
        Icon(Icons.pan_tool, size: 180, color: primaryColor),

        // Description text
        Positioned(
          bottom: 20,
          child: Text(
            "Visual Simulation Area",
            style: TextStyle(color: theme.textTheme.bodyMedium?.color),
          ),
        ),
      ],
    ),
  );
}

Widget _buildInstructions(BuildContext context) {
  final theme = Theme.of(context);
  final primaryColor = theme.primaryColor;

  return Container(
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      color: primaryColor.withOpacity(0.1),
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: primaryColor.withOpacity(0.3)),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.info_outline, color: primaryColor),
        const SizedBox(width: 10),
        Text(
          "Squeeze your hand tightly...",
          style: theme.textTheme.displayMedium!.copyWith(
            color: theme.primaryColor,
            fontSize: 22,
          ),
        ),
      ],
    ),
  );
}
