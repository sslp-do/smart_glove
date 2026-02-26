import 'package:flutter/material.dart';

class PatientReportsScreen extends StatelessWidget {
  const PatientReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // ألوان التطبيق الأساسية (يمكنك ربطها بالـ Theme الخاص بك)
    const Color primaryColor = Colors.teal;
    const Color bgColor = Color(0xFFF8F9FA); // رمادي فاتح جداً ومريح للعين

    // بيانات تجريبية لتقارير المريض
    final List<Map<String, dynamic>> myReports = [
      {
        "date": "Today, 11:30 AM",
        "exercise": "Full Fist Grip",
        "progress": "+12% Strength",
        "doctorNote": "Great job today, Sarah! Your grip is getting stronger. Please increase your hold time by 2 seconds next time.",
        "isNew": true,
      },
      {
        "date": "Oct 24, 02:00 PM",
        "exercise": "Wrist Rotation",
        "progress": "-10% Mobility",
        "doctorNote": "I noticed you stopped early due to pain. We have adjusted your target angle to 40°. Please apply ice for 15 mins today.",
        "isNew": false,
      },
      {
        "date": "Oct 20, 10:00 AM",
        "exercise": "Finger Extension",
        "progress": "Perfect Form",
        "doctorNote": "Excellent execution! You maintained perfect form throughout all sets. Keep it up.",
        "isNew": false,
      },
    ];

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "My Progress & Reports",
          style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.help_outline, color: primaryColor),
            onPressed: () {},
          )
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ==========================================
              // 1. بطاقة التحفيز والتقدم العام (Hero Card)
              // ==========================================
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [primaryColor, Color(0xFF00796B)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(color: primaryColor.withOpacity(0.3), blurRadius: 15, offset: const Offset(0, 8)),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Recovery Journey", style: TextStyle(color: Colors.white70, fontSize: 14)),
                    const SizedBox(height: 8),
                    const Text("You're doing great, Sarah!", style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildStatItem("Sessions", "24", Colors.white),
                        _buildStatItem("Streak", "5 Days", Colors.orangeAccent),
                        _buildStatItem("Avg. Score", "85%", Colors.greenAccent),
                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(height: 30),

              // ==========================================
              // 2. عنوان التقارير
              // ==========================================
              const Text(
                "Doctor's Feedback",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black87),
              ),
              const SizedBox(height: 16),

              // ==========================================
              // 3. قائمة التقارير (ListView)
              // ==========================================
              ListView.builder(
                shrinkWrap: true, // ضروري داخل الـ SingleChildScrollView
                physics: const NeverScrollableScrollPhysics(), // لمنع تعارض التمرير
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
                        BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 10, offset: const Offset(0, 4)),
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
                                Icon(Icons.fitness_center, size: 16, color: Colors.grey[600]),
                                const SizedBox(width: 8),
                                Text(report['exercise'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.black87)),
                              ],
                            ),
                            if (report['isNew'])
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(color: Colors.redAccent.withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
                                child: const Text("NEW", style: TextStyle(color: Colors.redAccent, fontSize: 10, fontWeight: FontWeight.bold)),
                              )
                            else
                              Text(report['date'], style: TextStyle(fontSize: 12, color: Colors.grey[500])),
                          ],
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 12),
                          child: Divider(height: 1),
                        ),

                        // نتيجة الجلسة (التقدم)
                        Row(
                          children: [
                            const Icon(Icons.trending_up, size: 18, color: primaryColor),
                            const SizedBox(width: 8),
                            Text(report['progress'], style: const TextStyle(color: primaryColor, fontWeight: FontWeight.bold, fontSize: 14)),
                          ],
                        ),
                        const SizedBox(height: 12),

                        // رسالة الطبيب (Doctor's Note)
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.blueGrey.withOpacity(0.05),
                            borderRadius: BorderRadius.circular(12),
                            border: const Border(left: BorderSide(color: primaryColor, width: 4)),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  const CircleAvatar(
                                    radius: 10,
                                    backgroundColor: primaryColor,
                                    child: Icon(Icons.person, size: 12, color: Colors.white),
                                  ),
                                  const SizedBox(width: 8),
                                  Text("Dr. Notes", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey[700])),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Text(
                                "\"${report['doctorNote']}\"",
                                style: const TextStyle(height: 1.5, fontSize: 14, color: Colors.black87, fontStyle: FontStyle.italic),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  // دالة مساعدة لبناء الإحصائيات في البطاقة العلوية
  Widget _buildStatItem(String label, String value, Color valueColor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(value, style: TextStyle(color: valueColor, fontSize: 20, fontWeight: FontWeight.bold)),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(color: Colors.white70, fontSize: 12)),
      ],
    );
  }
}