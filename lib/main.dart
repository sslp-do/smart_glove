import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:smart_glove/ui/shared/theme/app_colors.dart'; // Ensure this package is added to pubspec.yaml

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: const PatientDashboard(),
    ),
  );
}

class PatientDashboard extends StatelessWidget {
  const PatientDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    // Scaffold is the main layout structure
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Row(
        children: [
          // 1. Sidebar Navigation
          const SideMenu(),

          // 2. Main Content Area
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(32.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  HeaderSection(),
                  SizedBox(height: 30),
                  StartSessionCard(),
                  SizedBox(height: 30),
                  StatsGrid(),
                  SizedBox(height: 30),
                  ProgressChartSection(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------
// 1. Side Menu Widget
// ---------------------------------------------------------
class SideMenu extends StatelessWidget {
  const SideMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      width: 250,
      color: Colors.white,
      child: Column(
        children: [
          const SizedBox(height: 40),
          // App Logo area
          Icon(Icons.health_and_safety, size: 60, color: theme.primaryColor),
          const SizedBox(height: 10),
          Text("GloveRehab", style: theme.textTheme.titleLarge),
          const SizedBox(height: 50),

          // Menu Items
          _buildMenuItem(Icons.dashboard, "Dashboard", true, context),
          _buildMenuItem(Icons.analytics, "My Reports", false, context),
          _buildMenuItem(Icons.chat, "Chat with Therapist", false, context),
          _buildMenuItem(Icons.settings, "Settings", false, context),

          const Spacer(),
          _buildMenuItem(Icons.logout, "Logout", false, context, isRed: true),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  // Helper method to build menu items
  Widget _buildMenuItem(
    IconData icon,
    String title,
    bool isActive,
    BuildContext context, {
    bool isRed = false,
  }) {
    final theme = Theme.of(context);
    final color = isRed
        ? theme.colorScheme.error
        : (isActive ? theme.primaryColor : Colors.grey);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: isActive
          ? BoxDecoration(
              color: theme.colorScheme.secondary.withOpacity(0.5),
              borderRadius: BorderRadius.circular(10),
            )
          : null,
      child: ListTile(
        leading: Icon(
          icon,
          color: isRed
              ? theme.colorScheme.error
              : (isActive ? AppColors.success : theme.colorScheme.secondary),
        ),
        title: Text(
          title,
          style: TextStyle(
            color: isRed
                ? theme.colorScheme.error
                : (isActive ? AppColors.success : theme.colorScheme.secondary),
            fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        onTap: () {}, // Add navigation logic here
      ),
    );
  }
}

// ---------------------------------------------------------
// 2. Header Section (Greeting & Status)
// ---------------------------------------------------------
class HeaderSection extends StatelessWidget {
  const HeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Good Morning, Sarah 👋",
              style: theme.textTheme.displayMedium,
            ),
            Text(
              "Ready to make some progress today?",
              style: theme.textTheme.bodyMedium,
            ),
          ],
        ),
        // Glove Connection Status Indicator
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.green.shade200),
          ),
          child: Row(
            children: const [
              Icon(Icons.circle, color: AppColors.success, size: 12),
              SizedBox(width: 8),
              Text(
                "Glove Connected",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: AppColors.success,
                ),
              ),
              SizedBox(width: 8),
              Icon(Icons.bluetooth, color: Colors.green),
            ],
          ),
        ),
      ],
    );
  }
}

