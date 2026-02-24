// =========================================================
// 4. جدول المرضى النشطين مع ميزة الفرز (Active Patients Table)
// =========================================================

import 'package:flutter/material.dart';

class ActivePatientsTable extends StatefulWidget {
  const ActivePatientsTable({super.key});

  @override
  State<ActivePatientsTable> createState() => _ActivePatientsTableState();
}

class _ActivePatientsTableState extends State<ActivePatientsTable> {
  // 1. تحديد الفلتر النشط حالياً (الافتراضي: عرض الكل)
  String selectedFilter = 'All';

  // 2. بيانات تجريبية للمرضى مع حالات مختلفة (Critical, Plateau, Improving)
  final List<Map<String, dynamic>> patients = [
    {"name": "Sarah Connor", "hand": "Left Hand", "time": "2 hours ago", "status": "Improving"},
    {"name": "Ahmad Ali", "hand": "Right Hand", "time": "3 days ago", "status": "Critical"},
    {"name": "Layla Omar", "hand": "Right Hand", "time": "Yesterday", "status": "Improving"},
    {"name": "John Doe", "hand": "Left Hand", "time": "1 week ago", "status": "Plateau"},
    {"name": "Mona Zaki", "hand": "Right Hand", "time": "Just now", "status": "Improving"},
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // 3. تصفية القائمة بناءً على الزر المختار
    final filteredPatients = selectedFilter == 'All'
        ? patients
        : patients.where((p) => p['status'] == selectedFilter).toList();

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: theme.cardTheme.color,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.withOpacity(0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ---- العنوان وأزرار الفرز (Filters) ----
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Patients Triage", style: theme.textTheme.titleLarge),

              // أزرار الفرز (Filter Chips)
              Row(
                children: [
                  _buildFilterChip("All", Colors.blue),
                  const SizedBox(width: 8),
                  _buildFilterChip("Critical", Colors.red),
                  const SizedBox(width: 8),
                  _buildFilterChip("Plateau", Colors.orange),
                  const SizedBox(width: 8),
                  _buildFilterChip("Improving", Colors.green),
                ],
              )
            ],
          ),

          const SizedBox(height: 20),

          // ---- جدول المرضى ----
          filteredPatients.isEmpty
              ? const Padding(
            padding: EdgeInsets.all(40.0),
            child: Center(child: Text("No patients found in this category.")),
          )
              : ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(), // لأننا داخل ScrollView آخر
            itemCount: filteredPatients.length,
            separatorBuilder: (context, index) => Divider(color: Colors.grey.withOpacity(0.1)),
            itemBuilder: (context, index) {
              final patient = filteredPatients[index];

              // تحديد لون الحالة بناءً على النص
              Color statusColor;
              if (patient['status'] == 'Critical') statusColor = Colors.red;
              else if (patient['status'] == 'Plateau') statusColor = Colors.orange;
              else statusColor = Colors.green;

              return InkWell(
                onTap: () {
                  // فتح اللوحة الجانبية عند الضغط على المريض
                  Scaffold.of(context).openEndDrawer();
                },
                hoverColor: theme.primaryColor.withOpacity(0.05),
                borderRadius: BorderRadius.circular(8),
                child: ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  leading: CircleAvatar(
                    backgroundColor: statusColor.withOpacity(0.1),
                    child: Icon(Icons.person, color: statusColor), // لون الأيقونة يطابق الحالة
                  ),
                  title: Text(patient['name'], style: const TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text("Last active: ${patient['time']} • ${patient['hand']}"),
                  trailing: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: statusColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: statusColor.withOpacity(0.3)),
                    ),
                    child: Text(
                      patient['status'],
                      style: TextStyle(color: statusColor, fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  // دالة مساعدة لبناء أزرار الفرز بشكل أنيق
  Widget _buildFilterChip(String label, Color color) {
    bool isSelected = selectedFilter == label;
    return ChoiceChip(
      label: Text(
        label,
        style: TextStyle(
          color: isSelected ? Colors.white : Colors.grey[700],
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          fontSize: 12,
        ),
      ),
      selected: isSelected,
      selectedColor: color,
      backgroundColor: Colors.grey.withOpacity(0.1),
      showCheckmark: false, // إخفاء علامة الصح لشكل أنظف
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      side: BorderSide(color: isSelected ? color : Colors.transparent),
      onSelected: (bool selected) {
        setState(() {
          selectedFilter = label; // تحديث الفلتر عند الضغط
        });
      },
    );
  }
}