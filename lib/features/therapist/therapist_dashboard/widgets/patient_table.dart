import 'package:flutter/material.dart';
import 'package:smart_glove/features/therapist/therapist_dashboard/widgets/patient_row.dart';

class buildPatientsTable extends StatelessWidget {
   buildPatientsTable({super.key});
  final List<Map<String, dynamic>> patients = [
    {
      "id": "#PT-1042",
      "name": "Sarah Connor",
      "condition": "Post-Stroke (Left Hand)",
      "progress": 0.75,
      "status": "Active",
    },
    {
      "id": "#PT-1043",
      "name": "Ahmad Ali",
      "condition": "Carpal Tunnel Syndrome",
      "progress": 0.40,
      "status": "Needs Review",
    },
    {
      "id": "#PT-1044",
      "name": "Layla Omar",
      "condition": "Fracture Recovery (Right)",
      "progress": 0.90,
      "status": "Completed",
    },
    {
      "id": "#PT-1045",
      "name": "John Doe",
      "condition": "Tendon Repair",
      "progress": 0.20,
      "status": "Active",
    },
    {
      "id": "#PT-1046",
      "name": "Mona Zaki",
      "condition": "Arthritis Management",
      "progress": 0.55,
      "status": "Active",
    },
  ];
   String _searchQuery = "";
  @override
  Widget build(BuildContext context) {
    final filteredPatients = patients.where((p) {
      return p['name'].toString().toLowerCase().contains(
        _searchQuery.toLowerCase(),
      ) ||
          p['id'].toString().toLowerCase().contains(_searchQuery.toLowerCase());
    }).toList();
     final theme = Theme.of(context);
    final cardColor = theme.cardTheme.color ?? Colors.white;
    return Expanded(
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
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(16),
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Text(
                      "Patient",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[600],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(
                      "Condition",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[600],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(
                      "Recovery Progress",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[600],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Text(
                      "Action",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[600],
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
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
                separatorBuilder: (context, index) =>
                const Divider(height: 1),
                itemBuilder: (context, index) {
                  return buildPatientRow(filteredPatients[index], theme);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
