import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_glove/features/patient/providers/patient_provider.dart';

class ProgressChartSection extends StatelessWidget {
final Map<String , int> weeklyProgress ;
  const ProgressChartSection({super.key , required this.weeklyProgress});

  @override
  Widget build(BuildContext context) {
    final sortedKeys = weeklyProgress.keys.toList()..sort();
    final List<FlSpot> spots = sortedKeys.asMap().entries.map((entry) {
      int index = entry.key;
      String dateKey = entry.value;
      return FlSpot(index.toDouble(), weeklyProgress[dateKey]!.toDouble());
    }).toList();

    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(24),
      height: 350,
      decoration: BoxDecoration(
        color: theme.cardTheme.color,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: Colors.grey.withOpacity(0.1), blurRadius: 10),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Range of Motion Progress (Last 7 Days)",
            style: theme.textTheme.titleLarge,
          ),
          const SizedBox(height: 20),
          Expanded(
            // Simplified line chart configuration
            child: LineChart(
              LineChartData(
                gridData: FlGridData(show: false),
                titlesData: FlTitlesData(
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: false, reservedSize: 40),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: true, reservedSize: 30, interval: 1),
                  ),
                  topTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  rightTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                ),
                borderData: FlBorderData(show: false),
                lineBarsData: [
                  LineChartBarData(
                    spots: spots.isEmpty ? [const FlSpot(0, 0)] : spots,
                    isCurved: true,
                    color: theme.primaryColor,
                    barWidth: 4,
                    isStrokeCapRound: true,
                    dotData: FlDotData(show: false),
                    belowBarData: BarAreaData(
                      show: true,
                      color: theme.primaryColor.withOpacity(0.1),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}