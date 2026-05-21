import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_glove/features/patient/providers/patient_provider.dart';

class ResultScreen extends StatelessWidget {
  final int score;
  final String duration;
  final String exerciseName;
  final String aiAnalysis;

  static const _teal = Color(0xFF2BA18A);

  const ResultScreen({
    super.key,
    required this.score,
    required this.duration,
    required this.exerciseName,
    required this.aiAnalysis,
  });

  Color get _scoreColor {
    if (score >= 80) return Colors.green;
    if (score >= 50) return Colors.orange;
    return Colors.red;
  }

  String get _scoreLabel {
    if (score >= 80) return "Excellent! 🎉";
    if (score >= 50) return "Good Job! 💪";
    return "Keep Going! 🔥";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7F9),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              // ── Score Circle ─────────────────────────────────────────
              const SizedBox(height: 20),
              Text(
                _scoreLabel,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                exerciseName,
                style: const TextStyle(
                    color: Colors.grey, fontSize: 15),
              ),
              const SizedBox(height: 32),

              SizedBox(
                width: 160,
                height: 160,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    CircularProgressIndicator(
                      value: score / 100,
                      strokeWidth: 12,
                      backgroundColor:
                      _scoreColor.withOpacity(0.15),
                      valueColor:
                      AlwaysStoppedAnimation(_scoreColor),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "$score%",
                          style: TextStyle(
                            fontSize: 36,
                            fontWeight: FontWeight.bold,
                            color: _scoreColor,
                          ),
                        ),
                        const Text("Score",
                            style: TextStyle(
                                color: Colors.grey,
                                fontSize: 13)),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),

              // ── Stats Row ─────────────────────────────────────────────
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _StatCard(
                      icon: Icons.timer,
                      label: "Duration",
                      value: duration),
                  const SizedBox(width: 16),
                  _StatCard(
                      icon: Icons.fitness_center,
                      label: "Exercise",
                      value: exerciseName),
                ],
              ),
              const SizedBox(height: 28),

              // ── AI Analysis Card ──────────────────────────────────────
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                    )
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.auto_awesome,
                            color: _teal, size: 20),
                        const SizedBox(width: 8),
                        const Text(
                          "AI Analysis",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text(
                      aiAnalysis,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.black87,
                        height: 1.6,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),

              // ── Buttons ───────────────────────────────────────────────
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // حدّث إحصائيات المريض
                    context
                        .read<PatientProvider>()
                        .updateStatsAfterSession(score);

                    // ارجع للـ Dashboard
                    Navigator.popUntil(
                        context, (route) => route.isFirst);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _teal,
                    foregroundColor: Colors.white,
                    padding:
                    const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    "Back to Dashboard",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: OutlinedButton.styleFrom(
                    foregroundColor: _teal,
                    side: const BorderSide(color: _teal),
                    padding:
                    const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    "View My Reports",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  static const _teal = Color(0xFF2BA18A);

  const _StatCard({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
          horizontal: 20, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
          )
        ],
      ),
      child: Column(
        children: [
          Icon(icon, color: _teal, size: 22),
          const SizedBox(height: 6),
          Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
          Text(label,
              style: const TextStyle(
                  color: Colors.grey, fontSize: 12)),
        ],
      ),
    );
  }
}

