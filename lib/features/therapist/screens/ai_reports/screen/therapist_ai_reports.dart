import 'package:flutter/material.dart';
import 'package:smart_glove/features/therapist/screens/ai_reports/widgets/report_datails.dart';
import 'package:smart_glove/features/therapist/screens/ai_reports/widgets/report_queue.dart';

class TherapistAIReports extends StatefulWidget {
  const TherapistAIReports({super.key});

  @override
  State<TherapistAIReports> createState() => _TherapistAIReportsState();
}

class _TherapistAIReportsState extends State<TherapistAIReports> {
  final bgColor = Colors.grey[50];
  final cardColor = Colors.white;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(16)
        ),
      color: Colors.white),
      //   backgroundColor: bgColor,
      /*appBar: AppBar(
          title: Row(
            children: [
              IconButton(onPressed: (){Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => TherapistDashboard(),));}, icon: const Icon(Icons.arrow_back),),
              const Icon(Icons.auto_awesome, color: Colors.deepPurple),
              const SizedBox(width: 10),
              const Text("AI Moderation Queue", style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold)),
            ],
          ),
          backgroundColor: cardColor,
          elevation: 1,
          centerTitle: false,
        ),*/
      child: Row(
        children: [
          // Reports Queue
          ReportsQueue(),

          VerticalDivider(width: 1, color: Colors.grey[300]),

          // Report Details
          ReportDetails(),
        ],
      ),
    );
  }
}


