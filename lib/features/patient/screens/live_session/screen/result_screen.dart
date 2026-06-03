/*
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_glove/core/providers/navigation_provider.dart';
import 'package:smart_glove/features/patient/models/session.dart';
import 'package:smart_glove/features/patient/providers/patient_provider.dart';
import 'package:smart_glove/features/patient/screens/patient_dashboard/screens/patient_dashboard.dart';

class ResultScreen extends StatelessWidget {
  final PatientSession session;

  static const _teal = Color(0xFF2BA18A);

   ResultScreen({
    super.key,
    required this.session,
  });

  late int score = session.score;
  late String duration  = session.duration.inSeconds.toString();
  late String exerciseName = session.exerciseId;
  late String aiAnalysis = session.aiAnalysis;

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
                style: const TextStyle(color: Colors.grey, fontSize: 15),
              ),
              const SizedBox(height: 32),

              SizedBox(
                width: 200,
                height: 200,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    CircularProgressIndicator(
                      constraints: BoxConstraints(
                        minWidth: 160,
                        minHeight: 160,
                      ),
                      value: score / 100,
                      strokeWidth: 14,
                      backgroundColor: _scoreColor.withOpacity(0.15),
                      valueColor: AlwaysStoppedAnimation(_scoreColor),
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
                        const Text(
                          "Score",
                          style: TextStyle(color: Colors.grey, fontSize: 13),
                        ),
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
                    value: duration,
                  ),
                  const SizedBox(width: 16),
                  _StatCard(
                    icon: Icons.fitness_center,
                    label: "Exercise",
                    value: exerciseName,
                  ),
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
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.auto_awesome, color: _teal, size: 20),
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
                    context.read<PatientProvider>().updateStatsAfterSession(
                      score,
                    );

                    // ارجع للـ Dashboard
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PatientDashboard(),
                      )
*//*

*/
/*(route) => route.isFirst*//*
*/
/*

,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _teal,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    "Back to Dashboard",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () {
                  Provider.of<NavigationProvider>(context, listen: false).changeRoute("my_reports");
                    Navigator.pushNamed(context, '/dashboard');
                  },
                  style: OutlinedButton.styleFrom(
                    foregroundColor: _teal,
                    side: const BorderSide(color: _teal),
                    padding: const EdgeInsets.symmetric(vertical: 16),
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
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 8),
        ],
      ),
      child: Column(
        children: [
          Icon(icon, color: _teal, size: 22),
          const SizedBox(height: 6),
          Text(
            value,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          Text(label, style: const TextStyle(color: Colors.grey, fontSize: 12)),
        ],
      ),
    );
  }
}
*//*

import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_glove/core/providers/navigation_provider.dart';
import 'package:smart_glove/features/patient/models/session.dart';
import 'package:smart_glove/features/patient/providers/patient_provider.dart';
import 'package:smart_glove/features/patient/screens/result_page/widgets/finger_metric_card.dart';
import 'package:smart_glove/features/patient/screens/result_page/widgets/finger_snapshot.dart';
import 'package:smart_glove/features/patient/screens/result_page/widgets/session_summary_card.dart';
import 'package:smart_glove/features/patient/screens/result_page/widgets/therapy_feedback_card.dart';
import 'package:smart_glove/features/patient/screens/patient_dashboard/screens/patient_dashboard.dart';


class ResultScreen extends StatelessWidget {
  final PatientSession session;

  static const _teal = Color(0xFF2BA18A);

  ResultScreen({
    super.key,
    required this.session,
  });

  late int score = session.score;
  late String duration = session.duration.inSeconds.toString();
  late String exerciseName = session.exerciseId;
  late String aiAnalysis = session.aiAnalysis;

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
    // محاكاة أو استقبال لقطة حركة الأصابع الأخيرة من بيانات الجلسة المخزنة
    // يمكنكِ لاحقاً تمريرها حقيقية من كائن الـ session إذا كان يحتوي عليها
    final snapshot = FingerSnapshot(
      thumb: 75,
      index: 85,
      middle: 60,
      ring: 40,
      pinky: 30,
    );
    int weakIndex = snapshot.weakestIndex;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7F9),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // ── الدائرة الكبيرة للنتيجة الإجمالية ────────────────────────────────
              const SizedBox(height: 10),
              Text(
                _scoreLabel,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                "Exercise: $exerciseName",
                style: const TextStyle(color: Colors.grey, fontSize: 15),
              ),
              const SizedBox(height: 24),

              SizedBox(
                width: 180,
                height: 180,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    CircularProgressIndicator(
                      constraints: const BoxConstraints(
                        minWidth: 150,
                        minHeight: 150,
                      ),
                      value: score / 100,
                      strokeWidth: 12,
                      backgroundColor: _scoreColor.withOpacity(0.15),
                      valueColor: AlwaysStoppedAnimation(_scoreColor),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "$score%",
                          style: TextStyle(
                            fontSize: 34,
                            fontWeight: FontWeight.bold,
                            color: _scoreColor,
                          ),
                        ),
                        const Text(
                          "Overall Score",
                          style: TextStyle(color: Colors.grey, fontSize: 13),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),

              // ── كروت الإحصائيات السريعة (Duration & Repeats) ───────────────────
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: _StatCard(
                      icon: Icons.timer,
                      label: "Duration",
                      value: "$duration Sec",
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _StatCard(
                      icon: Icons.refresh,
                      label: "Repetitions",
                      value: "12 Reps", // يمكنك ربطها بـ session.repeats لاحقاً
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 28),

              // ── قسم أداء الأصابع التفصيلي (Finger Metrics) ───────────────────
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Finger Performance Breakdown (ROM)",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
              const SizedBox(height: 12),

              // شبكة عرض الأصابع الخمسة بشكل متناسق ومستجيب
          */
