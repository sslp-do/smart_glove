import 'package:flutter/material.dart';

class TherapistDashboard extends StatelessWidget {
  const TherapistDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bgColor = theme.scaffoldBackgroundColor;

    return Scaffold(
      backgroundColor: bgColor,
      body: Row(
        children: [
          // 1. القائمة الجانبية الخاصة بالمعالج (أدمن)
          const AdminSideMenu(),

          // 2. مساحة العمل الرئيسية
          Expanded(
            child: Column(
              children: [
                // الشريط العلوي (بحث وإشعارات)
                const AdminTopBar(),

                // المحتوى القابل للتمرير
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(32.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Clinic Overview", style: theme.textTheme.displayMedium),
                        const SizedBox(height: 30),

                        // شريط الإحصائيات السريعة
                        const AdminStatsRow(),
                        const SizedBox(height: 30),

                        // القسم السفلي المقسوم (المرضى + تقارير الذكاء الاصطناعي)
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // قائمة المرضى النشطين (تأخذ مساحة أكبر)
                            Expanded(
                              flex: 6,
                              child: const ActivePatientsTable(),
                            ),
                            const SizedBox(width: 30),
                            // طابور تقارير الذكاء الاصطناعي (ميزة المشروع الجوهرية)
                            Expanded(
                              flex: 4,
                              child: const AIReportsQueue(),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// =========================================================
// 1. القائمة الجانبية للأدمن (Admin Side Menu)
// =========================================================
class AdminSideMenu extends StatelessWidget {
  const AdminSideMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final cardColor = Theme.of(context).cardTheme.color;
    final primaryColor = Theme.of(context).primaryColor;

    return Container(
      width: 250,
      color: cardColor,
      child: Column(
        children: [
          const SizedBox(height: 40),
          Icon(Icons.admin_panel_settings, size: 60, color: primaryColor),
          const SizedBox(height: 10),
          const Text("Dr. Dashboard", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 50),

          _buildMenuItem(context, Icons.grid_view, "Overview", true),
          _buildMenuItem(context, Icons.people_outline, "All Patients", false),
          _buildMenuItem(context, Icons.fitness_center, "Exercises Library", false),
          _buildMenuItem(context, Icons.analytics_outlined, "AI Analytics", false),

          const Spacer(),
          _buildMenuItem(context, Icons.logout, "Logout", false, isRed: true),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildMenuItem(BuildContext context, IconData icon, String title, bool isActive, {bool isRed = false}) {
    final theme = Theme.of(context);
    final primaryColor = theme.primaryColor;
    final textColor = isRed ? Colors.redAccent : (isActive ? primaryColor : theme.textTheme.bodyMedium?.color);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: isActive
          ? BoxDecoration(color: primaryColor.withOpacity(0.1), borderRadius: BorderRadius.circular(10))
          : null,
      child: ListTile(
        leading: Icon(icon, color: textColor),
        title: Text(title, style: TextStyle(color: textColor, fontWeight: isActive ? FontWeight.bold : FontWeight.normal)),
        onTap: () {},
      ),
    );
  }
}

// =========================================================
// 2. الشريط العلوي (Top Bar)
// =========================================================
class AdminTopBar extends StatelessWidget {
  const AdminTopBar({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
      color: theme.cardTheme.color,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // شريط البحث
          SizedBox(
            width: 300,
            child: TextField(
              decoration: InputDecoration(
                hintText: "Search patient by name or ID...",
                prefixIcon: const Icon(Icons.search),
                contentPadding: const EdgeInsets.symmetric(vertical: 0),
                fillColor: theme.scaffoldBackgroundColor,
              ),
            ),
          ),
          // ملف الطبيب والإشعارات
          Row(
            children: [
              IconButton(
                icon: const Badge(
                  label: Text("3"),
                  child: Icon(Icons.notifications_none),
                ),
                onPressed: () {},
              ),
              const SizedBox(width: 20),
              const CircleAvatar(
                backgroundColor: Colors.cyan,
                child: Text("Dr", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              ),
            ],
          )
        ],
      ),
    );
  }
}

// =========================================================
// 3. شريط الإحصائيات (Stats Row)
// =========================================================
class AdminStatsRow extends StatelessWidget {
  const AdminStatsRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _buildStatCard(context, "Total Patients", "42", Icons.people, Colors.blue),
        const SizedBox(width: 20),
        _buildStatCard(context, "Pending AI Reports", "7", Icons.auto_awesome, Colors.orange),
        const SizedBox(width: 20),
        _buildStatCard(context, "Today's Sessions", "15", Icons.today, Colors.green),
      ],
    );
  }

  Widget _buildStatCard(BuildContext context, String title, String value, IconData icon, Color color) {
    final theme = Theme.of(context);
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: theme.cardTheme.color,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey.withOpacity(0.1)),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(color: color.withOpacity(0.1), shape: BoxShape.circle),
              child: Icon(icon, color: color, size: 28),
            ),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: theme.textTheme.bodyMedium),
                const SizedBox(height: 4),
                Text(value, style: theme.textTheme.titleLarge?.copyWith(fontSize: 24, fontWeight: FontWeight.bold)),
              ],
            )
          ],
        ),
      ),
    );
  }
}

