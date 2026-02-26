import 'package:flutter/material.dart';

class TherapistExercisesScreen extends StatefulWidget {
  const TherapistExercisesScreen({super.key});

  @override
  State<TherapistExercisesScreen> createState() => _TherapistExercisesScreenState();
}

class _TherapistExercisesScreenState extends State<TherapistExercisesScreen> {
  String selectedCategory = 'All';

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
    final bgColor = theme.scaffoldBackgroundColor;
    final cardColor = theme.cardTheme.color;

    return   Expanded(
            child: Column(
              children: [
                // (Top Bar)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                  color: cardColor,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 300,
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: "Search exercises...",
                            prefixIcon: const Icon(Icons.search),
                            contentPadding: const EdgeInsets.symmetric(vertical: 0),
                            fillColor: bgColor,
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          IconButton(icon: const Icon(Icons.notifications_none), onPressed: () {}),
                          const SizedBox(width: 20),
                          const CircleAvatar(backgroundColor: Colors.cyan, child: Text("Dr", style: TextStyle(color: Colors.white))),
                        ],
                      )
                    ],
                  ),
                ),

                // ب. محتوى مكتبة التمارين (مغلف بـ Expanded لمنع الأخطاء)
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(32.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // الرأس وزر الإضافة
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Exercises Library", style: theme.textTheme.displayMedium),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.2,
                              child: ElevatedButton.icon(
                                onPressed: () {},
                                icon: const Icon(Icons.add),
                                label: const Text("Create New Exercise"),
                                style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                ),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(height: 30),

                        // الفلاتر
                        Row(
                          children: [
                            _buildCategoryChip("All"),
                            const SizedBox(width: 12),
                            _buildCategoryChip("Full Hand"),
                            const SizedBox(width: 12),
                            _buildCategoryChip("Fingers"),
                            const SizedBox(width: 12),
                            _buildCategoryChip("Wrist"),
                          ],
                        ),
                        const SizedBox(height: 30),

                        // Grid View
                        Expanded(
                          child: _buildExercisesGrid(),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
        //],
      //),
    );
  }

  // دالة بناء شبكة التمارين
  Widget _buildExercisesGrid() {
    final filteredExercises = selectedCategory == 'All'
        ? exercises
        : exercises.where((e) => e['category'] == selectedCategory).toList();

    if (filteredExercises.isEmpty) {
      return const Center(child: Text("No exercises found."));
    }

    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 320,
        childAspectRatio: 0.85,
        crossAxisSpacing: 24,
        mainAxisSpacing: 24,
      ),
      itemCount: filteredExercises.length,
      itemBuilder: (context, index) {
        return _buildExerciseCard(filteredExercises[index]);
      },
    );
  }

  // دالة بناء زر القائمة الجانبية
  Widget _buildMenuItem(IconData icon, String title, bool isActive, {bool isRed = false}) {
    final theme = Theme.of(context);
    final primaryColor = theme.primaryColor;
    final textColor = isRed ? Colors.redAccent : (isActive ? primaryColor : theme.textTheme.bodyMedium?.color);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: isActive ? BoxDecoration(color: primaryColor.withOpacity(0.1), borderRadius: BorderRadius.circular(10)) : null,
      child: ListTile(
        leading: Icon(icon, color: textColor),
        title: Text(title, style: TextStyle(color: textColor, fontWeight: isActive ? FontWeight.bold : FontWeight.normal)),
        onTap: () {}, // يمكنك إضافة التنقل هنا لاحقاً
      ),
    );
  }

  // دالة الفلتر
  Widget _buildCategoryChip(String label) {
    bool isSelected = selectedCategory == label;
    final theme = Theme.of(context);
    return ChoiceChip(
      label: Text(label, style: TextStyle(color: isSelected ? Colors.white : theme.textTheme.bodyMedium?.color, fontWeight: isSelected ? FontWeight.bold : FontWeight.normal)),
      selected: isSelected,
      selectedColor: theme.primaryColor,
      backgroundColor: theme.cardTheme.color,
      side: BorderSide(color: isSelected ? theme.primaryColor : Colors.grey.withOpacity(0.2)),
      onSelected: (bool selected) => setState(() => selectedCategory = label),
    );
  }

  // دالة بطاقة التمرين
  Widget _buildExerciseCard(Map<String, dynamic> exercise) {
    final theme = Theme.of(context);
    Color diffColor = exercise['difficulty'] == 'Easy' ? Colors.green : (exercise['difficulty'] == 'Medium' ? Colors.orange : Colors.red);

    return Container(
      decoration: BoxDecoration(
        color: theme.cardTheme.color,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.withOpacity(0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            flex: 3,
            child: Container(
              decoration: BoxDecoration(color: theme.primaryColor.withOpacity(0.05), borderRadius: const BorderRadius.vertical(top: Radius.circular(16))),
              child: Icon(exercise['icon'], size: 60, color: theme.primaryColor),
            ),
          ),
          Expanded(
            flex: 4,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(color: diffColor.withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
                        child: Text(exercise['difficulty'], style: TextStyle(color: diffColor, fontSize: 11, fontWeight: FontWeight.bold)),
                      ),
                      const SizedBox(height: 12),
                      Text(exercise['title'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                      const SizedBox(height: 6),
                      Text(exercise['desc'], style: TextStyle(color: Colors.grey[600], fontSize: 13), maxLines: 2, overflow: TextOverflow.ellipsis),
                    ],
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: () {},
                      style: OutlinedButton.styleFrom(side: BorderSide(color: theme.primaryColor), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
                      child: Text("Assign to Patient", style: TextStyle(color: theme.primaryColor)),
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