import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:smart_glove/core/theme/app_colors.dart';
import 'package:percent_indicator/percent_indicator.dart';

class LiveSessionScreen extends StatelessWidget {
  const LiveSessionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bgColor = Theme.of(context).scaffoldBackgroundColor;
    final cardColor = Theme.of(context).cardTheme.color;
    final primaryColor = Theme.of(context).primaryColor;
    final textColor = Theme.of(context).textTheme.titleLarge?.color;

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
          Container(
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
          ),
        ],
      ),
      body: Row(
        children: [
          // -------------------------------------------------------
          // left side : simulation (60%)
          // -------------------------------------------------------
          Expanded(
            flex: 6,
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: [
                  // Exercise name
                  _buildHeader(
                    context,
                    "Fist Grip Exercise",
                    "Repetition: 3/10",
                  ),

                  const Spacer(),

                  // simulation
                  Container(
                    height: 400,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: cardColor,
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 20,
                        ),
                      ],
                    ),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Icon(
                          Icons.grid_4x4,
                          size: 200,
                          color: Colors.grey.withOpacity(0.1),
                        ),

                       // hand simulation
                        Icon(Icons.pan_tool, size: 180, color: primaryColor),

                       // description text
                        Positioned(
                          bottom: 20,
                          child: Text(
                            "Visual Simulation Area",
                            style: TextStyle(
                              color: Colors.grey.withOpacity(0.5),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const Spacer(),

                  // bold instructions
                  Container(
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
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                 // const SizedBox(height: 20),
                ],
              ),
            ),
          ),

          // -------------------------------------------------------
          // right side : control (40%)
          // -------------------------------------------------------
          Expanded(
            flex: 4,
            child: Container(
              padding: const EdgeInsets.all(24),
              color: cardColor,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Session Metrics",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: textColor,
                    ),
                  ),

                  const SizedBox(height: 30),

                  Column(
                    children: [
                      // indicators
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          // strength indicator
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Grip Strength",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: textColor,
                                ),
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
                                  // حجم كبير
                                  lineWidth: 15.0,
                                  // سمك الشريط
                                  animation: true,
                                  percent: 0.75,
                                  // هذه القيمة تأتي من القفاز (0.0 إلى 1.0)
                                  center: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "75%", // النسبة المئوية
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 30.0,
                                          color: textColor,
                                        ),
                                      ),
                                      Text(
                                        "Power",
                                        style: TextStyle(
                                          fontSize: 14.0,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ],
                                  ),
                                  circularStrokeCap: CircularStrokeCap.round,
                                  // حواف دائرية ناعمة
                                  backgroundColor: Colors.grey.withOpacity(0.2),
                                  // لون متغير: أخضر إذا فوق 70%، برتقالي إذا أقل
                                  progressColor: 0.75 > 0.7
                                      ? Colors.green
                                      : Colors.orange,
                                ),
                              ),
                            ],
                          ),

                          SizedBox(width: 20,),

                         // Timer indicator
                          Column(
                            children: [
                              Text("Timer",style: Theme.of(context).textTheme.titleLarge,),
                              SizedBox(height: 20,),
                              Center(
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    SizedBox(
                                      width: 150,
                                      height: 150,
                                      child: CircularProgressIndicator(
                                        value: 0.7, // قيمة افتراضية
                                        strokeWidth: 12,
                                        backgroundColor: Colors.grey.withOpacity(0.1),
                                        color: primaryColor,
                                      ),
                                    ),
                                    Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text("04:20", style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: textColor)),
                                        const Text("Remaining", style: TextStyle(color: Colors.grey)),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),

                    ],
                  ),

                  const SizedBox(height: 40),

                  // Live chart
                  Text(
                    "Force Sensor Data",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: textColor,
                    ),
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
                          border: Border.all(
                            color: Colors.grey.withOpacity(0.2),
                          ),
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

                  const Spacer(),

                  // Control Buttons
                  Row(
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
                            backgroundColor: AppColors.error,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context, String title, String subtitle) {
    final textColor = Theme.of(context).textTheme.titleLarge?.color;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: textColor,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              "Target Muscle: Flexor Digitorum",
              style: TextStyle(color: Colors.grey[600], fontSize: 14),
            ),
          ],
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            subtitle,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ),
      ],
    );
  }
}