// ---------------------------------------------------------
// 3. Start Session Hero Card
// ---------------------------------------------------------
class StartSessionCard extends StatelessWidget {
  const StartSessionCard({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [theme.primaryColor, theme.primaryColor.withOpacity(0.8)],
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: theme.primaryColor.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Text(
                    "Today's Session",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  "Exercise: Full Hand Grip",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 5),
                const Text(
                  "Duration: 15 mins • Reps: 20",
                  style: TextStyle(color: Colors.white70),
                ),
                const SizedBox(height: 20),
                ElevatedButton.icon(
                  onPressed: () {
                    // Navigate to Live Session Screen
                  },
                  icon: const Icon(Icons.play_arrow),
                  label: const Text("Start Session Now"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: theme.primaryColor,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 12,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Illustration Icon (Can be replaced with an asset image)
          Icon(
            Icons.sports_gymnastics,
            size: 120,
            color: Colors.white.withOpacity(0.3),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------
// 4. Statistics Grid
// ---------------------------------------------------------
class StatsGrid extends StatelessWidget {
  const StatsGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [//okay
        _buildStatCard("Current Streak 🔥", "5 Days", Colors.orange, context),
        const SizedBox(width: 20),
        _buildStatCard("Total Sessions ✅", "12 Sessions", Colors.blue, context),
        const SizedBox(width: 20),
        _buildStatCard("Improvement 📈", "+15%", Colors.purple, context),
      ],
    );
  }

  Widget _buildStatCard(String title, String value, Color color, BuildContext context) {
    final theme = Theme.of(context);

    return Expanded(
      child: Card(
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(color: theme.colorScheme.secondary.withOpacity(0.1), blurRadius: 10),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: color.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.show_chart, color: color, size: 20),
                  ),
                  const SizedBox(width: 10),
                  Text(title, style: theme.textTheme.bodyMedium),
                ],
              ),
              const SizedBox(height: 15),
              Text(
                value,
                style: theme.textTheme.titleLarge,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ---------------------------------------------------------
// 5. Progress Chart Section (Using fl_chart)
// ---------------------------------------------------------
class ProgressChartSection extends StatelessWidget {
  const ProgressChartSection({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(24),
      height: 350,
      decoration: BoxDecoration(
        color: Colors.white,
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
                    sideTitles: SideTitles(showTitles: true, reservedSize: 40),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: true, reservedSize: 30),
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
                    spots: [
                      const FlSpot(0, 20),
                      const FlSpot(1, 35),
                      const FlSpot(2, 40),
                      const FlSpot(3, 38),
                      const FlSpot(4, 55),
                      const FlSpot(5, 60),
                      const FlSpot(6, 75),
                    ],
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

/*
class PatientDashboard extends StatelessWidget {
  const PatientDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    // استخدام لون الخلفية من الثيم مباشرة
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Row(
        children: [
          const SideMenu(),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(32.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  HeaderSection(),
                  SizedBox(height: 30),
                  StartSessionCard(),
                  SizedBox(height: 30),
                  StatsGrid(),
                  SizedBox(height: 30),
                  ProgressChartSection(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------
// 1. Side Menu (تعديل الألوان لتعكس الثيم)
// ---------------------------------------------------------
class SideMenu extends StatelessWidget {
  const SideMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      width: 250,
      color: Colors.white,
      child: Column(
        children: [
          const SizedBox(height: 40),
          Icon(Icons.health_and_safety, size: 60, color: theme.primaryColor),
          const SizedBox(height: 10),
          Text("GloveRehab", style: theme.textTheme.titleLarge),
          const SizedBox(height: 50),

          _buildMenuItem(context, Icons.dashboard, "Dashboard", true),
          _buildMenuItem(context, Icons.analytics, "My Reports", false),
          _buildMenuItem(context, Icons.chat, "Chat with Therapist", false),
          _buildMenuItem(context, Icons.settings, "Settings", false),

          const Spacer(),
          _buildMenuItem(context, Icons.logout, "Logout", false, isRed: true),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildMenuItem(BuildContext context, IconData icon, String title, bool isActive, {bool isRed = false}) {
    final theme = Theme.of(context);

    // الألوان تعتمد الآن على الثيم وحالة العنصر
    final color = isRed
        ? theme.colorScheme.error
        : (isActive ? theme.primaryColor : Colors.grey);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: isActive
          ? BoxDecoration(
          color: theme.colorScheme.secondary.withOpacity(0.5),
          borderRadius: BorderRadius.circular(12))
          : null,
      child: ListTile(
        leading: Icon(icon, color: color),
        title: Text(
          title,
          style: TextStyle(
            color: color,
            fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}

// ---------------------------------------------------------
// 2. Header Section (ربط حالات النجاح بالألوان)
// ---------------------------------------------------------
class HeaderSection extends StatelessWidget {
  const HeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Good Morning, Sarah 👋", style: theme.textTheme.displayMedium),
            Text("Ready to make some progress today?", style: theme.textTheme.bodyMedium),
          ],
        ),
        // مؤشر حالة القفاز (استخدام لون Success من كلاس الألوان)
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
           // color: AppColors.success.withOpacity(0.1),
            borderRadius: BorderRadius.circular(30),
            border: Border.all(*/
/*color: AppColors.success.withOpacity(0.2)*/ /*
),
          ),
          child: Row(
            children: [
              Icon(Icons.circle, */
/*color: AppColors.success, size: 10*/ /*
),
              const SizedBox(width: 8),
              Text("Connected", style: TextStyle(*/
/*color: AppColors.success,*/ /*
 fontWeight: FontWeight.bold)),
            ],
          ),
        )
      ],
    );
  }
}

// ---------------------------------------------------------
// 3. Start Session Card (استخدام التدرج اللوني للاحترافية)
// ---------------------------------------------------------
class StartSessionCard extends StatelessWidget {
  const StartSessionCard({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [theme.primaryColor, theme.primaryColor.withOpacity(0.8)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: theme.primaryColor.withOpacity(0.2),
            blurRadius: 15,
            offset: const Offset(0, 8),
          )
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("TODAY'S PLAN", style: TextStyle(color: Colors.white.withOpacity(0.8), letterSpacing: 1.2, fontWeight: FontWeight.bold, fontSize: 12)),
                const SizedBox(height: 10),
                const Text("Full Hand Grip Exercise", style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.white)),
                const SizedBox(height: 20),
                // استخدام ElevatedButtonTheme المرفق بالثيم تلقائياً
                SizedBox(
                  width: 200,
                  child: ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.play_arrow_rounded),
                    label: const Text("Start Session"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: theme.primaryColor,
                    ),
                  ),
                )
              ],
            ),
          ),
          Icon(Icons.front_hand_rounded, size: 100, color: Colors.white.withOpacity(0.2)),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------
// 4. Stats Grid (تحويلها إلى بطاقات نظيفة)
// ---------------------------------------------------------
class StatsGrid extends StatelessWidget {
  const StatsGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _buildStatCard(context, "Streak", "5 Days", Icons.local_fire_department, Colors.orange),
        const SizedBox(width: 20),
        _buildStatCard(context, "Sessions", "12 Done", Icons.check_circle, AppColors.primary),
        const SizedBox(width: 20),
        _buildStatCard(context, "Improvement", "+15%", Icons.trending_up, Colors.purple),
      ],
    );
  }

  Widget _buildStatCard(BuildContext context, String title, String value, IconData icon, Color color) {
    return Expanded(
      child: Card( // سيأخذ شكل البطاقة المحدد في CardTheme تلقائياً
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(icon, color: color),
              const SizedBox(height: 15),
              Text(title, style: Theme.of(context).textTheme.bodyMedium),
              const SizedBox(height: 5),
              Text(value, style: Theme.of(context).textTheme.titleLarge),
            ],
          ),
        ),
      ),
    );
  }
}

// ---------------------------------------------------------
// 5. Progress Chart Section (Using fl_chart)
// ---------------------------------------------------------
class ProgressChartSection extends StatelessWidget {
  const ProgressChartSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      height: 350,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.1), blurRadius: 10)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Range of Motion Progress (Last 7 Days)", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 20),
          Expanded(
            // Simplified line chart configuration
            child: LineChart(
              LineChartData(
                gridData: FlGridData(show: false),
                titlesData: FlTitlesData(
                  leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: true, reservedSize: 40)),
                  bottomTitles: AxisTitles(sideTitles: SideTitles(showTitles: true, reservedSize: 30)),
                  topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                ),
                borderData: FlBorderData(show: false),
                lineBarsData: [
                  LineChartBarData(
                    spots: [
                      const FlSpot(0, 20),
                      const FlSpot(1, 35),
                      const FlSpot(2, 40),
                      const FlSpot(3, 38),
                      const FlSpot(4, 55),
                      const FlSpot(5, 60),
                      const FlSpot(6, 75),
                    ],
                    isCurved: true,
                    color: AppColors.primary,
                    barWidth: 4,
                    isStrokeCapRound: true,
                    dotData: FlDotData(show: false),
                    belowBarData: BarAreaData(show: true, color: AppColors.primary.withOpacity(0.1)),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}*/
