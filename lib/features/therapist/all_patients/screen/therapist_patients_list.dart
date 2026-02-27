import 'package:flutter/material.dart';

class AllPatientsScreen extends StatefulWidget {
  const AllPatientsScreen({super.key});

  @override
  State<AllPatientsScreen> createState() => _AllPatientsScreenState();
}

class _AllPatientsScreenState extends State<AllPatientsScreen> {
  // بيانات تجريبية للمرضى (Mock Data)
  final List<Map<String, dynamic>> _patients = [
    {"id": "#PT-1042", "name": "Sarah Connor", "condition": "Post-Stroke (Left Hand)", "progress": 0.75, "gloveStatus": "Online", "battery": 80, "status": "Active"},
    {"id": "#PT-1043", "name": "Ahmad Ali", "condition": "Carpal Tunnel Syndrome", "progress": 0.40, "gloveStatus": "Offline", "battery": 15, "status": "Needs Review"},
    {"id": "#PT-1044", "name": "Layla Omar", "condition": "Fracture Recovery (Right)", "progress": 0.90, "gloveStatus": "Offline", "battery": 100, "status": "Completed"},
    {"id": "#PT-1045", "name": "John Doe", "condition": "Tendon Repair", "progress": 0.20, "gloveStatus": "Online", "battery": 60, "status": "Active"},
    {"id": "#PT-1046", "name": "Mona Zaki", "condition": "Arthritis Management", "progress": 0.55, "gloveStatus": "Offline", "battery": 45, "status": "Active"},
  ];

  String _searchQuery = "";

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cardColor = theme.cardTheme.color ?? Colors.white;

