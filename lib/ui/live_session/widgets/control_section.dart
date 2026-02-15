import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class controlSection extends StatelessWidget {
  const controlSection({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cardColor = theme.cardTheme.color;
    final textColor = theme.textTheme.titleLarge?.color;

    return Expanded(
      flex: 4,
      child: Container(
        padding: const EdgeInsets.all(24),
        color: cardColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Session Metrics",
              style: theme.textTheme.titleLarge!.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 30),

            //Indicators
            _buildIndicators(context),

            const Spacer(),

            // Live chart
            _buildLiveChart(context),

            const Spacer(),

            // Control Buttons
            _buildControlButtons(context),
          ],
        ),
      ),
    );
  }
}

Widget _buildIndicators(BuildContext context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      // strength indicator
      _strengthIndicator(context,0.75),

      SizedBox(width: 20),

      // Timer indicator
      _timerIndicator(context,0.7),
    ],
  );
}

Widget _strengthIndicator(BuildContext context, double currentProgress) {
  final theme = Theme.of(context);
  final textColor = theme.textTheme.titleLarge?.color;

  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text(
        "Grip Strength",
        style: theme.textTheme.titleLarge,
      ),
      const SizedBox(height: 20),
      Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          boxShadow: [
            BoxShadow(
              color: Colors.green.withOpacity(0.2),
              blurRadius: 20,
              spreadRadius: 4,
            ),
          ],
        ),
        child: CircularPercentIndicator(
          radius: 80.0,
          lineWidth: 15.0,
          animation: true,
          percent: currentProgress,
          center: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "${(currentProgress*100).toInt()}%",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30.0,
                  color: textColor,
                ),
              ),
              Text(
                "Power",
                style: theme.textTheme.bodyMedium,
              ),
            ],
          ),
          circularStrokeCap: CircularStrokeCap.round,
          backgroundColor: Colors.grey.withOpacity(0.2),
          progressColor: currentProgress > 0.7 ? Colors.green : Colors.orange,
        ),
      ),
    ],
  );
}

Widget _timerIndicator(BuildContext context , double timerValue) {
  final theme = Theme.of(context);
  final textColor = theme.textTheme.titleLarge?.color;

  return Column(
    children: [
      Text("Timer", style: Theme.of(context).textTheme.titleLarge),
      SizedBox(height: 20),
      Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              width: 150,
              height: 150,
              child: CircularProgressIndicator(
                value: timerValue,
                strokeWidth: 12,
                backgroundColor: Colors.grey.withOpacity(0.1),
                color: theme.primaryColor,
              ),
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "04:20",
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: textColor,
                  ),
                ),
                const Text("Remaining", style: TextStyle(color: Colors.grey)),
              ],
            ),
          ],
        ),
      ),
    ],
  );
}

Widget _buildLiveChart(BuildContext context) {
  final theme = Theme.of(context);

  return Column(
    children: [
      Text(
        "Force Sensor Data",
        style: theme.textTheme.titleLarge,
      ),
      const SizedBox(height: 10),
      SizedBox(
        height: 150,
        child: LineChart(
          LineChartData(
            gridData: FlGridData(show: false),
            titlesData: FlTitlesData(show: false),
            borderData: FlBorderData(
              show: true,
              border: Border.all(color: Colors.grey.withOpacity(0.2)),
            ),
            lineBarsData: [
              LineChartBarData(
                spots: [
                  const FlSpot(0, 1),
                  const FlSpot(1, 1.5),
                  const FlSpot(2, 1.4),
                  const FlSpot(3, 3.4),
                  const FlSpot(4, 2),
                  const FlSpot(5, 2.2),
                  const FlSpot(6, 1.8),
                ],
                isCurved: true,
                color: Colors.orange,
                barWidth: 3,
                dotData: FlDotData(show: false),
                belowBarData: BarAreaData(
                  show: true,
                  color: Colors.orange.withOpacity(0.1),
                ),
              ),
            ],
          ),
        ),
      ),
    ],
  );
}

Widget _buildControlButtons(BuildContext context) {
  return Row(
    children: [
      Expanded(
        child: ElevatedButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.pause),
          label: const Text("Pause"),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.amber[700],
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 16),
          ),
        ),
      ),
      const SizedBox(width: 16),
      Expanded(
        child: ElevatedButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.stop),
          label: const Text("Stop"),
          style: ElevatedButton.styleFrom(
            backgroundColor: Theme.of(context).colorScheme.error,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 16),
          ),
        ),
      ),
    ],
  );
}
