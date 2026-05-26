/*import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_glove/core/providers/reports_providers.dart';
import 'package:smart_glove/features/patient/models/session.dart';
import 'package:smart_glove/features/patient/providers/patient_provider.dart';
import 'package:smart_glove/features/patient/providers/glove_provider.dart';

class MyReportsScreen extends StatefulWidget {
  const MyReportsScreen({super.key});

  @override
  State<MyReportsScreen> createState() => _MyReportsScreenState();
}

class _MyReportsScreenState extends State<MyReportsScreen> {
  static const _teal = Color(0xFF2BA18A);

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<ReportsProvider>().fetchReports("patient_123");
    });
  }

  @override
  Widget build(BuildContext context) {
    final reports = context.watch<ReportsProvider>();
    final patient = context.watch<PatientProvider>().currentPatient;
    final glove = context.watch<GloveProvider>().status;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7F9),
      body: reports.isLoading
          ? const Center(child: CircularProgressIndicator(color: _teal))
          : reports.error != null
          ? Center(child: Text(reports.error!))
          : SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // ── Header ──────────────────────────────────────────
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Good Morning, ${patient?.name.split(' ').first ?? 'Sarah'} 👋",
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      "Ready to make some progress today?",
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
                // Glove Status Chip
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.06),
                        blurRadius: 8,
                      )
                    ],
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.bluetooth,
                          color: glove.isConnected
                              ? _teal
                              : Colors.grey,
                          size: 16),
                      const SizedBox(width: 6),
                      Text(
                        glove.isConnected
                            ? "Glove Connected"
                            : "Glove Disconnected",
                        style: TextStyle(
                          color: glove.isConnected
                              ? _teal
                              : Colors.grey,
                          fontWeight: FontWeight.w600,
                          fontSize: 13,
                        ),
                      ),
                      if (glove.isConnected) ...[
                        const SizedBox(width: 6),
                        Text(
                          "${glove.battery}%",
                          style: const TextStyle(
                            color: _teal,
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                          ),
                        ),
                      ]
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // ── Summary Card ────────────────────────────────────
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: _teal,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Recovery Journey",
                    style: TextStyle(
                        color: Colors.white70, fontSize: 13),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    "You're doing great, ${patient?.name.split(' ').first ?? 'Sarah'}!",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,
                    children: [
                      _Summarystat(
                        value:
                        "${patient?.totalSessions ?? 0}",
                        label: "Sessions",
                      ),
                      _Summarystat(
                        value: "${patient?.streak ?? 0} Days",
                        label: "Streak",
                        highlight: true,
                      ),
                      _Summarystat(
                        value:
                        "${patient?.improvement.toInt() ?? 0}%",
                        label: "Avg. Score",
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 28),

            // ── Reports History ─────────────────────────────────
            const Text(
              "Reports History",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),

            if (reports.reports.isEmpty)
              const Center(
                child: Padding(
                  padding: EdgeInsets.all(40),
                  child: Text(
                    "No reports yet.\nStart your first session!",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
              )
            else
              ListView.separated(
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
                },
              ),
          ],
        ),
      ),
    );
  }
}*/

// ── Widgets المساعدة ────────────────────────────────────────────────────────
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_glove/features/patient/providers/patient_provider.dart';
import 'package:smart_glove/features/patient/screens/my_reports/widgets/hero_card.dart';
import 'package:smart_glove/features/patient/screens/my_reports/widgets/reports_queue.dart';
import 'package:smart_glove/features/patient/screens/patient_dashboard/widgets/header_section.dart';

class PatientReportsScreen extends StatelessWidget {


  const PatientReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
  final patientProvider = Provider.of<PatientProvider>(context);
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          HeaderSection(),

          const SizedBox(height: 20),

          //  1. Hero Card
          HeroCard(patient: patientProvider.currentPatient,),
          const SizedBox(height: 30),

          //   2. title
          const Text(
            "Reports History",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 16),

          //  3. reports queue
          RepotsQueue(),
        ],
      ),
    );
  }
}