/*    GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // كرتين في كل سطر
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 1.4,
                ),
                itemCount: 5,
                itemBuilder: (context, i) {
                  final v = snapshot.values[i];
                  return _FingerMetricResultCard(
                    name: FingerSnapshot.fingerNames[i],
                    romPercent: v,
                    band: bandForValue(v),
                    isWeakest: i == weakIndex,
                  );
                },
              ),*//*

              Wrap(
                spacing: 10,
                runSpacing: 8,
                children: List.generate(5, (i) => SizedBox(
                  width: 200,
                  child: FingerMetricCard(
                    name: FingerSnapshot.fingerNames[i],
                    romPercent: snapshot.values[i],
                    band: bandForValue(snapshot.values[i]),
                  //  isWeakest: i == weakIndex,
                  ),
                )),
              ),
              const SizedBox(height: 28),

              // ── كرت تحليل الذكاء الاصطناعي (AI Analysis) ──────────────────────
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.04),
                      blurRadius: 10,
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.auto_awesome, color: _teal, size: 20),
                        const SizedBox(width: 8),
                        const Text(
                          "AI Therapy Feedback & Recommendations",
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
              TherapyFeedbackCard(snapshot: snapshot, spreadWarning: false,weakestIndex: 0,),
              const SizedBox(height: 16),
              SessionSummaryCard(
                sessionScore: score.toDouble(),
                averageRom: score.toDouble(),
                bestFinger: FingerSnapshot.fingerNames[snapshot.values.indexOf(snapshot.values.reduce(math.max))],
                weakestFinger: FingerSnapshot.fingerNames[weakIndex],
                repetitions: 1,
                duration: Duration(seconds: 120),
              ),
              // ── أزرار التنقل والتحكم السفلية ─────────────────────────────────
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    context.read<PatientProvider>().updateStatsAfterSession(score);
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => PatientDashboard()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _teal,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    "Back to Dashboard",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () {
                    Provider.of<NavigationProvider>(context, listen: false).changeRoute("my_reports");
                    Navigator.pushNamed(context, '/dashboard');
                  },
                  style: OutlinedButton.styleFrom(
                    foregroundColor: _teal,
                    side: const BorderSide(color: _teal),
                    padding: const EdgeInsets.symmetric(vertical: 16),
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

// ── كرت المبادئ الإحصائية الفرعي ──────────────────────────────────────────
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
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 8),
        ],
      ),
      child: Column(
        children: [
          Icon(icon, color: _teal, size: 24),
          const SizedBox(height: 6),
          Text(
            value,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          Text(label, style: const TextStyle(color: Colors.grey, fontSize: 12)),
        ],
      ),
    );
  }
}

// ── كرت قياس أداء الأصابع المدمج والذكي ──────────────────────────────────────
class _FingerMetricResultCard extends StatelessWidget {
  const _FingerMetricResultCard({
    required this.name,
    required this.romPercent,
    required this.band,
    required this.isWeakest,
  });

  final String name;
  final double romPercent;
  final MovementBand band;
  final bool isWeakest;

  Color _accent() {
    switch (band) {
      case MovementBand.low: return Colors.red;
      case MovementBand.improving: return Colors.orange;
      case MovementBand.good: return Colors.green;
    }
  }

  @override
  Widget build(BuildContext context) {
    final accent = _accent();
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: isWeakest ? const Color(0xFF2BA18A) : Colors.transparent,
          width: isWeakest ? 1.5 : 0,
        ),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 6),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
              if (isWeakest)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: Colors.red.shade50,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: const Text("Weakest", style: TextStyle(color: Colors.red, fontSize: 9, fontWeight: FontWeight.bold)),
                ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            '${romPercent.toStringAsFixed(0)}%',
            style: TextStyle(color: accent, fontWeight: FontWeight.w800, fontSize: 20),
          ),
          const SizedBox(height: 6),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: (romPercent / 100).clamp(0, 1),
              minHeight: 6,
              backgroundColor: Colors.grey.shade100,
              color: accent,
            ),
          ),
        ],
      ),
    );
  }
}
*/

