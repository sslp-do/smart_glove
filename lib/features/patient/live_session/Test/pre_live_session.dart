import 'package:flutter/material.dart';

class PremiumLiveSessionPage extends StatelessWidget {
  const PremiumLiveSessionPage({super.key});

  @override
  Widget build(BuildContext context) {
    double currentProgress = 0.75; // يتم ربطها ببيانات القفاز (JSON)

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.teal.shade50, Colors.white, Colors.blue.shade50],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              _buildAppBar(context),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      _buildExerciseVisuals(),
                      const SizedBox(height: 40),
                      _buildTimerSection(),
                      const SizedBox(height: 40),
                      _buildGlowProgress(currentProgress),
                      const SizedBox(height: 40),
                      _buildSmartInisght(currentProgress),
                      const SizedBox(height: 60),
                      _buildModernFinishButton(context),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // 1. ترويسة أنيقة وشفافة
  Widget _buildAppBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back_ios_new, size: 20),
            onPressed: () => Navigator.pop(context),
          ),
          const Column(
            children: [
              Text("Fist Grip Exercise", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              Text("الجلسة الثالثة", style: TextStyle(color: Colors.teal, fontSize: 12, fontWeight: FontWeight.w600)),
            ],
          ),
          const Icon(Icons.bluetooth_connected, color: Colors.teal),
        ],
      ),
    );
  }

  // 2. مراحل التمرين بتصميم بطاقات زجاجية
  Widget _buildExerciseVisuals() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.5),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white, width: 2),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _stepIcon(Icons.pan_tool_outlined, "استعد", true),
          Icon(Icons.double_arrow_rounded, color: Colors.teal.shade200),
          _stepIcon(Icons.front_hand, "اضغط", false),
          Icon(Icons.double_arrow_rounded, color: Colors.teal.shade200),
          _stepIcon(Icons.back_hand, "اثبت", false),
        ],
      ),
    );
  }

  Widget _stepIcon(IconData icon, String label, bool active) {
    return Column(
      children: [
        CircleAvatar(
          radius: 25,
          backgroundColor: active ? Colors.teal : Colors.white,
          child: Icon(icon, color: active ? Colors.white : Colors.teal),
        ),
        const SizedBox(height: 8),
        Text(label, style: TextStyle(fontSize: 12, fontWeight: active ? FontWeight.bold : FontWeight.normal)),
      ],
    );
  }

  // 3. التايمر بشكل عصري
  Widget _buildTimerSection() {
    return Column(
      children: [
        const Text("04:20", style: TextStyle(fontSize: 64, fontWeight: FontWeight.w200, letterSpacing: -2)),
        Text("دقيقة متبقية", style: TextStyle(color: Colors.grey.shade600, letterSpacing: 1.2)),
      ],
    );
  }

  // 4. شريط التقدم المتوهج (Glowing Progress)
  Widget _buildGlowProgress(double progress) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("مدى اقترابك من الهدف", style: TextStyle(fontWeight: FontWeight.w600)),
            Text("${(progress * 100).toInt()}%", style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.teal)),
          ],
        ),
        const SizedBox(height: 15),
        Stack(
          children: [
            Container(
              height: 12,
              decoration: BoxDecoration(color: Colors.grey.shade200, borderRadius: BorderRadius.circular(10)),
            ),
            AnimatedContainer(
              duration: const Duration(milliseconds: 500),
              height: 12,
              width: 300 * progress, // تمثيل العرض بناءً على القيمة
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                gradient: const LinearGradient(colors: [Colors.tealAccent, Colors.teal]),
                boxShadow: [
                  BoxShadow(color: Colors.teal.withOpacity(0.4), blurRadius: 10, spreadRadius: 1)
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  // 5. رسالة ذكية في بطاقة ملونة
  Widget _buildSmartInisght(double progress) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.teal.shade900,
        borderRadius: BorderRadius.circular(20),
      ),
      child: const Row(
        children: [
          Icon(Icons.lightbulb_outline, color: Colors.amber, size: 28),
          SizedBox(width: 15),
          Expanded(
            child: Text(
              "أداء رائع! قوتك الآن ممتازة جداً، حاول الحفاظ على هذا المستوى لـ 5 ثوانٍ إضافية.",
              style: TextStyle(color: Colors.white, fontSize: 14, height: 1.4),
            ),
          ),
        ],
      ),
    );
  }

  // 6. زر الإنهاء الفاخر
  Widget _buildModernFinishButton(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 65,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(color: Colors.teal.withOpacity(0.3), blurRadius: 20, offset: const Offset(0, 10))
        ],
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: Colors.teal,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          elevation: 0,
        ),
        onPressed: () {},
        child: const Text("لقد أكملت تدريبي لليوم ✨", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
      ),
    );
  }
}