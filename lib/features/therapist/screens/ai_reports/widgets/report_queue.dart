import 'package:flutter/material.dart';

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
      "aiSummary":
      "Patient achieved 85% of target flexion. However, micro-tremors were detected in the index finger during the hold phase. Overall grip strength improved by 12% compared to last week.",
      "aiRecommendation":
      "Increase hold duration by 2 seconds. Monitor index finger for fatigue.",
      "metrics": {"targetAngle": 90, "achievedAngle": 76, "tremorLevel": "Low"},
    },
    {
      "id": "REP-884",
      "patientName": "Sarah Connor",
      "session": "Wrist Rotation",
      "date": "Yesterday, 02:30 PM",
      "confidence": 88,
      "status": "Pending Review",
      "aiSummary":
      "Patient stopped exercise prematurely. Sensor data indicates an abrupt halt at 45° rotation, correlating with user-reported pain. Range of motion decreased by 10%.",
      "aiRecommendation":
      "Decrease target rotation angle to 40°. Add 5 minutes of ice therapy post-session.",
      "metrics": {
        "targetAngle": 60,
        "achievedAngle": 45,
        "tremorLevel": "None",
      },
    },
    {
      "id": "REP-880",
      "patientName": "John Doe",
      "session": "Finger Extension",
      "date": "Oct 24, 09:15 AM",
      "confidence": 98,
      "status": "Approved",
      "aiSummary":
      "Excellent execution. Patient maintained perfect form throughout all 3 sets. Sensor latency was optimal.",
      "aiRecommendation":
      "Progress to next difficulty level (Hard) for Finger Extension.",
      "metrics": {
        "targetAngle": 180,
        "achievedAngle": 180,
        "tremorLevel": "None",
      },
    },
  ];

  int _selectedIndex = 0;

  final bgColor = Colors.grey[50];
  final cardColor = Colors.white;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 3,
      child: Container(
        //  color: cardColor,
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16),
            bottomLeft: Radius.circular(16),
          ),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 10,
                offset: Offset.fromDirection(23),
                spreadRadius: 3
            ),
          ],
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Pending Drafts",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  Chip(
                    label: const Text(
                      "2 New",
                      style: TextStyle(color: Colors.white, fontSize: 12),
                    ),
                    backgroundColor: Colors.deepPurple,
                    padding: EdgeInsets.zero,
                  ),
                ],
              ),
            ),
            const Divider(height: 1),
            Expanded(
              child: ListView.separated(
                itemCount: _aiReports.length,
                separatorBuilder: (context, index) =>
                    Divider(height: 1, color: Colors.grey[200]),
                itemBuilder: (context, index) {
                  final report = _aiReports[index];
                  final isSelected = _selectedIndex == index;
                  final isPending = report['status'] == "Pending Review";

                  return ListTile(
                    selected: isSelected,
                    selectedTileColor: Colors.deepPurple.withOpacity(0.05),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 16,
                    ),
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          report['patientName'],
                          style: TextStyle(
                            fontWeight: isSelected
                                ? FontWeight.bold
                                : FontWeight.normal,
                            color: Colors.black87,
                          ),
                        ),
                        Text(
                          report['date'],
                          style: TextStyle(
                            fontSize: 11,
                            color: Colors.grey[500],
                          ),
                        ),
                      ],
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 6),
                        Text(
                          "Session: ${report['session']}",
                          style: const TextStyle(
                            fontSize: 13,
                            color: Colors.black54,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Icon(
                              Icons.psychology,
                              size: 14,
                              color: isPending
                                  ? Colors.deepPurple
                                  : Colors.green,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              isPending ? "Needs Review" : "Approved",
                              style: TextStyle(
                                color: isPending
                                    ? Colors.deepPurple
                                    : Colors.green,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
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