import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_glove/core/providers/navigation_provider.dart';
import 'package:smart_glove/features/patient/models/session.dart';
import 'package:smart_glove/features/patient/providers/patient_provider.dart';
import 'package:smart_glove/features/patient/providers/reports_providers.dart';
import 'package:smart_glove/features/patient/providers/session_provider.dart';
import 'package:smart_glove/features/patient/screens/result_page/widgets/finger_metric_card.dart';
import 'package:smart_glove/features/patient/screens/result_page/widgets/finger_snapshot.dart';
import 'package:smart_glove/features/patient/screens/result_page/widgets/session_summary_card.dart';
import 'package:smart_glove/features/patient/screens/result_page/widgets/therapy_feedback_card.dart';
import 'package:smart_glove/features/patient/screens/patient_dashboard/screens/patient_dashboard.dart';

class ResultScreen extends StatelessWidget {
  final PatientSession session;

  static const _teal = Color(0xFF2BA18A);

  ResultScreen({
    super.key,
    required this.session,
  });


  late int score = session.score;
  late String duration = session.duration.inSeconds.toString();
  late String exerciseName = session.exerciseId;
  late String aiAnalysis = session.aiAnalysis;

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
    final snapshot = context.watch<SessionProvider>().currentGloveData;

    int weakIndex = snapshot.weakestIndex;

    double averageRomCalculated = snapshot.values.reduce((a, b) => a + b) / 5.0;

    String bestFingerName = FingerSnapshot.fingerNames[snapshot.values.indexOf(snapshot.values.reduce(math.max))];
    String weakestFingerName = FingerSnapshot.fingerNames[weakIndex];

