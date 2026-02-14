import 'package:flutter/material.dart';

class StatsGrid extends StatelessWidget {
  const StatsGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
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