    // تصفية المرضى بناءً على البحث
    final filteredPatients = _patients.where((p) {
      return p['name'].toString().toLowerCase().contains(_searchQuery.toLowerCase()) ||
          p['id'].toString().toLowerCase().contains(_searchQuery.toLowerCase());
    }).toList();

    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ==========================================
          // 1. الرأس وزر الإضافة
          // ==========================================
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("All Patients", style: theme.textTheme.displayMedium?.copyWith(fontSize: 28, fontWeight: FontWeight.bold)),
              Container(
                width: 150,
                child: ElevatedButton.icon(
                  onPressed: () {
                    // فتح نافذة إضافة مريض جديد
                  },
                  icon: const Icon(Icons.person_add),
                  label: const Text("Add New Patient"),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                ),
              )
            ],
          ),
          const SizedBox(height: 30),

          // ==========================================
          // 2. شريط البحث والفلاتر
          // ==========================================
          Row(
            children: [
              Expanded(
                flex: 2,
                child: TextField(
                  onChanged: (value) => setState(() => _searchQuery = value),
                  decoration: InputDecoration(
                    hintText: "Search by name or ID...",
                    prefixIcon: const Icon(Icons.search),
                    filled: true,
                    fillColor: cardColor,
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              _buildFilterDropdown("Status: All", cardColor),
              const SizedBox(width: 16),
              _buildFilterDropdown("Sort by: Recent", cardColor),
            ],
          ),
          const SizedBox(height: 30),

          // ==========================================
          // 3. جدول المرضى (Custom Table)
          // ==========================================
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: cardColor,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.grey.withOpacity(0.2)),
              ),
              child: Column(
                children: [
                  // رأس الجدول (Table Header)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.05),
                      borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                    ),
                    child: Row(
                      children: [
                        Expanded(flex: 3, child: Text("Patient", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey[600]))),
                        Expanded(flex: 2, child: Text("Condition", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey[600]))),
                        Expanded(flex: 2, child: Text("Glove IoT Status", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey[600]))),
                        Expanded(flex: 2, child: Text("Recovery Progress", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey[600]))),
                        Expanded(flex: 1, child: Text("Action", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey[600]), textAlign: TextAlign.center)),
                      ],
                    ),
                  ),
                  const Divider(height: 1),

                  // صفوف البيانات (Data Rows)
                  Expanded(
                    child: filteredPatients.isEmpty
                        ? const Center(child: Text("No patients found."))
                        : ListView.separated(
                      itemCount: filteredPatients.length,
                      separatorBuilder: (context, index) => const Divider(height: 1),
                      itemBuilder: (context, index) {
                        return _buildPatientRow(filteredPatients[index], theme);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------
  // دوال مساعدة
  // ---------------------------------------------------------

  // بناء القائمة المنسدلة للفلترة
  Widget _buildFilterDropdown(String hint, Color bgColor) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(color: bgColor, borderRadius: BorderRadius.circular(12)),
      child: Row(
        children: [
          Text(hint, style: const TextStyle(fontWeight: FontWeight.w500)),
          const SizedBox(width: 8),
          const Icon(Icons.keyboard_arrow_down, size: 20),
        ],
      ),
    );
  }

  // بناء صف المريض داخل الجدول
  Widget _buildPatientRow(Map<String, dynamic> patient, ThemeData theme) {
    final bool isOnline = patient['gloveStatus'] == 'Online';
    final bool isLowBattery = patient['battery'] <= 20;

    return InkWell(
      onTap: () {
        // الانتقال إلى شاشة تفاصيل المريض
      },
      hoverColor: theme.primaryColor.withOpacity(0.05),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Row(
          children: [
            // 1. المريض (الاسم والمعرف)
            Expanded(
              flex: 3,
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundColor: theme.primaryColor.withOpacity(0.1),
                    child: Text(patient['name'][0], style: TextStyle(color: theme.primaryColor, fontWeight: FontWeight.bold)),
                  ),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(patient['name'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                      const SizedBox(height: 4),
                      Text(patient['id'], style: TextStyle(color: Colors.grey[500], fontSize: 12)),
                    ],
                  ),
                ],
              ),
            ),

            // 2. الحالة الطبية
            Expanded(
              flex: 2,
              child: Text(patient['condition'], style: TextStyle(color: theme.textTheme.bodyMedium?.color)),
            ),

            // 3. حالة إنترنت الأشياء (القفاز)
            Expanded(
              flex: 2,
              child: Row(
                children: [
                  // نقطة الاتصال
                  Container(
                    width: 10, height: 10,
                    decoration: BoxDecoration(color: isOnline ? Colors.green : Colors.grey, shape: BoxShape.circle),
                  ),
                  const SizedBox(width: 8),
                  Text(patient['gloveStatus'], style: TextStyle(color: isOnline ? Colors.green : Colors.grey, fontWeight: FontWeight.bold, fontSize: 13)),
                  const SizedBox(width: 12),
                  // أيقونة البطارية
                  Icon(
                    isLowBattery ? Icons.battery_alert : Icons.battery_charging_full,
                    size: 16,
                    color: isLowBattery ? Colors.red : Colors.grey[600],
                  ),
                  const SizedBox(width: 4),
                  Text("${patient['battery']}%", style: TextStyle(fontSize: 12, color: isLowBattery ? Colors.red : Colors.grey[600])),
                ],
              ),
            ),

            // 4. شريط التقدم
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.only(right: 32.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("${(patient['progress'] * 100).toInt()}%", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                        Text(patient['status'], style: TextStyle(fontSize: 11, color: patient['status'] == 'Needs Review' ? Colors.orange : Colors.grey)),
                      ],
                    ),
                    const SizedBox(height: 8),
                    LinearProgressIndicator(
                      value: patient['progress'],
                      backgroundColor: Colors.grey.withOpacity(0.2),
                      color: patient['progress'] > 0.8 ? Colors.green : theme.primaryColor,
                      minHeight: 6,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ],
                ),
              ),
            ),

            // 5. الإجراءات (زر عرض الملف)
            Expanded(
              flex: 1,
              child: Align(
                alignment: Alignment.center,
                child: IconButton(
                  icon: const Icon(Icons.arrow_forward_ios, size: 16),
                  color: Colors.blue,
                  onPressed: () {
                    // فتح ملف المريض
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}