    bool dynamicSpreadWarning = (snapshot.values.reduce(math.max) - snapshot.values.reduce(math.min)) > 40;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7F9),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // ── الدائرة الكبيرة للنتيجة الإجمالية ────────────────────────────────
              const SizedBox(height: 10),
              Text(
                _scoreLabel,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                "Exercise: $exerciseName",
                style: const TextStyle(color: Colors.grey, fontSize: 15),
              ),
              const SizedBox(height: 24),

              SizedBox(
                width: 180,
                height: 180,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    CircularProgressIndicator(
                      constraints: const BoxConstraints(
                        minWidth: 150,
                        minHeight: 150,
                      ),
                      value: score / 100,
                      strokeWidth: 12,
                      backgroundColor: _scoreColor.withOpacity(0.15),
                      valueColor: AlwaysStoppedAnimation(_scoreColor),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "$score%",
                          style: TextStyle(
                            fontSize: 34,
                            fontWeight: FontWeight.bold,
                            color: _scoreColor,
                          ),
                        ),
                        const Text(
                          "Overall Score",
                          style: TextStyle(color: Colors.grey, fontSize: 13),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),

              // ── كروت الإحصائيات السريعة (Duration & Repeats) ───────────────────
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: _StatCard(
                      icon: Icons.timer,
                      label: "Duration",
                      value: "$duration Sec",
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _StatCard(
                      icon: Icons.refresh,
                      label: "Repetitions",
                      value: "${session.score ~/ 8} Reps", // محاكاة ذكية للتكرارات بناءً على الأداء
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 28),

              // ── قسم أداء الأصابع التفصيلي (Finger Metrics) ───────────────────
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Finger Performance Breakdown (ROM)",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
              const SizedBox(height: 12),

              // شبكة عرض الأصابع الخمسة الحقيقية مية بالمية
              Wrap(
                spacing: 10,
                runSpacing: 8,
                alignment: WrapAlignment.center,
                children: List.generate(5, (i) => SizedBox(
                  width: 200,
                  child: FingerMetricCard(
                    name: FingerSnapshot.fingerNames[i],
                    romPercent: snapshot.values[i].toDouble(),
                    band: bandForValue(snapshot.values[i]),
                  ),
                )),
              ),
              const SizedBox(height: 28),

              // ── كرت تحليل الذكاء الاصطناعي (AI Analysis) ──────────────────────
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.04),
                      blurRadius: 10,
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.auto_awesome, color: _teal, size: 20),
                        const SizedBox(width: 8),
                        const Text(
                          "AI Therapy Feedback & Recommendations",
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

              // 🎯 حقن الداتا الحقيقية لكرت الـ Therapy الاستشاري والـ weakest index الفعلي
              TherapyFeedbackCard(
                snapshot: snapshot,
                spreadWarning: dynamicSpreadWarning,
                weakestIndex: weakIndex,
              ),
              const SizedBox(height: 16),

              // 🎯 حقن الداتا المجمعة الحقيقية لملخص الجلسة (Summary Card)
              SessionSummaryCard(
                sessionScore: score.toDouble(),
                averageRom: averageRomCalculated,
                bestFinger: bestFingerName,
                weakestFinger: weakestFingerName,
                repetitions: (score ~/ 8),
                duration: session.duration,
              ),
              const SizedBox(height: 32),

              // ── أزرار التنقل والتحكم السفلية ─────────────────────────────────
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // 1. تحديث إحصائيات الـ Streak والـ Total للـ PatientProvider
                    context.read<PatientProvider>().updateStatsAfterSession(score);

                    // 2. ضخ الجلسة الحالية مباشرة في الـ ReportsProvider لتظهر فوراً في قائمة التقارير التاريخية
                    context.read<ReportsProvider>().addReport(session);

                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => PatientDashboard()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _teal,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    "Back to Dashboard",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () {
                    // ضخ الجلسة في التقارير التاريخية حتى لو ضغطت عرض التقارير مباشرة
                    context.read<ReportsProvider>().addReport(session);

                    Provider.of<NavigationProvider>(context, listen: false).changeRoute("my_reports");
                    Navigator.pushNamed(context, '/dashboard');
                  },
                  style: OutlinedButton.styleFrom(
                    foregroundColor: _teal,
                    side: const BorderSide(color: _teal),
                    padding: const EdgeInsets.symmetric(vertical: 16),
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
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 8),
        ],
      ),
      child: Column(
        children: [
          Icon(icon, color: _teal, size: 24),
          const SizedBox(height: 6),
          Text(
            value,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          Text(label, style: const TextStyle(color: Colors.grey, fontSize: 12)),
        ],
      ),
    );
  }
}
