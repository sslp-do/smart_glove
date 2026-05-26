import 'package:flutter/material.dart';

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

    return Scaffold(
        backgroundColor: bgColor,
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
        body: Row(
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

class ReportsQueue extends StatefulWidget {
  const ReportsQueue({super.key});

  @override
  State<ReportsQueue> createState() => _ReportsQueueState();
}

class _ReportsQueueState extends State<ReportsQueue> {
  final List<Map<String, dynamic>> _aiReports = [
    {
      "id": "REP-883",
      "patientName": "Ahmad Ali",
      "session": "Full Fist Grip",
      "date": "Today, 11:00 AM",
      "confidence": 94,
      "status": "Pending Review",
      "aiSummary": "Patient achieved 85% of target flexion. However, micro-tremors were detected in the index finger during the hold phase. Overall grip strength improved by 12% compared to last week.",
      "aiRecommendation": "Increase hold duration by 2 seconds. Monitor index finger for fatigue.",
      "metrics": {"targetAngle": 90, "achievedAngle": 76, "tremorLevel": "Low"}
    },
    {
      "id": "REP-884",
      "patientName": "Sarah Connor",
      "session": "Wrist Rotation",
      "date": "Yesterday, 02:30 PM",
      "confidence": 88,
      "status": "Pending Review",
      "aiSummary": "Patient stopped exercise prematurely. Sensor data indicates an abrupt halt at 45° rotation, correlating with user-reported pain. Range of motion decreased by 10%.",
      "aiRecommendation": "Decrease target rotation angle to 40°. Add 5 minutes of ice therapy post-session.",
      "metrics": {"targetAngle": 60, "achievedAngle": 45, "tremorLevel": "None"}
    },
    {
      "id": "REP-880",
      "patientName": "John Doe",
      "session": "Finger Extension",
      "date": "Oct 24, 09:15 AM",
      "confidence": 98,
      "status": "Approved",
      "aiSummary": "Excellent execution. Patient maintained perfect form throughout all 3 sets. Sensor latency was optimal.",
      "aiRecommendation": "Progress to next difficulty level (Hard) for Finger Extension.",
      "metrics": {"targetAngle": 180, "achievedAngle": 180, "tremorLevel": "None"}
    },
  ];

  int _selectedIndex = 0;

  final bgColor = Colors.grey[50];
  final cardColor = Colors.white;
  @override
  Widget build(BuildContext context) {
    return  Expanded(
      flex: 3,
      child: Container(
        color: cardColor,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Pending Drafts", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  Chip(
                    label: const Text("2 New", style: TextStyle(color: Colors.white, fontSize: 12)),
                    backgroundColor: Colors.deepPurple,
                    padding: EdgeInsets.zero,
                  )
                ],
              ),
            ),
            const Divider(height: 1),
            Expanded(
              child: ListView.separated(
                itemCount: _aiReports.length,
                separatorBuilder: (context, index) => Divider(height: 1, color: Colors.grey[200]),
                itemBuilder: (context, index) {
                  final report = _aiReports[index];
                  final isSelected = _selectedIndex == index;
                  final isPending = report['status'] == "Pending Review";

                  return ListTile(
                    selected: isSelected,
                    selectedTileColor: Colors.deepPurple.withOpacity(0.05),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(report['patientName'], style: TextStyle(fontWeight: isSelected ? FontWeight.bold : FontWeight.normal, color: Colors.black87)),
                        Text(report['date'], style: TextStyle(fontSize: 11, color: Colors.grey[500])),
                      ],
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 6),
                        Text("Session: ${report['session']}", style: const TextStyle(fontSize: 13, color: Colors.black54)),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Icon(Icons.psychology, size: 14, color: isPending ? Colors.deepPurple : Colors.green),
                            const SizedBox(width: 4),
                            Text(
                              isPending ? "Needs Review" : "Approved",
                              style: TextStyle(color: isPending ? Colors.deepPurple : Colors.green, fontSize: 12, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ],
                    ),
                    onTap: () => setState(() => _selectedIndex = index),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ReportDetails extends StatelessWidget {
   ReportDetails({super.key});

  final List<Map<String, dynamic>> _aiReports = [
    {
      "id": "REP-883",
      "patientName": "Ahmad Ali",
      "session": "Full Fist Grip",
      "date": "Today, 11:00 AM",
      "confidence": 94,
      "status": "Pending Review",
      "aiSummary": "Patient achieved 85% of target flexion. However, micro-tremors were detected in the index finger during the hold phase. Overall grip strength improved by 12% compared to last week.",
      "aiRecommendation": "Increase hold duration by 2 seconds. Monitor index finger for fatigue.",
      "metrics": {"targetAngle": 90, "achievedAngle": 76, "tremorLevel": "Low"}
    },
    {
      "id": "REP-884",
      "patientName": "Sarah Connor",
      "session": "Wrist Rotation",
      "date": "Yesterday, 02:30 PM",
      "confidence": 88,
      "status": "Pending Review",
      "aiSummary": "Patient stopped exercise prematurely. Sensor data indicates an abrupt halt at 45° rotation, correlating with user-reported pain. Range of motion decreased by 10%.",
      "aiRecommendation": "Decrease target rotation angle to 40°. Add 5 minutes of ice therapy post-session.",
      "metrics": {"targetAngle": 60, "achievedAngle": 45, "tremorLevel": "None"}
    },
    {
      "id": "REP-880",
      "patientName": "John Doe",
      "session": "Finger Extension",
      "date": "Oct 24, 09:15 AM",
      "confidence": 98,
      "status": "Approved",
      "aiSummary": "Excellent execution. Patient maintained perfect form throughout all 3 sets. Sensor latency was optimal.",
      "aiRecommendation": "Progress to next difficulty level (Hard) for Finger Extension.",
      "metrics": {"targetAngle": 180, "achievedAngle": 180, "tremorLevel": "None"}
    },
  ];

  int _selectedIndex = 0;
   final bgColor = Colors.grey[50];
   final cardColor = Colors.white;
  @override
  Widget build(BuildContext context) {
    return   Expanded(
      flex: 7,
      child: Container(
        color: bgColor,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(40.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // --- 1. رأس التقرير ونسبة الثقة ---
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(color: Colors.grey[200], borderRadius: BorderRadius.circular(8)),
                        child: Text("Report ID: ${_aiReports[_selectedIndex]['id']}", style: TextStyle(fontSize: 12, color: Colors.grey[700])),
                      ),
                      const SizedBox(height: 12),
                      Text(_aiReports[_selectedIndex]['patientName'], style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.black87)),
                      const SizedBox(height: 4),
                      Text("Exercise: ${_aiReports[_selectedIndex]['session']} • ${_aiReports[_selectedIndex]['date']}", style: const TextStyle(fontSize: 14, color: Colors.black54)),
                    ],
                  ),
                  // بطاقة نسبة ثقة الذكاء الاصطناعي (AI Confidence)
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.deepPurple.withOpacity(0.05),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.deepPurple.withOpacity(0.2)),
                    ),
                    child: Column(
                      children: [
                        const Row(
                          children: [
                            Icon(Icons.analytics, size: 16, color: Colors.deepPurple),
                            SizedBox(width: 6),
                            Text("AI Confidence", style: TextStyle(fontSize: 12, color: Colors.deepPurple, fontWeight: FontWeight.bold)),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "${_aiReports[_selectedIndex]['confidence']}%",
                          style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.deepPurple),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 40),

              // --- 2. مقاييس الجلسة (Sensor Metrics) ---
              const Text("Glove Sensor Data", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87)),
              const SizedBox(height: 16),
              Row(
                children: [
                  _buildMetricCard("Target Angle", "${_aiReports[_selectedIndex]['metrics']['targetAngle']}°", Icons.track_changes, Colors.blue),
                  const SizedBox(width: 16),
                  _buildMetricCard("Achieved Angle", "${_aiReports[_selectedIndex]['metrics']['achievedAngle']}°", Icons.sports_score, _aiReports[_selectedIndex]['metrics']['achievedAngle'] < _aiReports[_selectedIndex]['metrics']['targetAngle'] ? Colors.orange : Colors.green),
                  const SizedBox(width: 16),
                  _buildMetricCard("Tremor Detection", _aiReports[_selectedIndex]['metrics']['tremorLevel'], Icons.vibration, _aiReports[_selectedIndex]['metrics']['tremorLevel'] == "Low" ? Colors.redAccent : Colors.green),
                ],
              ),
              const SizedBox(height: 40),

              // --- 3. ملخص الذكاء الاصطناعي (AI Summary & Draft) ---
              const Text("AI Generated Clinical Summary", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87)),
              const SizedBox(height: 16),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.grey[200]!),
                  boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 10)],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.psychology, color: Colors.deepPurple),
                        const SizedBox(width: 8),
                        Text("Draft Ready for Review", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.deepPurple[700])),
                      ],
                    ),
                    const Padding(padding: EdgeInsets.symmetric(vertical: 16), child: Divider()),
                    // مربع نص قابل للتعديل (الطبيب يمكنه تعديل كلام الـ AI)
                    TextField(
                      controller: TextEditingController(text: _aiReports[_selectedIndex]['aiSummary']),
                      maxLines: 4,
                      style: const TextStyle(fontSize: 16, height: 1.5, color: Colors.black87),
                      decoration: const InputDecoration(border: InputBorder.none),
                    ),

                    const SizedBox(height: 20),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(color: Colors.blue.withOpacity(0.05), borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.blue.withOpacity(0.1))),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(Icons.lightbulb_outline, color: Colors.blue, size: 20),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text("AI Recommendation:", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue, fontSize: 13)),
                                const SizedBox(height: 4),
                                Text(_aiReports[_selectedIndex]['aiRecommendation'], style: const TextStyle(color: Colors.black87, fontSize: 14)),
                              ],
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 40),

              // --- 4. الأزرار (Actions) ---
              if (_aiReports[_selectedIndex]['status'] == "Pending Review")
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      width: 150,
                      child: OutlinedButton.icon(
                        onPressed: () {},
                        icon: const Icon(Icons.delete_outline, color: Colors.red),
                        label: const Text("Reject & Discard", style: TextStyle(color: Colors.red)),
                        style: OutlinedButton.styleFrom(padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16), side: const BorderSide(color: Colors.red)),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Container(
                      width: 150,
                      child: ElevatedButton.icon(
                        onPressed: () {},
                        icon: const Icon(Icons.check, color: Colors.white),
                        label: const Text("Approve & Save to Record", style: TextStyle(color: Colors.white)),
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.deepPurple, padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16)),
                      ),
                    ),
                  ],
                )
              else
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Icon(Icons.check_circle, color: Colors.green),
                    const SizedBox(width: 8),
                    Text("This report has been approved and saved.", style: TextStyle(color: Colors.green[700], fontWeight: FontWeight.bold)),
                  ],
                )
            ],
          ),
        ),
      ),
    );
  }


   // دالة مساعدة لرسم بطاقات المقاييس (Sensors Data)
   Widget _buildMetricCard(String title, String value, IconData icon, Color color) {
     return Expanded(
       child: Container(
         padding: const EdgeInsets.all(20),
         decoration: BoxDecoration(
           color: Colors.white,
           borderRadius: BorderRadius.circular(16),
           border: Border.all(color: Colors.grey[200]!),
         ),
         child: Column(
           crossAxisAlignment: CrossAxisAlignment.start,
           children: [
             Row(
               children: [
                 Icon(icon, size: 18, color: Colors.grey[500]),
                 const SizedBox(width: 8),
                 Text(title, style: TextStyle(color: Colors.grey[600], fontSize: 13)),
               ],
             ),
             const SizedBox(height: 12),
             Text(value, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: color)),
           ],
         ),
       ),
     );
   }
}
