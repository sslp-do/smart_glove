import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_glove/core/providers/theme_provider.dart';
import 'package:smart_glove/features/patient/my_reports/screen/my_reports.dart';
import 'package:smart_glove/features/patient/patient_dashboard/screens/patient_dashboard.dart';
import 'package:smart_glove/features/patient/settings/screen/settings.dart';
import 'package:smart_glove/features/therapist/therapist_dashboard/screen/therapist_dashboard.dart';
import 'package:smart_glove/features/therapist/therapist_feedback/screen/therapist_feedback.dart';
import 'package:smart_glove/ui/login/screen/login.dart';
import 'package:smart_glove/ui/splash_screen/screen/splash_screen.dart';
import 'package:window_manager/window_manager.dart';
import 'core/providers/navigation_provider.dart';
import 'core/theme/app_colors.dart';

void main() async {
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
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => NavigationProvider()),
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
      ],
      child: const Application(),
    ),
  );
}
class Application extends StatelessWidget {
  const Application({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: context.watch<ThemeProvider>().themeMode,
      home: LoginScreen(), //* SplashScreen(),*//*
    );
  }
}

