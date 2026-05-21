import 'package:flutter/material.dart';
import 'package:provider/provider.dart' show WatchContext;
import 'package:smart_glove/core/providers/reports_providers.dart';
import 'package:smart_glove/features/patient/models/session.dart';

class RepotsQueue extends StatelessWidget {
  RepotsQueue({super.key});

  final List<Map<String, dynamic>> myReports = [
    {
      "date": "Today, 11:30 AM",
      "exercise": "Full Fist Grip",
      "progress": "+12% Strength",
      "doctorNote":
      "Great job today, Sarah! Your grip is getting stronger. Please increase your hold time by 2 seconds next time.",
      "isNew": true,
    },
    {
      "date": "Oct 24, 02:00 PM",
      "exercise": "Wrist Rotation",
      "progress": "-10% Mobility",
      "doctorNote":
      "I noticed you stopped early due to pain. We have adjusted your target angle to 40°. Please apply ice for 15 mins today.",
      "isNew": false,
    },
    {
      "date": "Oct 20, 10:00 AM",
      "exercise": "Finger Extension",
      "progress": "Perfect Form",
      "doctorNote":
      "Excellent execution! You maintained perfect form throughout all sets. Keep it up.",
      "isNew": false,
    },
  ];
  Color primaryColor = Colors.teal;
  Color bgColor = Color(0xFFF8F9FA);

  @override
  Widget build(BuildContext context) {
    context.watch<ReportsProvider>().fetchReports("patientId");
    final reports = context.watch<ReportsProvider>();
    if (reports.reports.isEmpty)
     return const Center(

        child: Padding(
          padding: EdgeInsets.all(40),
          child: Text(
            "No reports yet.\nStart your first session!",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.grey),
          ),
        ),
      );
    else return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: reports.reports.length,
      separatorBuilder: (_, __) =>
      const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final session = reports.reports[index];
        final isNew = index == 0;
        return _ReportCard(
          session: session,
          isNew: isNew,
        );
      /*  return Container(
          margin: const EdgeInsets.only(bottom: 16),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.grey.withOpacity(0.1)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.02),
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
                  Row(
                    children: [
                      Icon(
                        Icons.fitness_center,
                        size: 16,
                        color: Colors.grey[600],
                      ),
                      const SizedBox(width: 8),
                      Text(
                        report['exercise'],
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                  if (report['isNew'])
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.redAccent.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Text(
                        "NEW",
                        style: TextStyle(
                          color: Colors.redAccent,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  else
                    Text(
                      report['date'],
                      style: TextStyle(fontSize: 12, color: Colors.grey[500]),
                    ),
                ],
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 12),
                child: Divider(height: 1),
              ),

              // نتيجة الجلسة (التقدم)
              Row(
                children: [
                  Icon(Icons.trending_up, size: 18, color: primaryColor),
                  const SizedBox(width: 8),
                  Text(
                    report['progress'],
                    style: TextStyle(
                      color: primaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),

            ],
          ),
        );*/
      },
    );
  }
}

class _ReportCard extends StatelessWidget {
  final PatientSession session;
  final bool isNew;

  static const _teal = Color(0xFF2BA18A);

  const _ReportCard({required this.session, required this.isNew});

  // لون الـ score حسب النسبة
  Color _scoreColor(int score) {
    if (score >= 80) return Colors.green;
    if (score >= 50) return Colors.orange;
    return Colors.red;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Exercise name + NEW badge + date
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(Icons.fitness_center,
                      color: _teal, size: 18),
                  const SizedBox(width: 8),
                  Text(
                    session.exerciseId,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
              if (isNew)
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: _teal,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    "NEW",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              else
                Text(
                  "${session.sessionDate.day}/${session.sessionDate.month}  "
                      "${session.sessionDate.hour}:${session.sessionDate.minute.toString().padLeft(2, '0')}",
                  style: const TextStyle(
                      color: Colors.grey, fontSize: 12),
                ),
            ],
          ),
          const SizedBox(height: 12),

          // Score + Duration
          Row(
            children: [
              _InfoChip(
                icon: Icons.star,
                label: "Score: ${session.score}%",
                color: _scoreColor(session.score),
              ),
              const SizedBox(width: 10),
              _InfoChip(
                icon: Icons.timer,
                label:
                "${session.duration.inMinutes} min",
                color: Colors.blueGrey,
              ),
            ],
          ),
          const SizedBox(height: 12),

          // AI Analysis
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(Icons.trending_up,
                  color: _teal, size: 16),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  session.aiAnalysis,
                  style: const TextStyle(
                    color: _teal,
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _InfoChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;

  const _InfoChip({
    required this.icon,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Icon(icon, color: color, size: 13),
          const SizedBox(width: 4),
          Text(label,
              style: TextStyle(
                  color: color,
                  fontSize: 12,
                  fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}
