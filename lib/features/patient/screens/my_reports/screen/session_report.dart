import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:smart_glove/features/patient/models/session_report.dart'; // لتنسيق التاريخ بشكل احترافي

class SessionReportScreen extends StatelessWidget {
  final String reportId;

  const SessionReportScreen({super.key, required this.reportId});

  @override
  Widget build(BuildContext context) {
    SessionReport report = new SessionReport(
      exerciseName: "exerciseName",
      date: DateTime.now(),
      duration: Duration(minutes: 10),
      averageGripStrength: 85,
      targetAchievedCount: 15,
      forceSensorData: [],
      doctorNotes: "Great job!",
    );

    // الألوان المستوحاة مباشرة من تصميم تطبيقكِ الاحترافي
    final Color primaryColor = const Color(
      0xFF009688,
    ); // الأخضر الأساسي للتطبيق
    final Color accentColor = const Color(
      0xFFF59E0B,
    ); // البرتقالي للأزرار والتميز
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    // تنسيق المدة الزمنية والتاريخ
    String formattedDate = DateFormat(
      'EEEE, MMMM d, yyyy - hh:mm a',
    ).format(report.date);
    String formattedDuration =
        "${report.duration.inMinutes.toString().padLeft(2, '0')}:${(report.duration.inSeconds % 60).toString().padLeft(2, '0')}";

    return Scaffold(
      backgroundColor: isDark
          ? const Color(0xFF121212)
          : const Color(0xFFF8FAFC),
      appBar: AppBar(
        title: const Text(
          "Session Performance Report",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. كارت العنوان والتاريخ العلوي
            _buildHeaderCard(formattedDate, primaryColor, isDark, "name"),
            const SizedBox(height: 24),

            // 2. شبكة الإحصائيات الحيوية (Session Metrics Grid)
            GridView.count(
              crossAxisCount: 3,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 1.3,
              children: [
                _buildMetricCard(
                  "Average Strength",
                  "${report.averageGripStrength}%",
                  Icons.fitness_center_rounded,
                  primaryColor,
                  isDark,
                ),
                _buildMetricCard(
                  "Duration",
                  formattedDuration,
                  Icons.timer_outlined,
                  primaryColor,
                  isDark,
                ),
                _buildMetricCard(
                  "Repetitions",
                  "${report.targetAchievedCount} Holds",
                  Icons.check_circle_outline_rounded,
                  const Color(0xFF4CAF50),
                  isDark,
                ),
              ],
            ),
            const SizedBox(height: 24),

            // 3. كارت رسم البياني لقوة الضغط المستمرة (Force Sensor History)
            _buildChartCard(primaryColor, isDark),
            const SizedBox(height: 24),

            // 4. كارت ملاحظات الطبيب أو الـ AI (Clinical Feedback)
            _buildNotesCard(accentColor, isDark, "notes"),
            const SizedBox(height: 32),

            // 5. أزرار التحكم السفلية
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      side: BorderSide(color: primaryColor),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    icon: Icon(Icons.share_rounded, color: primaryColor),
                    label: Text(
                      "Share Report",
                      style: TextStyle(
                        color: primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onPressed: () {},
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      backgroundColor: primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    icon: const Icon(
                      Icons.refresh_rounded,
                      color: Colors.white,
                    ),
                    label: const Text(
                      "Repeat Exercise",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onPressed: () {},
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // كارت العنوان والتاريخ
  Widget _buildHeaderCard(
    String formattedDate,
    Color primaryColor,
    bool isDark,
    String exerciseName,
  ) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                exerciseName,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: primaryColor.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  "Completed",
                  style: TextStyle(
                    color: primaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Icon(
                Icons.calendar_today_rounded,
                size: 16,
                color: Colors.grey[500],
              ),
              const SizedBox(width: 8),
              Text(
                formattedDate,
                style: TextStyle(
                  color: Colors.grey[500],
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // كروت القياسات والإحصائيات دائرية الشكل المطابقة لتصميمكِ
  Widget _buildMetricCard(
    String title,
    String value,
    IconData icon,
    Color color,
    bool isDark,
  ) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: Colors.grey[500],
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Icon(icon, color: color, size: 22),
            ],
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              letterSpacing: -0.5,
            ),
          ),
        ],
      ),
    );
  }

  // كارت رسم بياني لمحاكاة مستشعرات القفاز الذكي المذكورة بالصورة الأصلية
  Widget _buildChartCard(Color primaryColor, bool isDark) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Force Sensor Continuous Data",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            "Timeline of muscle compression and hold intensity",
            style: TextStyle(color: Colors.grey[500], fontSize: 13),
          ),
          const SizedBox(height: 24),
          // 💡 نصيحة: هنا يمكنكِ دمج مكتبة (fl_chart) لرسم الـ LineChart الفعلي بناءً على report.forceSensorData
          // حالياً تم ترك مساحة مخصصة لها بتصميم مريح ومحمي ومتناسق مع شكل ويف الصورة الأصلية.
          Container(
            height: 180,
            width: double.infinity,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: primaryColor.withOpacity(0.03),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: primaryColor.withOpacity(0.1)),
            ),
            child: Icon(
              Icons.insights_rounded,
              size: 48,
              color: primaryColor.withOpacity(0.5),
            ),
          ),
        ],
      ),
    );
  }

  // كارت خاص بالملاحظات الطبية أو تعليق النظام الذكي لتشجيع المريض
  Widget _buildNotesCard(Color accentColor, bool isDark, String doctorNotes) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.assignment_turned_in_rounded,
                color: accentColor,
                size: 20,
              ),
              const SizedBox(width: 8),
              const Text(
                "Therapist Feedback & Progress Insights",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            doctorNotes,
            style: const TextStyle(
              fontSize: 14,
              height: 1.5,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
