import 'package:flutter/material.dart';
import 'package:smart_glove/features/patient/screens/my_reports/screen/my_reports.dart';
import 'package:smart_glove/features/patient/screens/patient_overview/screen/patient_overview.dart';
import 'package:smart_glove/features/patient/screens/settings/screen/settings.dart';

Widget buildBody(String routeName) {
  switch (routeName) {
    case "overview":
      return const PatientOverview();
    case "my_reports":
      return const PatientReportsScreen();
    case "settings":
    // return const TestPage();
      return const PatientSettings();
    default:
      return const PatientOverview();
  }
}
