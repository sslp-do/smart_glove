import 'package:flutter/material.dart';
import 'package:smart_glove/features/patient/my_reports/screen/my_reports.dart';
import 'package:smart_glove/features/patient/patient_overview/screen/patient_overview.dart';
import 'package:smart_glove/features/patient/settings/screen/settings.dart';
import 'package:smart_glove/features/patient/test_page.dart';

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
