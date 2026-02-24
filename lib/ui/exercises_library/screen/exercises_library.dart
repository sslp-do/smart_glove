import 'package:flutter/material.dart';

class ExercisesLibraryScreen extends StatefulWidget {
  const ExercisesLibraryScreen({super.key});

  @override
  State<ExercisesLibraryScreen> createState() => _ExercisesLibraryScreenState();
}

class _ExercisesLibraryScreenState extends State<ExercisesLibraryScreen> {
  String selectedCategory = 'All';

  // بيانات تجريبية للتمارين (Mock Data)
  final List<Map<String, dynamic>> exercises = [
    {"title": "Full Fist Grip", "category": "Full Hand", "desc": "Improves overall grip strength.", "icon": Icons.back_hand, "difficulty": "Easy"},
    {"title": "Finger Extension", "category": "Fingers", "desc": "Stretches the flexor tendons.", "icon": Icons.pan_tool, "difficulty": "Medium"},
    {"title": "Wrist Rotation", "category": "Wrist", "desc": "Increases wrist mobility.", "icon": Icons.rotate_right, "difficulty": "Hard"},
    {"title": "Pinch Grip", "category": "Fingers", "desc": "Thumb and index finger coordination.", "icon": Icons.touch_app, "difficulty": "Medium"},
    {"title": "Thumb Flexion", "category": "Fingers", "desc": "Isolates thumb movement.", "icon": Icons.thumb_up, "difficulty": "Easy"},
    {"title": "Hand Spread", "category": "Full Hand", "desc": "Opens up the palm fully.", "icon": Icons.sign_language, "difficulty": "Easy"},
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // تصفية التمارين حسب الفئة
    final filteredExercises = selectedCategory == 'All'
        ? exercises
        : exercises.where((e) => e['category'] == selectedCategory).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ==========================================
        // 1. الرأس (Header) وشريط البحث
        // ==========================================
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Exercises Library", style: theme.textTheme.displayMedium),

            // زر إضافة تمرين جديد (الأهم للمعالج)
            ElevatedButton.icon(
              onPressed: () {
                // هنا يفتح نافذة (Dialog) لبرمجة تمرين جديد للقفاز
              },
              icon: const Icon(Icons.add),
              label: const Text("Create New Exercise"),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
            )
          ],
        ),
        const SizedBox(height: 20),

        // ==========================================
        // 2. الفلاتر (Categories)
        // ==========================================
        Row(
          children: [
            _buildCategoryChip("All"),
            const SizedBox(width: 10),
            _buildCategoryChip("Full Hand"),
            const SizedBox(width: 10),
            _buildCategoryChip("Fingers"),
            const SizedBox(width: 10),
            _buildCategoryChip("Wrist"),
          ],
        ),
        const SizedBox(height: 30),

        // ==========================================
        // 3. شبكة التمارين (Grid View)
        // ==========================================
        Expanded(
          child: filteredExercises.isEmpty
              ? const Center(child: Text("No exercises found."))
              : GridView.builder(
            // هذا السطر يحدد عرض البطاقة، ويزيد عدد الأعمدة تلقائياً إذا كبرت الشاشة
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 300, // أقصى عرض للبطاقة
              childAspectRatio: 0.85,  // نسبة الطول للعرض
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
            ),
            itemCount: filteredExercises.length,
            itemBuilder: (context, index) {
              final ex = filteredExercises[index];
              return _buildExerciseCard(context, ex);
            },
          ),
        ),
      ],
    );
  }

  // دالة بناء أزرار التصفية
  Widget _buildCategoryChip(String label) {
    bool isSelected = selectedCategory == label;
    final theme = Theme.of(context);
    return ChoiceChip(
      label: Text(label, style: TextStyle(color: isSelected ? Colors.white : theme.textTheme.bodyMedium?.color, fontWeight: isSelected ? FontWeight.bold : FontWeight.normal)),
      selected: isSelected,
      selectedColor: theme.primaryColor,
      backgroundColor: theme.cardTheme.color,
      side: BorderSide(color: isSelected ? theme.primaryColor : Colors.grey.withOpacity(0.2)),
      onSelected: (bool selected) {
        setState(() => selectedCategory = label);
      },
    );
  }

  // دالة بناء بطاقة التمرين
  Widget _buildExerciseCard(BuildContext context, Map<String, dynamic> exercise) {
    final theme = Theme.of(context);

    // تحديد لون الصعوبة
    Color diffColor;
    if (exercise['difficulty'] == 'Easy') diffColor = Colors.green;
    else if (exercise['difficulty'] == 'Medium') diffColor = Colors.orange;
    else diffColor = Colors.red;

    return Container(
      decoration: BoxDecoration(
        color: theme.cardTheme.color,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.withOpacity(0.1)),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 10)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // الجزء العلوي (الأيقونة والخلفية)
          Expanded(
            flex: 3,
            child: Container(
              decoration: BoxDecoration(
                color: theme.primaryColor.withOpacity(0.05),
                borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
              ),
              child: Icon(exercise['icon'], size: 60, color: theme.primaryColor),
            ),
          ),

          // الجزء السفلي (التفاصيل والأزرار)
          Expanded(
            flex: 4,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // شارة الصعوبة
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(color: diffColor.withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
                        child: Text(exercise['difficulty'], style: TextStyle(color: diffColor, fontSize: 10, fontWeight: FontWeight.bold)),
                      ),
                      const SizedBox(height: 8),
                      Text(exercise['title'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                      const SizedBox(height: 4),
                      Text(
                        exercise['desc'],
                        style: TextStyle(color: Colors.grey[600], fontSize: 12),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),

                  // زر "تعيين لمريض"
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: () {
                        // يفتح قائمة لاختيار المريض الذي سيوصف له هذا التمرين
                      },
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: theme.primaryColor),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                      child: Text("Assign to Patient", style: TextStyle(color: theme.primaryColor, fontSize: 12)),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}