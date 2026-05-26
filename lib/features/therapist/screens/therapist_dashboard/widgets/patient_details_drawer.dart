import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class PatientDetailsDrawer extends StatelessWidget {
  const PatientDetailsDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Drawer(
      width: 450,
      backgroundColor: theme.scaffoldBackgroundColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Header
          Container(
            padding: const EdgeInsets.all(32.0),
            color: theme.cardTheme.color,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Patient Profile", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () => Navigator.pop(context),
                    )
                  ],
                ),
                const SizedBox(height: 20),
                const CircleAvatar(radius: 40, backgroundColor: Colors.cyan, child: Icon(Icons.person, size: 40, color: Colors.white)),
                const SizedBox(height: 15),
                Text("Sarah Connor", style: theme.textTheme.displayMedium?.copyWith(fontSize: 24)),
                const SizedBox(height: 5),
                Text("Affected Hand: Left • Age: 28", style: TextStyle(color: Colors.grey[600])),

                const SizedBox(height: 20),

                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () {},
                        icon: const Icon(Icons.edit_note, size: 18),
                        label: const Text("Edit Plan"),
                        style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 12)),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () {},
                        icon: const Icon(Icons.chat_bubble_outline, size: 18),
                        label: const Text("Message"),
                        style: OutlinedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 12)),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),

          // Content
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(32.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 1. Chart
                  Text("Range of Motion (ROM) Progress", style: theme.textTheme.titleLarge),
                  const SizedBox(height: 20),
                  Container(
                    height: 200,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: theme.cardTheme.color,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey.withOpacity(0.2)),
                    ),
                    child: LineChart(
                      LineChartData(
                        gridData: FlGridData(show: true, drawVerticalLine: false),
                        titlesData: FlTitlesData(
                          rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                          topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                          bottomTitles: AxisTitles(sideTitles: SideTitles(showTitles: true, reservedSize: 22)),
                        ),
                        borderData: FlBorderData(show: false),
                        lineBarsData: [
                          LineChartBarData(
                            spots: const [
                              FlSpot(1, 30), FlSpot(2, 45), FlSpot(3, 50), FlSpot(4, 65), FlSpot(5, 75),
                            ],
                            isCurved: true,
                            color: Colors.green,
                            barWidth: 4,
                            belowBarData: BarAreaData(show: true, color: Colors.green.withOpacity(0.1)),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 40),

                  // 2. Current Plan
                  Text("Current Plan", style: theme.textTheme.titleLarge),
                  const SizedBox(height: 15),
                  _buildPlanItem(context, "Fist Grip", "3 sets of 15 reps", Icons.back_hand),
                  _buildPlanItem(context, "Finger Extension", "2 sets of 10 reps", Icons.pan_tool),
                  _buildPlanItem(context, "Wrist Rotation", "5 mins duration", Icons.rotate_right),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ويدجت مساعدة لعرض التمارين
  Widget _buildPlanItem(BuildContext context, String title, String desc, IconData icon) {
    final theme = Theme.of(context);
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.cardTheme.color,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.withOpacity(0.1)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(color: theme.primaryColor.withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
            child: Icon(icon, color: theme.primaryColor),
          ),
          const SizedBox(width: 15),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
              Text(desc, style: TextStyle(color: Colors.grey[600], fontSize: 13)),
            ],
          )
        ],
      ),
    );
  }
}