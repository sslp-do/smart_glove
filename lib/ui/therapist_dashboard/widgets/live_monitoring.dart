// =========================================================
// 6. قسم المراقبة الحية (Live Monitoring Section)
// =========================================================
import 'package:flutter/material.dart';

class LiveMonitoringSection extends StatelessWidget {
  const LiveMonitoringSection({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      margin: const EdgeInsets.only(bottom: 30), // مسافة عن القسم الذي يليه
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        // لون خلفية مميز قليلاً (أزرق داكن جداً أو حسب الثيم) للفت الانتباه
        color: theme.brightness == Brightness.dark
            ? const Color(0xFF1A237E).withOpacity(0.3)
            : Colors.blue.shade50,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.blue.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ---- العنوان مع نقطة حمراء تومض ----
          Row(
            children: [
              // تأثير وميض (Pulsing Dot) بسيط
              TweenAnimationBuilder(
                tween: Tween<double>(begin: 0.5, end: 1.0),
                duration: const Duration(seconds: 1),
                builder: (context, value, child) {
                  return Opacity(
                    opacity: value,
                    child: Container(
                      width: 12,
                      height: 12,
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                    ),
                  );
                },
                onEnd: () {}, // في الكود الحقيقي نجعله يتكرر (Loop)
              ),
              const SizedBox(width: 10),
              Text(
                "LIVE NOW: Currently Training",
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              Text(
                "2 Patients Online",
                style: TextStyle(
                  color: theme.primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          // ---- بطاقات المرضى النشطين حالياً ----
          Row(
            children: [
              Expanded(
                child: _buildLivePatientCard(
                  context,
                  "Ahmad Ali",
                  "Fist Grip",
                  0.75,
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: _buildLivePatientCard(
                  context,
                  "Layla Omar",
                  "Finger Extension",
                  0.40,
                ),
              ),
              // مساحة فارغة لترتيب العناصر إذا كان هناك مريضان فقط
              const Expanded(child: SizedBox()),
            ],
          ),
        ],
      ),
    );
  }

  // بطاقة مصغرة للمريض الذي يتدرب الآن
  Widget _buildLivePatientCard(
      BuildContext context,
      String name,
      String exercise,
      double progress,
      ) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.cardTheme.color,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10),
        ],
      ),
      child: Row(
        children: [
          // صورة المريض مع مؤشر أخضر
          Stack(
            children: [
              CircleAvatar(
                backgroundColor: theme.primaryColor.withOpacity(0.2),
                child: const Icon(Icons.person),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    color: Colors.green,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 2),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(width: 12),

          // معلومات الجلسة
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
                Text(
                  exercise,
                  style: TextStyle(color: Colors.grey[600], fontSize: 12),
                ),
                const SizedBox(height: 8),
                // شريط تقدم حي (Mini Progress Bar)
                LinearProgressIndicator(
                  value: progress,
                  backgroundColor: Colors.grey.withOpacity(0.2),
                  color: progress > 0.5 ? Colors.green : Colors.orange,
                  minHeight: 4,
                ),
              ],
            ),
          ),

          const SizedBox(width: 12),

          // زر "المراقبة" (Spectate)
          IconButton(
            icon: const Icon(Icons.remove_red_eye, color: Colors.blue),
            tooltip: "Spectate Session",
            onPressed: () {
              // هنا يفتح الطبيب شاشة مصغرة ليرى يد المريض تتحرك في الوقت الفعلي!
            },
          ),
        ],
      ),
    );
  }
}