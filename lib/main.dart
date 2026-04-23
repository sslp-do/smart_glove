import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_glove/features/patient/my_reports/screen/my_reports.dart';
import 'package:smart_glove/features/patient/patient_dashboard/screens/patient_dashboard.dart';
import 'package:smart_glove/features/patient/settings/screen/settings.dart';
import 'package:smart_glove/features/therapist/therapist_dashboard/screen/therapist_dashboard.dart';
import 'package:smart_glove/features/therapist/therapist_feedback/screen/therapist_feedback.dart';
import 'package:smart_glove/ui/splash_screen/screen/splash_screen.dart';
import 'package:window_manager/window_manager.dart';
import 'core/providers/navigation_provider.dart';
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
    ChangeNotifierProvider(
      create: (context) => NavigationProvider(),
      child:  MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: ThemeMode.system,
          home: TherapistDashboard()/* SplashScreen(),*/
      ),
    ),

  );
}