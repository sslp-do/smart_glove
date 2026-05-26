// =========================================================
// 3. شريط الإحصائيات (Stats Row)
// =========================================================
import 'package:flutter/material.dart';

class StatCards extends StatelessWidget {
  const StatCards({super.key});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      direction: Axis.horizontal,
      spacing: 15.0,
      alignment: WrapAlignment.center,
      children: [
        _buildStatCard(
          context,
          "Total Patients",
          "42",
          Icons.people,
          Colors.blue,
        ),
      //  const SizedBox(width: 20),
        _buildStatCard(
          context,
          "Pending Reports",
          "7",
          Icons.auto_awesome,
          Colors.orange,
        ),
      //  const SizedBox(width: 20),
        _buildStatCard(
          context,
          "Today's Sessions",
          "15",
          Icons.today,
          Colors.green,
        ),
      ],
    );
  }

  Widget _buildStatCard(
      BuildContext context,
      String title,
      String value,
      IconData icon,
      Color color,
      ) {
    final theme = Theme.of(context);
    return Container(
      width: (MediaQuery.of(context).size.width)*0.24 ,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        boxShadow: [BoxShadow(
          color: color.withOpacity(0.3),
          blurRadius: 10,
          offset: const Offset(0, 5),
        )],
        color: theme.cardTheme.color,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.withOpacity(0.1)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 28),
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: theme.textTheme.bodyMedium),
              const SizedBox(height: 4),
              Text(
                softWrap: true,
                value,
                style: theme.textTheme.titleLarge?.copyWith(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}