import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_glove/features/patient/models/patient.dart';
import 'package:smart_glove/features/therapist/providers/patient_data_provider.dart';
import 'package:smart_glove/features/therapist/screens/therapist_dashboard/widgets/patient_row.dart';

class buildPatientsTable extends StatelessWidget {
   buildPatientsTable({super.key});
  @override
  Widget build(BuildContext context) {
    final List<Patient> patients = context
        .watch<PatientDataProvider>()
        .searchPatients(context.watch<PatientDataProvider>().searchQuery);

 /*   final filteredPatients = patients.where((p) {
      return p['name'].toString().toLowerCase().contains(
        _searchQuery.toLowerCase(),
      ) ||
          p['id'].toString().toLowerCase().contains(_searchQuery.toLowerCase());
    }).toList();*/
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
              child: patients.isEmpty
                  ? const Center(child: Text("No patients found."))
                  : ListView.separated(
                itemCount: patients.length,
                separatorBuilder: (context, index) =>
                const Divider(height: 1),
                itemBuilder: (context, index) {
                  return buildPatientRow(patients[index], theme,context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
