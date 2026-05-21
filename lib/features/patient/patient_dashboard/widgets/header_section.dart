import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_glove/features/patient/providers/glove_provider.dart';
import 'package:smart_glove/features/patient/providers/patient_provider.dart';
import 'battery_status.dart';

class HeaderSection extends StatelessWidget {


   HeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
   /* final patientProvider = context.watch<PatientProvider>();
    context.read<PatientProvider>().fetchPatientData("patientId");
    final gloveProvider = context.watch<GloveProvider>();*/
    final gloveProvider = Provider.of<GloveProvider>(context);
    final patientProvider = Provider.of<PatientProvider>(context);
    final theme = Theme.of(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Hello Again, ${patientProvider.currentPatient?.name ?? 'Guest'} 👋",
              style: theme.textTheme.displayMedium,
            ),
            Text(
              "Ready to make some progress today?",
              style: theme.textTheme.bodyMedium,
            ),
          ],
        ),
        // Glove Connection Status & Battery Indicator
        GloveBatteryStatus(batteryLevel: gloveProvider.status.battery),
      ],
    );
  }
}