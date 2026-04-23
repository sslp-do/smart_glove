import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_glove/core/providers/navigation_provider.dart';
import 'package:smart_glove/features/patient/my_reports/screen/my_reports.dart';
import 'package:smart_glove/features/patient/patient_overview/screen/patient_overview.dart';
import 'package:smart_glove/features/patient/settings/screen/settings.dart';

class MainContent extends StatelessWidget {

 const MainContent({super.key,});

  @override
  Widget build(BuildContext context) {
    String routeName = context.watch<NavigationProvider>().currentRoute;
    return
    Container(
         padding: EdgeInsets.symmetric(horizontal: 30,vertical: 20),
   // color: Colors.red,
      child:
         _buildBody(routeName)
    );
  }
}

Widget _buildBody(String routeName) {
    switch (routeName) {
      case "overview":
        return const PatientOverview();
      case "my_reports":
        return const PatientReportsScreen();case "settings":
        return const PatientSettings();
      default:
        return const PatientOverview();
    }
  }

