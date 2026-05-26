import 'package:flutter/material.dart';
import 'dart:async';

class HemiplegiaSessionPage extends StatefulWidget {
  const HemiplegiaSessionPage({super.key});

  @override
  State<HemiplegiaSessionPage> createState() => _HemiplegiaSessionPageState();
}

class _HemiplegiaSessionPageState extends State<HemiplegiaSessionPage> {
  double currentGloveValue = 0.0;
  double targetValue = 100.0;

  // المؤقتات
  int sessionSeconds = 260; // 04:20
  int restCountdown = 30;
  bool isResting = false;
  bool isPaused = false;
  Timer? _mainTimer;

  @override
  void initState() {
    super.initState();
    _startSessionTimer();
    _simulateGloveData(); // محاكاة وصول بيانات JSON للاختبار
  }

  void _startSessionTimer() {
    _mainTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!isPaused && !isResting && sessionSeconds > 0) {
        setState(() => sessionSeconds--);
        if (sessionSeconds % 120 == 0 && sessionSeconds != 0) {
          _triggerRestPeriod();
        }
      }
    });
  }

  void _triggerRestPeriod() {
    setState(() => isResting = true);
    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (restCountdown > 0) {
        setState(() => restCountdown--);
      } else {
        timer.cancel();
        setState(() {
          isResting = false;
          restCountdown = 30;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double progress = (currentGloveValue / targetValue).clamp(0.0, 1.0);

    return Scaffold(
      backgroundColor: const Color(0xFFBFC6D3), // Deep Navy
      body: Stack(
        children: [
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  _buildHeader(),
                  const SizedBox(height: 20),
                  _buildTutorialSteps(), // مراحل التمرين بالصور
                  const Expanded(child: SizedBox()),
                  _buildMainGauge(progress), // عداد الهدف الدائري
                  const Expanded(child: SizedBox()),
                  _buildHintSection(progress), // التلميحات التحفيزية
                  const SizedBox(height: 20),
                  _buildControls(), // أزرار التحكم
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
          if (isResting) _buildRestOverlay(), // شاشة الراحة الإجبارية
        ],
      ),
    );
  }

  // 1. الترويسة والتايمر الرئيسي
  Widget _buildHeader() {
    int mins = sessionSeconds ~/ 60;
    int secs = sessionSeconds % 60;
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("تمرين القبضة", style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
              Text("مستوى النشاط: مرتفع", style: TextStyle(color: Colors.cyanAccent, fontSize: 12)),
            ],
          ),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: Colors.white10, borderRadius: BorderRadius.circular(15)),
            child: Text(
              "${mins.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}",
              style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  // 2. صور مراحل التمرين (Tutorial Steps)
  Widget _buildTutorialSteps() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _stepIcon(Icons.front_hand, "افتح يدك", true),
        const Icon(Icons.arrow_forward, color: Colors.white24),
        _stepIcon(Icons.pan_tool_alt, "اغلق ببطء", false),
        const Icon(Icons.arrow_forward, color: Colors.white24),
        _stepIcon(Icons.back_hand, "اضغط بقوة", false),
      ],
    );
  }

  Widget _stepIcon(IconData icon, String label, bool active) {
    return Column(
      children: [
        Icon(icon, color: active ? Colors.cyanAccent : Colors.white24, size: 30),
        const SizedBox(height: 8),
        Text(label, style: TextStyle(color: active ? Colors.white : Colors.white24, fontSize: 10)),
      ],
    );
  }

  // 3. عداد الهدف المركزي المتوهج (The Goal Ring)
  Widget _buildMainGauge(double progress) {
    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          width: 280, height: 280,
          child: CircularProgressIndicator(
            value: progress,
            strokeWidth: 15,
            backgroundColor: Colors.white.withOpacity(0.05),
            valueColor: const AlwaysStoppedAnimation<Color>(Colors.cyanAccent),
          ),
        ),
        // تأثير التوهج الخارجي
        Container(
          width: 240, height: 240,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(color: Colors.cyanAccent.withOpacity(0.1 * progress), blurRadius: 40, spreadRadius: 10)
            ],
          ),
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("${(progress * 100).toInt()}%", style: const TextStyle(color: Colors.white, fontSize: 64, fontWeight: FontWeight.w100)),
            const Text("من الهدف", style: TextStyle(color: Colors.cyanAccent, letterSpacing: 2)),
          ],
        ),
      ],
    );
  }

  // 4. قسم التلميحات التحفيزية (Hints)
  Widget _buildHintSection(double progress) {
    String hint = "ابدأ بضم أصابعك تدريجياً..";
    if (progress > 0.8) hint = "ممتاز! حافظ على هذا الضغط لثوانٍ";
    else if (progress > 0.4) hint = "أنت تقترب، اضغط بقوة أكبر قليلاً 💪";

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 500),
      child: Text(
        hint,
        key: ValueKey(hint),
        textAlign: TextAlign.center,
        style: const TextStyle(color: Colors.white70, fontSize: 16, fontStyle: FontStyle.italic),
      ),
    );
  }

  // 5. أزرار التحكم والإنهاء النفسي
  Widget _buildControls() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: ElevatedButton.icon(
                onPressed: () => setState(() => isPaused = !isPaused),
                icon: Icon(isPaused ? Icons.play_arrow : Icons.pause),
                label: Text(isPaused ? "استئناف" : "إيقاف مؤقت"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orangeAccent,
                  foregroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 15),
        SizedBox(
          width: double.infinity,
          child: TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("أنا انتهيت لهذا اليوم ✨", style: TextStyle(color: Colors.white60, fontSize: 16)),
          ),
        ),
      ],
    );
  }

  // 6. شاشة الراحة (Rest Overlay)
  Widget _buildRestOverlay() {
    return Container(
      color: Colors.black.withOpacity(0.9),
      width: double.infinity,
      height: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.coffee, color: Colors.cyanAccent, size: 80),
          const SizedBox(height: 20),
          const Text("وقت راحة قصير", style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          const Text("أرح يدك الآن لتجنب الإجهاد", style: TextStyle(color: Colors.white70)),
          const SizedBox(height: 40),
          Text("$restCountdown", style: const TextStyle(color: Colors.cyanAccent, fontSize: 60, fontWeight: FontWeight.bold)),
          const Text("ثانية متبقية", style: TextStyle(color: Colors.white38)),
        ],
      ),
    );
  }

  // محاكاة لبيانات القفاز (لأغراض العرض فقط)
  void _simulateGloveData() {
    Timer.periodic(const Duration(milliseconds: 500), (timer) {
      if (mounted && !isPaused && !isResting) {
        setState(() {
          currentGloveValue = (currentGloveValue + 5) % 110;
        });
      }
    });
  }

  @override
  void dispose() {
    _mainTimer?.cancel();
    super.dispose();
  }
}