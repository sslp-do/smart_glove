import 'package:flutter/material.dart';
import 'package:smart_glove/core/theme/app_colors.dart';

import '../../../models/badge_item.dart';

class BadgesSection extends StatelessWidget {
  const BadgesSection({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: theme.cardTheme.color,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.1), blurRadius: 10)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Achievements & Badges 🏆", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              TextButton(onPressed: () {}, child: const Text("View All"))
            ],
          ),
          const SizedBox(height: 20),


          SizedBox(
            height: 110,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: demoBadges.length,
              separatorBuilder: (context, index) => const SizedBox(width: 20),
              itemBuilder: (context, index) {
                final badge = demoBadges[index];
                return Tooltip(
                  message: badge.isUnlocked ? "Unlocked: ${badge.description}" : "Locked: ${badge.description}",
                  child: Opacity(
                    opacity: badge.isUnlocked ? 1.0 : 0.5, // شفافية للأوسمة المغلقة
                    child: Container(
                      width: 90,
                      decoration: BoxDecoration(
                        color: badge.isUnlocked ? badge.color.withOpacity(0.1) : Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: badge.isUnlocked ? badge.color.withOpacity(0.3) : Colors.grey.shade300,
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              Icon(badge.icon, size: 32, color: badge.isUnlocked ? badge.color : Colors.grey),
                              if (!badge.isUnlocked)
                                const Icon(Icons.lock, size: 14, color: Colors.grey),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(
                            badge.title,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: badge.isUnlocked ? theme.textTheme.bodyMedium!.color : Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}