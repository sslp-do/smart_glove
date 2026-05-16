import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_glove/Test/debug_page.dart';
import 'package:smart_glove/Test/stream_provider.dart';
import 'package:smart_glove/core/providers/alerts_provider.dart';
import 'package:smart_glove/core/providers/badges_provider.dart';
import 'package:smart_glove/core/providers/theme_provider.dart';
import 'package:smart_glove/features/patient/live_session/Test/pre_live_session.dart';
import 'package:smart_glove/features/patient/live_session/Test/test_live_session.dart';
import 'package:smart_glove/features/patient/live_session/screen/live_session.dart';
import 'package:smart_glove/features/patient/patient_dashboard/screens/patient_dashboard.dart';
import 'package:smart_glove/features/patient/providers/exercise_provider.dart';
import 'package:smart_glove/features/patient/providers/glove_provider.dart';
import 'package:smart_glove/features/patient/providers/history_provider.dart';
import 'package:smart_glove/features/patient/providers/patient_provider.dart';
import 'package:smart_glove/features/patient/providers/session_provider.dart';
import 'package:smart_glove/features/therapist/logic/category_provider.dart';
import 'package:smart_glove/ui/login/screen/login.dart';
import 'package:smart_glove/ui/splash_screen/screen/splash_screen.dart';
import 'package:window_manager/window_manager.dart';
import 'core/providers/navigation_provider.dart';
import 'core/theme/app_colors.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    print("Firebase Initialized Successfully");
  } catch (e) {
    print("Firebase Init Error: $e");
  }
   await windowManager.ensureInitialized();

  WindowOptions windowOptions = const WindowOptions(
    size: Size(1200, 800),
    minimumSize: Size(950, 600),
    center: true,
    title: "Smart Glove",
  );  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.show();
    await windowManager.focus();
  });

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => NavigationProvider()),
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
        ChangeNotifierProvider(create: (context) => AlertsProvider()),
        ChangeNotifierProvider(create: (context) => CategoryProvider()),
        ChangeNotifierProvider(create: (context) => TestMonitorProvider()),
        ChangeNotifierProvider(create: (context) => GloveProvider()),
        ChangeNotifierProvider(create: (context) => PatientProvider()),
        ChangeNotifierProvider(create: (context) => SessionProvider()),
        ChangeNotifierProvider(create: (context) => ExerciseProvider()),
        ChangeNotifierProvider(create: (context) => HistoryProvider()),
        ChangeNotifierProvider(create: (context) => BadgesProvider()),
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
      home: PatientDashboard(),  /*SplashScreen()*/
    );
  }
}
