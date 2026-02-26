// =========================================================
// 5. طابور تقارير الذكاء الاصطناعي (AI Reports Queue)
// =========================================================
import 'package:flutter/material.dart';

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
        border: Border.all(
          color: Colors.orange.withOpacity(0.3),
        ), // تمييز الصندوق بلون برتقالي خفيف
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
                    const Text(
                      "Patient: John Doe",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    //  Text("Today, 10:30 AM", style: TextStyle(color: Colors.grey[500], fontSize: 12)),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 4,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.green.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: Colors.green.withOpacity(0.3),
                        ),
                      ),
                      child: const Row(
                        children: [
                          Icon(Icons.psychology, size: 10, color: Colors.green),
                          SizedBox(width: 4),
                          Text(
                            "AI Confidence: 92%",
                            style: TextStyle(
                              color: Colors.green,
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
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
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}