// =========================================================
// 4. جدول المرضى النشطين (Active Patients Table)
// =========================================================
class ActivePatientsTable extends StatelessWidget {
  const ActivePatientsTable({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: theme.cardTheme.color,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Recent Patients Activity", style: theme.textTheme.titleLarge),
              TextButton(onPressed: () {}, child: const Text("View All"))
            ],
          ),
          const SizedBox(height: 20),
          // رسم جدول بسيط (للعرض التوضيحي)
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 4,
            separatorBuilder: (context, index) => Divider(color: Colors.grey.withOpacity(0.2)),
            itemBuilder: (context, index) {
              return ListTile(
                contentPadding: EdgeInsets.zero,
                leading: CircleAvatar(backgroundColor: theme.primaryColor.withOpacity(0.2), child: const Icon(Icons.person)),
                title: const Text("Sarah Connor", style: TextStyle(fontWeight: FontWeight.bold)),
                subtitle: const Text("Last session: 2 hours ago • Left Hand"),
                trailing: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(color: Colors.green.withOpacity(0.1), borderRadius: BorderRadius.circular(20)),
                  child: const Text("Improving", style: TextStyle(color: Colors.green, fontSize: 12, fontWeight: FontWeight.bold)),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

// =========================================================
// 5. طابور تقارير الذكاء الاصطناعي (AI Reports Queue)
// =========================================================
class AIReportsQueue extends StatelessWidget {
  const AIReportsQueue({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: theme.cardTheme.color,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.orange.withOpacity(0.3)), // تمييز الصندوق بلون برتقالي خفيف
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.auto_awesome, color: Colors.orange),
              const SizedBox(width: 10),
              Text("AI Reports to Review", style: theme.textTheme.titleLarge),
            ],
          ),
          const SizedBox(height: 20),

          // بطاقة تقرير ذكاء اصطناعي بانتظار الموافقة
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: theme.scaffoldBackgroundColor,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey.withOpacity(0.2)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Patient: John Doe", style: TextStyle(fontWeight: FontWeight.bold)),
                    Text("Today, 10:30 AM", style: TextStyle(color: Colors.grey[500], fontSize: 12)),
                  ],
                ),
                const SizedBox(height: 10),
                const Text(
                  "AI Draft: Patient showed a 15% increase in grip strength compared to last week. Recommended action: Increase repetition target to 25.",
                  style: TextStyle(height: 1.5, fontSize: 13),
                ),
                const SizedBox(height: 15),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green, // لون القبول
                          padding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                        child: const Text("Approve"),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {},
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                        child: const Text("Edit"),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}