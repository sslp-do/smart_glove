import 'package:flutter/material.dart';
import 'package:smart_glove/ui/dashboard/screens/dashboard.dart';
import 'core/theme/app_colors.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: const PatientDashboard(),
    ),
  );
}