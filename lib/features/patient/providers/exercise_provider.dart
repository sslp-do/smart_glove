import 'package:flutter/cupertino.dart';
import 'package:smart_glove/features/patient/models/exercise_model.dart';
import 'package:smart_glove/features/patient/models/fingerdata.dart';

class ExerciseProvider with ChangeNotifier {
  List<Exercise> _exercises = [];

  List<Exercise> get exercises => _exercises;

  Future<void> loadExercises() async {
    // جلب التمارين من الفايربيز
    // _availableExercises = await _exerciseRepository.getExercises();
    notifyListeners();
  }

  // الفلتر المختار حالياً (الافتراضي الكل)
  String _selectedCategory = "All";

  String get selectedCategory => _selectedCategory;

  // قائمة التمارين التجريبية المكتملة بناءً على واجهتكِ
  final List<Exercise> _allExercises = [
    Exercise(
      id: "ex_01",
      name: "Full Fist Grip",
      description: "Improves overall grip strength and hand closing mechanics.",
      difficulty: "Easy",
      category: "Full Hand",
      duration: 30,
      targetData: FingerData(
        thumb: 80,
        index: 85,
        middle: 85,
        ring: 80,
        little: 75,
      ),
      // نسب ثني عالية للقبضة
      targetRepetitions: 10,
      tutorialImageUrl:
          "https://s.sharecare.com/img/profile/4/2/5/42521235-336b-4747-8dff-807cca0d7b42.png",
    ),
    Exercise(
      id: "ex_02",
      name: "Finger Extension",
      description:
          "Stretches the flexor tendons and promotes individual digit opening.",
      difficulty: "Medium",
      category: "Fingers",
      duration: 45,
      targetData: FingerData(
        thumb: 10,
        index: 5,
        middle: 5,
        ring: 5,
        little: 10,
      ),
      // نسب منخفضة تعني فرد كامل
      targetRepetitions: 12,
      tutorialImageUrl:
          "https://go.chasingstrength.com/wp-content/uploads/2023/09/finger-extensions-band-1.jpg",
    ),
    Exercise(
      id: "ex_03",
      name: "Pinch Strength Test",
      description:
          "Focuses on fine motor coordination between thumb and index finger.",
      difficulty: "Medium",
      category: "Fingers",
      duration: 20,
      targetData: FingerData(
        thumb: 70,
        index: 75,
        middle: 10,
        ring: 10,
        little: 10,
      ),
      // الإبهام والسبابة فقط مقبوضان
      targetRepetitions: 8,
      tutorialImageUrl:
          "https://domf5oio6qrcr.cloudfront.net/medialibrary/15929/hnd18-threejawpinch.jpg",
    ),
    Exercise(
      id: "ex_04",
      name: "Wrist Rotation Stretch",
      description:
          "Increases wrist mobility and circumduction range of motion.",
      difficulty: "Hard",
      category: "Wrist",
      duration: 60,
      targetData: FingerData(
        thumb: 20,
        index: 20,
        middle: 20,
        ring: 20,
        little: 20,
      ),
      // اليد مفرودة لتركيز الحركة على المعصم
      targetRepetitions: 5,
      tutorialImageUrl:
          "https://th.bing.com/th/id/OIP.WvOF4LBTf4I-7Siw474-hAHaEK?w=332&h=187&c=7&r=0&o=7&dpr=1.3&pid=1.7&rm=3",
    ),
    Exercise(
      id: "ex_05",
      name: "Claw Cup Hold",
      description:
          "Simulates grasping spherical objects to enhance functional daily life tasks.",
      difficulty: "Easy",
      category: "Full Hand",
      duration: 40,
      targetData: FingerData(
        thumb: 45,
        index: 50,
        middle: 50,
        ring: 45,
        little: 40,
      ),
      // ثني متوسط يحاكي مسك الكوب
      targetRepetitions: 15,
      tutorialImageUrl:
          "https://illnessaid.com/wp-content/uploads/2022/05/BALL-GRIP.jpg",
    ),
  ];

  // دالة الـ Getter الذكية التي تقرأها الواجهة لعرض الكروت المفلترة فقط
  List<Exercise> get filteredExercises {
    if (_selectedCategory == "All") {
      return _allExercises;
    }
    return _allExercises
        .where((exercise) => exercise.category == _selectedCategory)
        .toList();
  }

  // دالة لتغيير الفلتر عند ضغط المعالج على الأزرار العلوية
  void setCategory(String category) {
    _selectedCategory = category;
    notifyListeners(); // تنبيه الـ GridView لإعادة بناء الكروت فوراً
  }
}
