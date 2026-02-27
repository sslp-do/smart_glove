import 'package:flutter/material.dart';
import 'package:smart_glove/features/patient/my_reports/screen/my_reports.dart';
import 'package:smart_glove/features/patient/patient_overview/screen/patient_overview.dart';

class MainContent extends StatefulWidget {
  String routeName;

  MainContent({super.key, required this.routeName});

  @override
  State<MainContent> createState() => _MainContentState(routeName);
}

class _MainContentState extends State<MainContent> {
  String routeName = "overview";

  _MainContentState(this.routeName);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(32.0),
        child: (routeName == "overview")
            ? PatientOverview()
            : PatientReportsScreen(),
      ),
    );
  }
}
