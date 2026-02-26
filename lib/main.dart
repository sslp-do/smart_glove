import 'package:flutter/material.dart';
import 'package:smart_glove/features/therapist/therapist_dashboard/screen/therapist_dashboard.dart';
import 'package:smart_glove/features/therapist/therapist_feedback/screen/therapist_feedback.dart';
import 'package:window_manager/window_manager.dart';
import 'core/theme/app_colors.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await windowManager.ensureInitialized();

  WindowOptions windowOptions = const WindowOptions(
    size: Size(1200, 800),
    minimumSize: Size(950, 600),
    center: true,
    title: "Rehab Glove",
  );

  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.show();
    await windowManager.focus();
  });

  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      home: const TherapistDashboard(),
    ),
  );
}