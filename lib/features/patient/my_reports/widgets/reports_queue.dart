

import 'package:flutter/material.dart';

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
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: myReports.length,
      itemBuilder: (context, index) {
        final report = myReports[index];
        return Container(
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
              // رأس البطاقة (التاريخ والتمرين)
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
              const SizedBox(height: 12),

              // رسالة الطبيب (Doctor's Note)
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.blueGrey.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(12),
                  border: Border(
                    left: BorderSide(color: primaryColor, width: 4),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 10,
                          backgroundColor: primaryColor,
                          child: Icon(
                            Icons.person,
                            size: 12,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          "Dr. Notes",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[700],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "\"${report['doctorNote']}\"",
                      style: const TextStyle(
                        height: 1.5,
                        fontSize: 14,
                        color: Colors.black87,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}