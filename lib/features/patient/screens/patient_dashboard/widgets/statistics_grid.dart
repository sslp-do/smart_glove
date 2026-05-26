import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_glove/features/patient/providers/patient_provider.dart';

class StatsGrid extends StatelessWidget {
  const StatsGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final patientProvider = Provider.of<PatientProvider>(context);
    final patient = patientProvider.currentPatient;
    return Row(
      children: [
        _buildStatCard("Current Streak 🔥", "${patient?.streak ?? 0} Days", Colors.orange, context),
        const SizedBox(width: 20),
        _buildStatCard("Total Sessions ✅", "${patient?.totalSessions ?? 0} Sessions", Colors.blue, context),
        const SizedBox(width: 20),
        _buildStatCard("Improvement 📈", "+${patient?.recoveryProgress ?? 0}%", Colors.purple, context),
      ],
    );
  }

  Widget _buildStatCard(
    String title,
    String value,
    Color color,
    BuildContext context,
  ) {
    final theme = Theme.of(context);

    return Expanded(
      child: Card(
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: theme.cardTheme.color,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: theme.colorScheme.secondary.withOpacity(0.1),
                blurRadius: 10,
              ),
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
              Text(value, style: theme.textTheme.titleLarge),
            ],
          ),
        ),
      ),
    );
  }
}
